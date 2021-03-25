<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Department;
use App\Models\RawMaterial;
use App\Models\Supplier;
use App\Models\Command;
use Illuminate\Support\Facades\Response;
class EntrepriseController extends Controller
{
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

    function createCommand(Request $request){
        $entreprise_id = $request->entreprise_id;
        $last_cmd = Command::latest()->first();
        $cmd_id = 0;
        if($last_cmd != null){
            $cmd_id = $last_cmd->command_id  + 1;
        }
        
        for ($i=0; $i < count($request["command"]); $i++) {
            
            $cmd =  $request["command"][$i];
            //dd($cmd);
            $supplier_id = Supplier::where("name",$cmd["supplier"])->first()->id;
            $material_id = RawMaterial::where("name",$cmd["material"])->first()->id;
            //dd($cmd_id);
            Command::create([
            "command_id"=> $cmd_id,
            "entreprise_id" => $entreprise_id,
            "supplier_id" => $supplier_id,
            "raw_material_id" => $material_id,
            "status"=> "pending",
            "price"=> $cmd["price"],
            "quantity" => $cmd["quantity"],
            ]);
        }
        return Response::json(["message"=>"Votre commande à été envoyée aux fournisseurs"],200);
    }
}
