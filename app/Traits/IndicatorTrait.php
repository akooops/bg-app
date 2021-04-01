<?php
namespace App\Traits;

use App\Models\Product;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;

trait IndicatorTrait{

	public function updateIndicator($indicator_code,$entreprise_id,$value){
        $indicator = DB::table("indicators")->where("code","=",$indicator_code)->first();
        $entrep_indicator = DB::table("entreprise_indicator")->where("entreprise_id","=",$entreprise_id)->where("indicator_id","=",$indicator->id);
        if(count($entrep_indicator->get()->toArray()) == 0){
            // Create indicator
            DB::table("entreprise_indicator")->insert([
                "indicator_id" =>  $indicator->id,
                "entreprise_id" => $entreprise_id,
                "value" => $value,
                "phase" => 0
            ]);
        }
        else{
            if($value >= 0){
                $entrep_indicator->increment("value",$value);
            }
            else{
                $entrep_indicator->decrement("value",$value);
            }
            
        }
    }

    public function getIndicator($indicator_code,$entreprise_id){
        $indicator = DB::table("indicators")->where("code","=",$indicator_code)->first();
        $entrep_indicator = DB::table("entreprise_indicator")->where("entreprise_id","=",$entreprise_id)->where("indicator_id","=",$indicator->id)->first();
        
        $resp = [
            "name" => $indicator->name,
            "value" => $entrep_indicator->value,
            "phase" => $entrep_indicator->phase
        ];
        return $resp;
    }	

}