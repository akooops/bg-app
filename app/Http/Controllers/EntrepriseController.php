<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Department;
use App\Models\Entreprise;
use App\Models\RawMaterial;
use App\Models\Supplier;
use App\Models\Command;
use App\Models\Product;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;
use App\Events\CommandCreated;
use App\Traits\HelperTrait;
use App\Traits\DemandTrait;
use App\Traits\IndicatorTrait;
use App\Jobs\ProductionScheduler;
use App\Events\NewNotification;
use Carbon\Carbon;

class EntrepriseController extends Controller
{
    use HelperTrait, DemandTrait, IndicatorTrait;

    function showDashboard()
    {
        $departments = Department::all();
        return view("dashboard", ["departments" => $departments]);
    }

    // Departments view routes
    function showDptApprov(Request $request)
    {
        $raw_materials = RawMaterial::all();
        $suppliers = Supplier::all();
        $caisse = $this->getIndicator('caisse', auth()->user()->id)['value'];
        return view("departments.approv", [
            "materials" => $raw_materials, "suppliers" => $suppliers,
            "caisse" => $caisse
        ]);
    }

    // Departments view routes
    function showDptProduction(Request $request)
    {
        $products = Product::all();
        $products = $products->load('rawMaterials');
        $caisse = $this->getIndicator('caisse', auth()->user()->id)['value'];
        return view("departments.production", ["products" => $products, "caisse" => $caisse]);
    }

    function showCommandMaker(Request $request)
    {
        $raw_materials = RawMaterial::all();
        $suppliers = Supplier::all();
        $caisse = $this->getIndicator('caisse', auth()->user()->id)['value'];
        return view("departments.widgets.command_maker", [
            "materials" => $raw_materials,
            "suppliers" => $suppliers, "caisse" => $caisse
        ]);
    }

    function showStock(Request $request)
    {
        $products = Product::all()->toArray();
        return view("departments.widgets.stock");
    }

    function showMarketing(Request $request)
    {
        $products = Product::all();
        $caisse = $this->getIndicator('caisse', auth()->user()->id)["value"];
        $ad_coef = 0.8;
        return view("departments.marketing", [
            "products" => $products,
            "ad_coef" => $ad_coef, "caisse" => $caisse
        ]);
    }

    function showLoans(Request $request)
    {
        $caisse = $this->getIndicator('caisse', auth()->user()->id)["value"];
        return view('loans', ["caisse" => $caisse]);
    }

    function showFinance(Request $request)
    {
        $products = Product::all();
        $entreprises = Entreprise::all();
        return view("departments.finance", ["products" => $products, "entreprises" => $entreprises]);
    }

    function getProducts(Request $request)
    {
        $products = Product::with('rawMaterials')->get()->all();
        return $products;
    }

    function showHr(Request $request)
    {
        $caisse = $this->getIndicator('caisse', auth()->user()->id)["value"];
        return view("departments.hr", [
            "workshop_price" => nova_get_setting('workshop_price', ''),
            "salary" => nova_get_setting("salary_production", ''), "caisse" => $caisse
        ]);
    }

    function getEntrepriseCommands(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $command_items = Command::where("entreprise_id", "=", $entreprise_id)->get();
        $commands = $command_items->groupBy("command_id")->values()->toArray();
        //dd($commands);
        $commands_data = collect($commands)->map(function ($cmd) {
            $data = [
                "command_id" => $cmd[0]["command_id"],
                "created" => $cmd[0]["creation_date"],
                "num_items" => count($cmd),
                "status" => $this->getCommandStatus($cmd)
            ];
            $data["details"] = collect($cmd)->map(function ($item) {
                $material = RawMaterial::find($item["raw_material_id"]);
                //dd($item["raw_material_id"]);
                $supplier = Supplier::find($item["supplier_id"]);
                $quantity = $item["quantity"];
                $price = $item["price"];
                $phrase = $item["quantity"] . " unités " . " de " . $material->name . " Chez " . $supplier->name . ", Prix: " . $price . " DA / Status : " . $this->parseCommandStatus($item["status"]);

                return ["material" => $material->name, "unit" => $material->unit, "supplier" => $supplier->name, "quantity" => $quantity, "price" => $price, "status" => $item["status"], "phrase" => $phrase];
            });
            return $data;
        });
        $sorted_commands = $commands_data->sortByDesc("created");
        return $sorted_commands->toArray();
    }

