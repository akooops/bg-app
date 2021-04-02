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

class EntrepriseController extends Controller
{
    use HelperTrait, DemandTrait, IndicatorTrait;
    function showDashboard(){
    	$departments = Department::all();
    	return view("dashboard",["departments"=>$departments]);
    }
    // Departments view routes
    function showDptApprov(Request $request){
    	$raw_materials = RawMaterial::all();
    	$suppliers = Supplier::all();
    	return view("departments.approv",["materials"=>$raw_materials,"suppliers"=>$suppliers]); 
    }
        // Departments view routes
    function showDptProduction(Request $request){
        $products = Product::all();
        $products = $products->load('rawMaterials');
        return view("departments.production",["products"=>$products]); 
    }
    function showCommandMaker(Request $request){
        $raw_materials = RawMaterial::all();
        $suppliers = Supplier::all();
        return view("departments.widgets.command_maker",["materials"=>$raw_materials,"suppliers"=>$suppliers]); 
    }
    function showStock(Request $request){
        $products = Product::all()->toArray();
        return view("departments.widgets.stock"); 
    }


    function getEntrepriseCommands(Request $request){
        $entreprise_id = $request->entreprise_id;
        $command_items = Command::where("entreprise_id","=",$entreprise_id)->get();
        $commands = $command_items->groupBy("command_id")->values()->toArray();
        //dd($commands);
        $commands_data = collect($commands)->map(function($cmd){
            $data = [
                "command_id" => $cmd[0]["command_id"],
                "created" => $cmd[0]["created_at"],
                "num_items" => count($cmd),
                "status" => $this->getCommandStatus($cmd)
            ];
            $data["details"] = collect($cmd)->map(function($item){
                $material = RawMaterial::find($item["raw_material_id"]);
                $supplier = Supplier::find($item["supplier_id"]);
                $quantity = $item["quantity"];
                $price = $item["price"];
                $phrase = $item["quantity"] . " ". $material->unit . " de ". $material->name ." Chez " . $supplier->name . ", Prix: ". $price . " DA / Status : ". $this->parseCommandStatus($item["status"]);
                 
                return ["material" => $material->name,"unit" => $material->unit, "supplier" => $supplier->name, "quantity" =>$quantity, "price" => $price, "status" => $item["status"] , "phrase" => $phrase];
            });
            return $data;
        });
        $sorted_commands = $commands_data->sortByDesc("created");
        return $sorted_commands->toArray();
    }



    function getCommandStatus($cmd){
        // check if all items in a command are pending or accepted
        $status_list = collect($cmd)->map(function($item){
            return $item["status"];
        })->toArray();

        $is_confirmed = $this->in_array_all("confirmed",$status_list);
        if($is_confirmed){
            return "confirmed";
        }
        else{
            return "pending";
        }
    }

    function createCommand(Request $request){
        $entreprise_id = $request->entreprise_id;
        $last_cmd = Command::latest()->first();
        $cmd_id = 0;
        if($last_cmd != null){
            $cmd_id = $last_cmd->command_id  + 1;
        }
        $command_items = [];
        for ($i=0; $i < count($request["command"]); $i++) {
            
            $cmd =  $request["command"][$i];
            //dd($cmd);
            $supplier_id = Supplier::where("name",$cmd["supplier"])->first()->id;
            $material_id = RawMaterial::where("name",$cmd["material"])->first()->id;
            //dd($cmd_id);
            $cmd_item = [
            "command_id"=> $cmd_id,
            "entreprise_id" => $entreprise_id,
            "supplier_id" => $supplier_id,
            "raw_material_id" => $material_id,
            "status"=> "pending",
            "price"=> $cmd["price"],
            "quantity" => $cmd["quantity"],
            ];
            array_push($command_items, $cmd_item);
        }
        $command_items = collect($command_items);
        // Logic to split command into suppliers
        $supp_command_items = $command_items->groupBy("supplier_id");
        $supp_command_items->map(function($supp_cmd) use($entreprise_id, $cmd_id){
            //dd($supp_cmd[0]);
            $supplier_id = $supp_cmd[0]["supplier_id"];
            $command = [
            "id" => $cmd_id, 
            "name" => Entreprise::find($entreprise_id)->name,
            "status" => "pending",
            "num_items" => count($supp_cmd),
            "created" =>  (new \DateTime())->format('Y-m-d H:i:s')
            ];
            $supp_cmd->map(function($supp_cmd_item){
                Command::create($supp_cmd_item);
            });
            event(new CommandCreated($command,$supplier_id));
        });
        return Response::json(["message"=>"Votre commande à été envoyée aux fournisseurs, vous serez redirigé vers le département d'approvisionnement dans 4 secondes"],200);
    }

    public function getStock(Request $request){
        $entreprise_id = $request->entreprise_id;
        $stock = DB::table("raw_materials_stock")->where("entreprise_id","=",$entreprise_id)->get();
        //dd($stock->empty());
        $data = collect([]);
        if($stock->count() > 0){
            $data = $stock->map(function($item){
                $material = RawMaterial::where("id","=",$item->raw_material_id)->first();
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

    public function getProdIndicators(Request $request){
        // Return production useful indicators
        $keys = ["machines","nb_workers_prod","ca","reject_rate"];
        $entreprise_id = $request->entreprise_id;
        $resp = [];
        foreach ($keys as $ind) {
            $value = $this->getIndicator($ind,$entreprise_id);
            $resp[$ind] = $value;
        }
        return $resp;
    }

    public function launchProduction(Request $request){
        $entreprise_id = $request->entreprise_id;
        $product_id = $request->product_id;
        $quantity = $request->quantity*100;
        $delay = $request->delay;
        $production_data = [
            "entreprise_id" => $entreprise_id,
            "product_id" => $product_id,
            "quantity" => $quantity,
            "delay" => $delay,
            "status"=> "pending"
        ];
        DB::table("productions")->insert($production_data);

        // Schedule production;
    }

}
