<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Command;

class SupplierController extends Controller
{
    public function getCommands(){
    	// Get commands for that supplier
    	$user = auth()->user();

    	$commands = Command::where("status","==","pending")->where("supplier_id","==",$user->id)->groupBy("entreprise_id")->get();
    	dd($commands->toArray());


    }
}