    function getCommandStatus($cmd)
    {
        // check if all items in a command are pending or accepted
        $status_list = collect($cmd)->map(function ($item) {
            return $item["status"];
        })->toArray();

        $is_confirmed = $this->in_array_all("confirmed", $status_list);
        if ($is_confirmed) {
            return "confirmed";
        } else {
            return "pending";
        }
    }

    function createCommand(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $last_cmd = Command::latest()->first();
        $cmd_id = 0;
        if ($last_cmd != null) {
            $cmd_id = $last_cmd->command_id  + 1;
        }
        //dd($request->command);
        $command_items = [];
        for ($i = 0; $i < count($request["command"]); $i++) {

            $cmd =  $request["command"][$i];

            if ($cmd["quantity"] <= 0) {
                break;
            }

            //dd($cmd);
            $supplier_id = Supplier::where("name", $cmd["supplier"])->first()->id;
            $material_id = RawMaterial::where("name", $cmd["material"])->first()->id;
            $item_id = $cmd["item_id"];
            //dd($cmd_id);
            $cmd_item = [
                "command_id" => $cmd_id,
                "entreprise_id" => $entreprise_id,
                "supplier_id" => $supplier_id,
                "raw_material_id" => $material_id,
                "status" => "pending",
                "price" => $cmd["price"],
                "quantity" => $cmd["quantity"],
                "creation_date" => $this->getSimulationTime(),
                "item_id" => $item_id
            ];
            array_push($command_items, $cmd_item);
        }
        //dd($command_items);
        $command_items = collect($command_items);

        // Logic to split command into suppliers
        $supp_command_items = $command_items->groupBy("supplier_id");
        info($supp_command_items);

        $supp_command_items->map(function ($supp_cmd) use ($entreprise_id, $cmd_id) {
            // dd($supp_cmd[0]);
            $supplier_id = $supp_cmd[0]["supplier_id"];
            $command = [
                "id" => $cmd_id,
                "name" => Entreprise::find($entreprise_id)->name,
                "status" => "pending",
                "num_items" => count($supp_cmd),
                "creation_date" => $supp_cmd[0]["creation_date"]
            ];
            $supp_cmd->map(function ($supp_cmd_item) {
                Command::create($supp_cmd_item);
            });
            event(new CommandCreated($command, $supplier_id));
        });
        return Response::json(["message" => "Votre commande à été envoyée aux fournisseurs, vous serez redirigé vers le département d'approvisionnement dans 4 secondes."], 200);
    }

    public function getStock(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $stock = DB::table("raw_materials_stock")->where("entreprise_id", "=", $entreprise_id)->get();
        //dd($stock->empty());
        $data = collect([]);
        if ($stock->count() > 0) {
            $data = $stock->map(function ($item) {
                $material = RawMaterial::where("id", "=", $item->raw_material_id)->first();
                $item_data = [
                    "id" => $material->id,
                    "material" => $material->name,
                    "quantity" => $item->quantity
                ];
                return $item_data;
            });
        }
        return $data->toArray();
    }

    // Production functions

    public function getProdIndicators(Request $request)
    {
        // Return production useful indicators
        $keys = [
            "machines", "busy_machines", "machines_health", "nb_workers_prod", "ca",
            "reject_rate", "productivity_coeff", "dist_unit_cost"
        ];
        $entreprise_id = $request->entreprise_id;
        $resp = [];
        foreach ($keys as $ind) {
            $value = $this->getIndicator($ind, $entreprise_id);
            $resp[$ind] = $value;
        }
        return $resp;
    }

