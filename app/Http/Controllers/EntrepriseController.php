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
            "salary_lv1" => nova_get_setting("salary_lv1"),
            "salary_lv2" => nova_get_setting("salary_lv2"),
            "bonus_coeff" => nova_get_setting("bonus_coeff"),
            "caisse" => $caisse
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
            "nb_machines_lv1", "nb_machines_lv2", "nb_machines_lv3",
            "nb_machines_lv1_busy", "nb_machines_lv2_busy", "nb_machines_lv3_busy",
            "machines_lv1_health", "machines_lv2_health", "machines_lv3_health",
            "nb_workers_lv1", "nb_workers_lv2",
            "nb_workers_lv1_busy", "nb_workers_lv2_busy",
            "workers_mood", "5s_day",
            "ca", "reject_rate", "productivity_coeff", "dist_unit_cost"
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
        $cost = $request->cost;

        // Check if enough money to launch prod
        $caisse = $this->getIndicator("caisse", $entreprise_id)["value"];
        if ($cost > $caisse) {
            $message = "Impossible de lancer la production: disponnibiltiés insuffisantes.";
            return Response::json(["message" => $message, "success" => false], 200);
        }

        $product_id = $request->product_id;

        // Check if enough raw materials to launch prod
        $product = DB::table("raw_materials_products")->where("product_id", "=", $product_id)->orderBy("raw_material_id")->get();
        $stock = DB::table("raw_materials_stock")->where("entreprise_id", "=", $entreprise_id)->orderBy("raw_material_id")->get();

        $quantity = $request->quantity * 100; // should be divided by 100 for nb lots

        for ($i = 0; $i < count($product); $i++) {
            if ($product[$i]->raw_material_id != $stock[$i]->raw_material_id) {
                continue;
            }

            if ($product[$i]->quantity * $request->quantity > $stock[$i]->quantity) {
                $message = "Pas assez de matière première " . $product[$i]->raw_material_id;
                return Response::json(["message" => $message, "success" => false], 200);
            }
        }

        $delay = $request->delay;

        // Check if enough free machines to launch prod
        $nb_machines_needed = $request->machines;

        $machines_lvl = $request->machines_lvl;

        $nb_machines = null;
        $nb_busy_machines = null;
        if ($machines_lvl == 1) {
            if ($this->getIndicator("machines_lv1_health", $entreprise_id) <= 0) {
                $message = "Impossible de lancer la production: veuillez réparer vos machines.";
                return Response::json(["message" => $message, "success" => false], 200);
            }

            $nb_machines = $this->getIndicator("nb_machines_lv1", $entreprise_id)["value"];
            $nb_busy_machines = $this->getIndicator("nb_machines_lv1_busy", $entreprise_id)["value"];
        } else if ($machines_lvl == 2) {
            if ($this->getIndicator("machines_lv2_health", $entreprise_id) <= 0) {
                $message = "Impossible de lancer la production: veuillez réparer vos machines.";
                return Response::json(["message" => $message, "success" => false], 200);
            }

            $nb_machines = $this->getIndicator("nb_machines_lv2", $entreprise_id)["value"];
            $nb_busy_machines = $this->getIndicator("nb_machines_lv2_busy", $entreprise_id)["value"];
        } else if ($machines_lvl == 3) {
            if ($this->getIndicator("machines_lv3_health", $entreprise_id) <= 0) {
                $message = "Impossible de lancer la production: veuillez réparer vos machines.";
                return Response::json(["message" => $message, "success" => false], 200);
            }

            $nb_machines = $this->getIndicator("nb_machines_lv3", $entreprise_id)["value"];
            $nb_busy_machines = $this->getIndicator("nb_machines_lv3_busy", $entreprise_id)["value"];
        }

        if ($nb_machines < $nb_machines_needed) {
            $message = "Impossible de lancer la production: Machines insuffisantes.";
            return Response::json(["message" => $message, "success" => false], 200);
        }

        if ($nb_machines - $nb_busy_machines < $nb_machines_needed) {
            $message = "Impossible de lancer la production: Machines libres insuffisantes.";
            return Response::json(["message" => $message, "success" => false], 200);
        }

        $labor = $request->labor;

        // Check if enough free workers to launch prod
        $nb_workers = null;
        $nb_busy_workers = null;

        $nb_workers_lv1 = $this->getIndicator("nb_workers_lv1", $entreprise_id)["value"];
        $nb_busy_workers_lv1 = $this->getIndicator("nb_workers_lv1_busy", $entreprise_id)["value"];

        $nb_workers_lv2 = $this->getIndicator("nb_workers_lv2", $entreprise_id)["value"];
        $nb_busy_workers_lv2 = $this->getIndicator("nb_workers_lv2_busy", $entreprise_id)["value"];

        $nb_workers_lv1_to_use = null;
        $nb_workers_lv2_to_use = null;

        if ($machines_lvl == 1 || $machines_lvl == 2) {
            $nb_workers = $nb_workers_lv1 + $nb_workers_lv2;
            $nb_busy_workers = $nb_busy_workers_lv1 + $nb_busy_workers_lv2;

            if ($nb_workers_lv1 - $nb_busy_workers_lv1 >= $labor) {
                $nb_workers_lv1_to_use = $labor;
                $nb_workers_lv2_to_use = 0;
            } else {
                $nb_workers_lv1_to_use = $nb_workers_lv1 - $nb_busy_workers_lv1;
                $nb_workers_lv2_to_use = $labor - ($nb_workers_lv1 - $nb_busy_workers_lv1);
            }
        } else if ($machines_lvl == 3) {
            $nb_workers = $nb_workers_lv2;
            $nb_busy_workers = $nb_busy_workers_lv2;

            $nb_workers_lv1_to_use = 0;
            $nb_workers_lv2_to_use = $labor;
        }

        if ($nb_workers - $nb_busy_workers < $labor) {
            $message = "Impossible de lancer la production: employés libres insuffisants.";
            return Response::json(["message" => $message, "success" => false], 200);
        }

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
            "status" => "pending",
            "machines_lv1" => $machines_lvl == 1 ? $nb_machines_needed : 0,
            "machines_lv2" => $machines_lvl == 2 ? $nb_machines_needed : 0,
            "machines_lv3" => $machines_lvl == 3 ? $nb_machines_needed : 0,
            "workers_lv1" => $nb_workers_lv1_to_use,
            "workers_lv2" => $nb_workers_lv2_to_use,
        ];

        // Add production to database
        $prod_id = DB::table("productions")->insertGetId($production_data);

        // Mark machines used as so in indicators
        if ($machines_lvl == 1) {
            $this->updateIndicator("nb_machines_lv1_busy", $entreprise_id, $nb_machines_needed);
        } else if ($machines_lvl == 2) {
            $this->updateIndicator("nb_machines_lv2_busy", $entreprise_id, $nb_machines_needed);
        } else if ($machines_lvl == 3) {
            $this->updateIndicator("nb_machines_lv3_busy", $entreprise_id, $nb_machines_needed);
        }

        // Mark employees used as so in indicators
        $this->updateIndicator("nb_workers_lv1_busy", $entreprise_id, $nb_workers_lv1_to_use);
        $this->updateIndicator("nb_workers_lv2_busy", $entreprise_id, $nb_workers_lv2_to_use);

        // Decrement stock of raw materials by quantity taken to produce this lot
        for ($i = 0; $i < count($product); $i++) {
            DB::table("raw_materials_stock")->where("entreprise_id", "=", $entreprise_id)
                ->where("raw_material_id", "=", $product[$i]->raw_material_id)
                ->decrement("quantity", $product[$i]->quantity * $request->quantity);
        }

        // Decrement caisse data before production ends
        $this->updateIndicator("caisse", $entreprise_id, -1 * $cost);
        // Increment production cost
        $this->updateIndicator("prod_cost", $entreprise_id, $cost);

        // Add delay to production
        ProductionScheduler::dispatch($production_data, $prod_id)
            ->delay(now()->addSeconds($delay));

        // Schedule production;
        return Response::json(["message" => "La production a été lancée !", "success" => true], 200);
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
        $production_id = $request->production_id;

        $production = DB::table("productions")->where("id", "=", $production_id)->first();
        $status = $production->status;
        if ($status == 'sold') {
            $message = "Vous avez déjà tout vendu pour la production" . $production_id . "";
            $notification = [
                "type" => "ProductionUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Production déjà vendue"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message], 200);
        }

        if ($status == 'selling') {
            $message = "La production " . $production_id . " est déjà en vente.";
            $notification = [
                "type" => "ProductionUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Production déjà vendue"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message], 200);
        }

        DB::table("productions")->where("id", "=", $production_id)->update(["status" => "selling"]);

        $message = "La production " . $production_id . " a été mise en vente.";
        $notification = [
            "type" => "ProductionUpdate",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Production mise en vente"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message], 200);

        /*$name = DB::table("products")->where("id", "=", $product_id)->first()->name;
        $production = DB::table("productions")->where("id", "=", $production_id)->first();
        $status = $production->status;

        if ($status == 'sold' || $production->sold >= $production->quantity) {
            $message = "Vous avez déjà tout vendu pour cette production.";
            $notification = [
                "type" => "ProductionUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Production déjà vendue"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message], 200);
        }

        $left_demand = DB::table("products")->where("id", "=", $product_id)->first()->left_demand;
        if ($left_demand <= 0) {
            $message = "Il n'y a plus de demande sur le produit" . $name . "pour l'instant.";
            $notification = [
                "type" => "ProductionUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Pas de demande"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message], 200);
        }

        // Remove from stock and update production table
        DB::table("stock")->where("entreprise_id", "=", $entreprise_id)->where("product_id", "=", $product_id)
            ->decrement("quantity", $sold_quantity);
        DB::table("productions")->where("id", "=", $production_id)->increment("sold", $sold_quantity);

        // Mark production as sold if no more in stock
        if ($stock_quantity <= 0) {
            DB::table("productions")->where("id", "=", $production_id)->update(["status" => "sold"]);
        }

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
        $message = "Vous avez vendu " . $sold_quantity . " unités de " . $name . " et vous avez généré un chiffre d'affaires de " . $sales . " DA";
        $notification = [
            "type" => "ProductionUpdate",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Production Vendue"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message], 200);*/
    }

    // Machine functions
    public function buyMachine(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $number = $request->number;
        $level = $request->level;

        $buy_price = null;

        if ($level == 1) {
            $buy_price = nova_get_setting("machines_lv1_price");
        } else if ($level == 2) {
            $buy_price = nova_get_setting("machines_lv2_price");
        } else if ($level == 3) {
            $buy_price = nova_get_setting("machines_lv3_price");
        }

        $caisse = $this->getIndicator("caisse", $entreprise_id)["value"];

        if ($buy_price * $number > $caisse) {
            $message = "Impossible d'acheter " . $number . " machine(s) de niveau " . $level . ": disponnibilités insuffisantes.";
            $notification = [
                "type" => "MachinesUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Echec de l'achat de machine"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message, "success" => false], 200);
        }

        $this->updateIndicator("caisse", $entreprise_id, -1 * $buy_price * $number);

        $health_msg = "";
        if ($level == 1) {
            $this->updateIndicator("nb_machines_lv1", $entreprise_id, $number);

            $machines_health = $this->getIndicator("machines_lv1_health", $entreprise_id)["value"];
            $nb_machines = $this->getIndicator("nb_machines_lv1", $entreprise_id)["value"];

            if (($nb_machines * $machines_health + $number) / ($nb_machines + 1) <= 1) {
                $this->setIndicator("machines_lv1_health", $entreprise_id, ($nb_machines * $machines_health + $number) / ($nb_machines + 1));
                $health_msg = "Santé des machines légèrement augmentée.";
            } else {
                $this->setIndicator("machines_lv1_health", $entreprise_id, 1);
            }
        } else if ($level == 2) {
            $this->updateIndicator("nb_machines_lv2", $entreprise_id, $number);

            $machines_health = $this->getIndicator("machines_lv2_health", $entreprise_id)["value"];
            $nb_machines = $this->getIndicator("nb_machines_lv2", $entreprise_id)["value"];

            if (($nb_machines * $machines_health + $number) / ($nb_machines + 1) <= 1) {
                $this->setIndicator("machines_lv2_health", $entreprise_id, ($nb_machines * $machines_health + $number) / ($nb_machines + 1));
                $health_msg = "Santé des machines légèrement augmentée.";
            } else {
                $this->setIndicator("machines_lv2_health", $entreprise_id, 1);
            }
        } else if ($level == 3) {
            $this->updateIndicator("nb_machines_lv3", $entreprise_id, $number);

            $machines_health = $this->getIndicator("machines_lv3_health", $entreprise_id)["value"];
            $nb_machines = $this->getIndicator("nb_machines_lv3", $entreprise_id)["value"];

            if (($nb_machines * $machines_health + $number) / ($nb_machines + 1) <= 1) {
                $this->setIndicator("machines_lv3_health", $entreprise_id, ($nb_machines * $machines_health + $number) / ($nb_machines + 1));
                $health_msg = "Santé des machines légèrement augmentée.";
            } else {
                $this->setIndicator("machines_lv3_health", $entreprise_id, 1);
            }
        }

        $message = "Vous avez acheté " . $number . " machine(s) de niveau " . $level . " au prix de " . $buy_price * $number . " DA. " . $health_msg;
        $notification = [
            "type" => "MachinesUpdate",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Machine Achetée"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message, "success" => true], 200);
    }

    public function sellMachine(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $number = $request->number;
        $level = $request->level;

        $nb_machines = null;
        $nb_busy_machines = null;
        $machines_health = null;

        if ($level == 1) {
            $nb_machines = $this->getIndicator("nb_machines_lv1", $entreprise_id)["value"];
            $nb_busy_machines = $this->getIndicator("nb_machines_lv1_busy", $entreprise_id)["value"];
            $machines_health = $this->getIndicator("machines_lv1_health", $entreprise_id)["value"];
        } else if ($level == 2) {
            $nb_machines = $this->getIndicator("nb_machines_lv2", $entreprise_id)["value"];
            $nb_busy_machines = $this->getIndicator("nb_machines_lv2_busy", $entreprise_id)["value"];
            $machines_health = $this->getIndicator("machines_lv2_health", $entreprise_id)["value"];
        } else if ($level == 3) {
            $nb_machines = $this->getIndicator("nb_machines_lv3", $entreprise_id)["value"];
            $nb_busy_machines = $this->getIndicator("nb_machines_lv3_busy", $entreprise_id)["value"];
            $machines_health = $this->getIndicator("machines_lv3_health", $entreprise_id)["value"];
        }

        if ($machines_health < 0.2) {
            $message = "Vous ne pouvez pas vendre des machines dont la santé est inférieure à 20%";
            $notification = [
                "type" => "MachinesUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Échec de la vente de machine"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message, "success" => false], 200);
        }

        if ($nb_machines - $number < 0) {
            $message = "Vous ne pouvez pas vendre " . $number . " machine(s) de niveau " . $level . ": Vous n'en avez pas autant.";
            $notification = [
                "type" => "MachinesUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Échec de la vente de machine"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message, "success" => false], 200);
        }

        if ($nb_machines - $nb_busy_machines < $number) {
            $message = "Vous ne pouvez pas vendre " . $number . " machine(s) de niveau " . $level . ": Les machines en production ne peuvent pas être venudes.";
            $notification = [
                "type" => "MachinesUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Échec de la vente de machine"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message, "success" => false], 200);
        }

        $buy_price = null;
        $sell_price = null;

        if ($level == 1) {
            $buy_price = nova_get_setting("machines_lv1_price");
            $sell_price = $buy_price * $this->getIndicator("machines_lv1_health", $entreprise_id)['value'];
        } else if ($level == 2) {
            $buy_price = nova_get_setting("machines_lv2_price");
            $sell_price = $buy_price * $this->getIndicator("machines_lv2_health", $entreprise_id)['value'];
        } else if ($level == 3) {
            $buy_price = nova_get_setting("machines_lv3_price");
            $sell_price = $buy_price * $this->getIndicator("machines_lv3_health", $entreprise_id)['value'];
        }

        $this->updateIndicator("caisse", $entreprise_id, $sell_price * $number);

        if ($level == 1) {
            $this->updateIndicator("nb_machines_lv1", $entreprise_id, -1 * $number);

            if ($this->getIndicator("nb_machines_lv1", $entreprise_id)["value"] == 0) {
                $this->setIndicator("machines_lv1_health", $entreprise_id, 1);
            }
        }
        else if ($level == 2) {
            $this->updateIndicator("nb_machines_lv2", $entreprise_id, -1 * $number);

            if ($this->getIndicator("nb_machines_lv2", $entreprise_id)["value"] == 0) {
                $this->setIndicator("machines_lv2_health", $entreprise_id, 1);
            }
        }
        else if ($level == 3) {
            $this->updateIndicator("nb_machines_lv3", $entreprise_id, -1 * $number);

            if ($this->getIndicator("nb_machines_lv3", $entreprise_id)["value"] == 0) {
                $this->setIndicator("machines_lv3_health", $entreprise_id, 1);
            }
        }

        $message = "Vous avez vendu " . $number . " machine(s) de niveau " . $level . " au prix de " . $sell_price * $number . " DA";
        $notification = [
            "type" => "MachinesUpdate",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Machine Vendue"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message, "success" => true], 200);
    }

    public function applyProdAction(Request $request)
    {
        $type = $request->type;
        $price = $request->price;
        $entreprise_id = $request->entreprise_id;

        $caisse = $this->getIndicator("caisse", $entreprise_id)["value"];
        if ($price > $caisse) {
            $message = "Impossible de lancer l'action: Disponnibilités insuffisantes.";
            $notification = [
                "type" => "ActionUpdate",
                "entreprise_id" => $entreprise_id,
                "message" => $message,
                "title" => "Échec de l'action"
            ];
            event(new NewNotification($notification));
            return Response::json(["message" => $message, "success" => false], 200);
        }

        $message = "Aucune action définie";
        switch ($type) {
            case '5s':
                $mood = $this->getIndicator("workers_mood", $entreprise_id)["value"];
                if ($mood < 0.5) {
                    $message = "Impossible de lancer les 5S: Vos employés manquent de motivation!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "5S"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                }

                $day_5s = $this->getIndicator("5s_day", $entreprise_id)["value"];

                if ($day_5s < 30) {
                    $message = "Impossible de relancer les 5S: Il vous en reste encore " . (30 - $day_5s) . " jour(s)!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "5S"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                }
                else {
                    $this->updateIndicator("caisse", $entreprise_id, -1 * $price);
                    $this->setIndicator("5s_day", $entreprise_id, 0);

                    $message = "Votre taux de productivité a augmenté, vous pouvez produire plus rapidement pendant 1 mois!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "5S"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => true], 200);
                }
                break;

            case 'audit':
                $reject_rate = $this->getIndicator("reject_rate", $entreprise_id)["value"];
                if ($reject_rate < 0.01) {
                    $message = "Vous ne pouvez plus réduire vos taux de rebuts.";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Audit"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                }
                else {
                    $this->updateIndicator("reject_rate", $entreprise_id, -0.01);
                    $this->updateIndicator("caisse", $entreprise_id, -1 * $price);

                    $message = "Votre taux de rebut est maintenant plus faible.";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Audit"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => true], 200);
                }
                break;
            case 'maintenance_lv1':
                $nb_machines = $this->getIndicator("nb_machines_lv1", $entreprise_id)["value"];
                if ($nb_machines <= 0) {
                    $message = "Vous n'avez pas de machines de niveau 1!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 1"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                }

                $machines_health = $this->getIndicator("machines_lv1_health", $entreprise_id)["value"];
                if ($machines_health > 0.9) {
                    $message = "Vos machines de niveau 1 sont en bon état, vous ne pouvez pas les réparer plus que ça!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 1"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                }
                else {
                    $this->setIndicator("machines_lv1_health", $entreprise_id, 0.9);
                    $this->updateIndicator("caisse", $entreprise_id, -1 * $price);

                    $message = "Vos machines de niveau 1 sont maintenant en meilleur état, vous pouvez les vendre plus cher!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 1"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => true], 200);
                }
                break;
            case 'maintenance_lv2':
                $nb_machines = $this->getIndicator("nb_machines_lv2", $entreprise_id)["value"];
                if ($nb_machines <= 0) {
                    $message = "Vous n'avez pas de machines de niveau 2!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 2"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                }

                $machines_health = $this->getIndicator("machines_lv2_health", $entreprise_id)["value"];
                if ($machines_health > 0.9) {
                    $message = "Vos machines de niveau 2 sont en bon état, vous ne pouvez pas les réparer plus que ça!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 2"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                } else {
                    $this->setIndicator("machines_lv2_health", $entreprise_id, 0.9);
                    $this->updateIndicator("caisse", $entreprise_id, -1 * $price);

                    $message = "Vos machines de niveau 2 sont maintenant en meilleur état, vous pouvez les vendre plus cher!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 2"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => true], 200);
                }
                break;
            case 'maintenance_lv3':
                $nb_machines = $this->getIndicator("nb_machines_lv3", $entreprise_id)["value"];
                if ($nb_machines <= 0) {
                    $message = "Vous n'avez pas de machines de niveau 3!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 3"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                }

                $machines_health = $this->getIndicator("machines_lv3_health", $entreprise_id)["value"];
                if ($machines_health > 0.9) {
                    $message = "Vos machines de niveau 3 sont en bon état, vous ne pouvez pas les réparer plus que ça!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 3"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => false], 200);
                } else {
                    $this->setIndicator("machines_lv3_health", $entreprise_id, 0.9);
                    $this->updateIndicator("caisse", $entreprise_id, -1 * $price);

                    $message = "Vos machines de niveau 3 sont maintenant en meilleur état, vous pouvez les vendre plus cher!";
                    $notification = [
                        "type" => "ActionUpdate",
                        "entreprise_id" => $entreprise_id,
                        "message" => $message,
                        "title" => "Réparation machines niveau 3"
                    ];
                    event(new NewNotification($notification));
                    return Response::json(["message" => $message, "success" => true], 200);
                }
                break;
        }
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
            $caisse = 0;
            $dettes = 0;
        }
        return ["time" => $time, "caisse" => $caisse, "dettes" => $dettes];
    }

    public function getMachinesInfo(Request $request)
    {
        $entreprise_id = $request->entreprise_id;

        $buy_price_lv1 = nova_get_setting("machines_lv1_price");
        $buy_price_lv2 = nova_get_setting("machines_lv2_price");
        $buy_price_lv3 = nova_get_setting("machines_lv3_price");

        $speed_lv1 = nova_get_setting("machines_lv1_speed");
        $speed_lv2 = nova_get_setting("machines_lv2_speed");
        $speed_lv3 = nova_get_setting("machines_lv3_speed");

        $pollution_lv1 = nova_get_setting("machines_lv1_pollution");
        $pollution_lv2 = nova_get_setting("machines_lv2_pollution");
        $pollution_lv3 = nova_get_setting("machines_lv3_pollution");

        $durability_lv1 = nova_get_setting("machines_lv1_durability");
        $durability_lv2 = nova_get_setting("machines_lv2_durability");
        $durability_lv3 = nova_get_setting("machines_lv3_durability");

        $health_lv1 = $this->getIndicator("machines_lv1_health", $entreprise_id)['value'];
        $health_lv2 = $this->getIndicator("machines_lv2_health", $entreprise_id)['value'];
        $health_lv3 = $this->getIndicator("machines_lv3_health", $entreprise_id)['value'];

        $sell_price_lv1 = round($buy_price_lv1 * $health_lv1);
        $sell_price_lv2 = round($buy_price_lv2 * $health_lv2);
        $sell_price_lv3 = round($buy_price_lv3 * $health_lv3);

        return [
            "buy_price_lv1" => $buy_price_lv1, "buy_price_lv2" => $buy_price_lv2, "buy_price_lv3" => $buy_price_lv3,
            "sell_price_lv1" => $sell_price_lv1, "sell_price_lv2" => $sell_price_lv2, "sell_price_lv3" => $sell_price_lv3,
            "speed_lv1" => $speed_lv1, "speed_lv2" => $speed_lv2, "speed_lv3" => $speed_lv3,
            "pollution_lv1" => $pollution_lv1, "pollution_lv2" => $pollution_lv2, "pollution_lv3" => $pollution_lv3,
            "durability_lv1" => $durability_lv1, "durability_lv2" => $durability_lv2, "durability_lv3" => $durability_lv3,
        ];
    }
}
