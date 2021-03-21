<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Department;


class EntrepriseController extends Controller
{
    function showDashboard(){
    	$departments = Department::all();
    	return view("dashboard",["departments"=>$departments]);
    }
}