    public function launchProduction(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $product_id = $request->product_id;
        $quantity = $request->quantity * 100;
        $delay = $request->delay;
        $cost = $request->cost;
        $machines = $request->machines;
        $labor = $request->machines;
        $reject_rate = $this->getIndicator("reject_rate", $entreprise_id)["value"];
        $real_produced_quant = $quantity * (1 - $reject_rate);
        $production_data = [
            "entreprise_id" => $entreprise_id,
            "product_id" => $product_id,
            "quantity" => round($real_produced_quant),
            "finish_date" => now()->addSeconds($delay),
            "price" => $request->price,
            "cost" => $cost,
            "name" => "", // Bug, should be removed from DB
            "status" => "pending"
        ];
        $prod_id = DB::table("productions")->insertGetId($production_data);
        $this->updateIndicator("busy_machines", $entreprise_id, $machines);
        $prod_factors = [
            "machines" => $machines,
            "labor" => $labor
        ];
        ProductionScheduler::dispatch($production_data, $prod_id)
            ->delay(now()->addSeconds($delay));

        // Schedule production;
        return Response::json(["message" => "La production a été lancée !"], 200);
    }

    function getAllProductions(Request $request)
    {
        $productions = DB::table("productions")->where("entreprise_id", "=", $request->entreprise_id)->get();
        $productions = $productions->map(function ($p) {
            $product = Product::find($p->product_id);
            return [
                "id" => $p->id,
                "product" => $product->name,
                "price" => $p->price,
                "quantity" => $p->quantity,
                "status" => $this->parseProductionStatus($p->status),
                "status_code" => $p->status,
                "cost" => $p->cost,
                "sold" => $p->sold
            ];
        });
        return $productions->toArray();
    }

