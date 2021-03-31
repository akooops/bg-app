<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class IndicatorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	DB::statement('SET FOREIGN_KEY_CHECKS = 0');
    	DB::table("indicators")->truncate();
    	DB::table("indicators")->insert([
    		["name"=>"Chiffre d'Affaire","code"=>"ca","starting_value"=>0,"is_financial"=>true],
    		["name"=>"Nombre d'Employés","code"=>"nb_workers","starting_value"=>20,"is_financial"=>false],
    		["name"=>"Part du Marché","code"=>"market_share","starting_value"=>0,"is_financial"=>true],
    		["name"=>"Employés - Production","code"=>"nb_workers_prod","starting_value"=>8,"is_financial"=>false],
    		["name"=>"Employés - Approvisionnement","code"=>"nb_workers_approv","starting_value"=>3,"is_financial"=>false],
    		["name"=>"Employés - RH","code"=>"nb_workers_rh","starting_value"=>3,"is_financial"=>false],
    		["name"=>"Employés - Marketing","code"=>"nb_workers_marketing","starting_value"=>3,"is_financial"=>false],
    		["name"=>"Employés - Finance","code"=>"nb_workers_finance","starting_value"=>3,"is_financial"=>false],
    		["name"=>"Machines","code"=>"machines","starting_value"=>2,"is_financial"=>false]
    	]);
    	DB::statement('SET FOREIGN_KEY_CHECKS = 1');
        
    }
}
