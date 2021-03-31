<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Indicator;
use App\Models\Entreprise;
use Illuminate\Support\Facades\DB;
class IndicatorInitSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $indicators = Indicator::all();
        $entreprises = Entreprise::all();
        foreach ($entreprises as $entrep) {
        	foreach ($indicators as $indicator) {
        		DB::table("entreprise_indicator")->insert([
        			"entreprise_id" => $entrep->id,
        			"indicator_id" => $indicator->id,
        			"value" => $indicator->starting_value,
        			"phase" => 0
        		]);
        	}
        }
    }
}