    function sellProd(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $product_id = $request->product_id;
        $dist_cost = $request->dist_cost;
        $sold_quantity = $request->sold;
        $price = $request->price;
        $stock_quantity = $request->stock;
        $production_id = $request->production_id;

        // Remove from stock and update production table
        DB::table("stock")->where("entreprise_id", "=", $entreprise_id)->where("product_id", "=", $product_id)->decrement("quantity", $sold_quantity);
        DB::table("productions")->where("id", "=", $production_id)->increment("sold", $sold_quantity);
        DB::table("products")->where("id", "=", $product_id)->decrement("left_demand", $sold_quantity);

        // Update indicators:
        // Increase caisse
        $sales = $sold_quantity * $price;
        $ca_key = "ca_" . $product_id;
        $profit_value = $sales - $dist_cost;
        $this->updateIndicator("caisse", $entreprise_id, $profit_value);
        $this->updateIndicator($ca_key, $entreprise_id, $sales);
        $this->updateIndicator("ca", $entreprise_id, $sales);
        $this->updateIndicator("dist_cost", $entreprise_id, $dist_cost);
        $message = "Vous avez vendu " . $sold_quantity . " unités et vous avez généré un chiffre d'affaires de " . $sales . " DA";
        $notification = [
            "type" => "ProductionSold",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Production Vendue"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message], 200);
    }

    // Machine functions
    public function buyMachine(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $buy_price = 10000;
        // update indicators

        $this->updateIndicator("caisse", $entreprise_id, -1 * $buy_price);
        $this->updateIndicator("machines", $entreprise_id, 1);
        $message = "Vous avez acheté une machine au prix de " . $buy_price . " DA";
        $notification = [
            "type" => "MachineBought",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Machine Achetée"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message], 200);
    }
    public function sellMachine(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $sell_price = 8000;
        $machines_health = $this->getIndicator("machines_health", $entreprise_id)["value"];
        $real_sell_price = $sell_price * $machines_health;
        // update indicators

        $this->updateIndicator("caisse", $entreprise_id, $real_sell_price);
        $this->updateIndicator("machines", $entreprise_id, -1);
        $message = "Vous avez vendu une machine au prix de " . $real_sell_price . " DA";
        $notification = [
            "type" => "MachineSold",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Machine Vendue"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message], 200);
    }

    public function applyProdAction(Request $request)
    {
        $type = $request->type;
        $price = $request->price;
        $entreprise_id = $request->entreprise_id;
        $message = "";
        switch ($type) {
            case '5s':
                $prod_coeff = $this->getIndicator("productivity_coeff", $entreprise_id)["value"];

                if ($prod_coeff >= 5) {
                    $message = "Vous ne pouvez plus augmenter votre taux de productivité, il est déja élevé !";
                } else {
                    $this->updateIndicator("caisse", $entreprise_id, -1 * $price);
                    $this->updateIndicator("productivity_coeff", $entreprise_id, 0.5);
                    $message = "Votre taux de productivité a augmenté !, vous pouvez produire plus rapidement.";
                }
                break;
            case 'audit':
                $reject_rate = $this->getIndicator("reject_rate", $entreprise_id)["value"];
                if ($reject_rate < 0.01) {
                    $message = "Vous ne pouvez plus réduire vos taux de rebuts.";
                } else {
                    $this->updateIndicator("reject_rate", $entreprise_id, -0.01);
                    $this->updateIndicator("caisse", $entreprise_id, -1 * $price);
                    $message = "Votre taux de rebut est maintenant plus faible.";
                }
                break;
            case 'maintenance':
                $machines_health = $this->getIndicator("machines_health", $entreprise_id)["value"];
                if ($machines_health > 0.9) {
                    $message = "Vous ne pouvez plus augmentez la fiabilité de vos machines, elle est assez faible !";
                } else {
                    $this->updateIndicator("machines_health", $entreprise_id, 0.05);
                    $this->updateIndicator("caisse", $entreprise_id, -1 * $price);
                    $message = "Vos machines sont maintenant plus fiables ! Vous pouvez les vendre plus chère.";
                }
                break;
        }
        $notification = [
            "type" => "Information",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Information"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message], 200);
    }
    /*
    public function getFinanceIndicators(Request $request){
        $keys = ["ca","caisse"];
        $entreprise_id = $request->entreprise_id;
        $resp = [];
        foreach ($keys as $ind) {
            $value = $this->getIndicator($ind,$entreprise_id);
            $resp[$ind] = $value;
        }
        return $resp;
    }
    */
    public function getRanking(Request $request)
    {
        $entreprises = Entreprise::all();
        $rankings = collect([]);
        foreach ($entreprises as $entrep) {
            $entreprise_id = $entrep->id;
            //dd($entreprise_id);
            $data = [
                "entreprise_name" => $entrep->name,
            ];
            $caisse = $this->getIndicator("caisse", $entreprise_id)["value"];
            $dettes = $this->getIndicator("dettes", $entreprise_id)["value"];
            $sf = $this->getIndicator("score_final", $entreprise_id)["value"];
            $profit = $caisse - $dettes;
            $data["profit"] = $profit;
            $data["score"] = $sf;
            $rankings->push($data);
        }
        $sorted = $rankings->sortByDesc("profit")->values();
        return ["list" => $sorted, "meta" => nova_get_setting("show_final_score", "")];
    }


    public function getNavbarData(Request $request)
    {
        $time = $this->getSimulationTime();
        if ($request->type == 'entreprise') {
            $caisse = $this->getIndicator("caisse", $request->entreprise_id)['value'];
            $dettes = $this->getIndicator("dettes", $request->entreprise_id)['value'];
        } else {
            $caisse = '';
            $dettes = '';
        }
        return ["time" => $time, "caisse" => $caisse, "dettes" => $dettes];
    }

    public function testFunc()
    {
        //$this->resetIndicator("busy_machines",1);
    }
}
