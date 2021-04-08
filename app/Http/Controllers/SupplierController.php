<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Command;
use App\Models\RawMaterial;
use App\Models\Entreprise;
use App\Models\Supplier;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use App\Jobs\AddToStock;
class SupplierController extends Controller
{
    public function getAllCommands(Request $request){
    	// Get commands for that supplier
    	$supplier_id = $request->supplier_id;

    	$commands = Command::where("status","=","pending")->where("supplier_id","=",$supplier_id)->get();
    	$grp_commands = $commands->groupBy("command_id");
    	//dd($grp_commands);
    	$commands_data = $grp_commands->map(function($cmd){
    		$entreprise = Entreprise::find($cmd[0]->entreprise_id)->first()->name;
    		$num_items = count($cmd);
    		$status = "pending";
    		$data = [
    			"id"=> $cmd[0]->command_id,
    			"name" => $entreprise,
    			"num_items" => count($cmd),
    			"status" => "pending",
    			"created" => $cmd[0]->created_at->toDateTimeString()
    		];
    		return $data;

    	});
    	//dd($commands_data);
    	return $commands_data->values()->toArray();
    }

    public function getCommand(Request $request){
    	// Get one command
    	$command_id = $request->command_id;
    	$supplier_id = $request->supplier_id;
    	$command_items = Command::where("command_id","=",$command_id)->where("supplier_id","=",$supplier_id)->where("status","=","pending")->get();
    	$data = $command_items->map(function($item) {
    		$material = RawMaterial::find($item["raw_material_id"]);
    		$item_data = [
    			"name" => $material->name,
    			"price" => $material->price,
    			"quantity" => $item["quantity"],
    			"status" => $item["status"]
    		];
    		return $item_data;
    	});
    	return $data->toArray();
    }

    public function validateCommand(Request $request){
    	$command = $request->command;
    	$supplier_id = $request->supplier_id;
    	$cmd_id = $request->command_id;
    	$full_cost = 0;
    	$supplier = Supplier::find($supplier_id)->first();
    	$delay = mt_rand($supplier->ddl_min,$supplier->ddl_max);
    	$entreprise_id = $request->entreprise_id;
        $stocks = [];
        foreach ($command as $item) {
          $material = RawMaterial::where("name","=",$item["name"])->first();
    		//dd($material->id);

          $cmd_item = Command::upsert([
             "command_id" => $cmd_id, "raw_material_id"=>$material->id,
             "price"=> $item["price"],
             "status"=> "confirmed",
             "supplier_id"=>$supplier_id,
             "entreprise_id" => $entreprise_id,
         ], ["command_id","raw_material_id"],["price","status"]);
          $stock_item = [
            "raw_material_id"=>$material->id,
            "quantity" => $item["quantity"],
            "unit" => $material->unit,
            "phase" => 0,
            "entreprise_id" => $entreprise_id,
        ];
        array_push($stocks,$stock_item);
        $cost = $item["price"] * $item["quantity"];
        $full_cost += $cost;


    }
    AddToStock::dispatch($stocks,$full_cost,$entreprise_id)
    ->delay(now()->addSeconds($delay));
    return Response::json(["message" => "La commande a été validé
      , vous serez renvoyé vers le dashboard dans 4 secondes "],200);
}

    public function addToStock($stock_items,$cost){
        foreach ($stock_items as $stock_item) {
            $stock = DB::table("raw_materials_stock")->where("raw_material_id","=",$stock_item["raw_material_id"])->where("entreprise_id","=",$stock_item["entreprise_id"]);
            //dd(count($stock->get()->toArray()));
            if(count($stock->get()->toArray()) == 0){
                DB::table("raw_materials_stock")->insert($stock_item);
            }
            else{
                // update quant
                $quant = $stock_item["quantity"];
                $stock->increment("quantity",$quant);
            }
        }
        // Should use cost to update some indicators
    
    }
}
