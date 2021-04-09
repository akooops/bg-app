<?php
namespace App\Traits;

use App\Models\Product;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;
use App\Traits\IndicatorTrait;

trait DemandTrait{
	use IndicatorTrait;
	public function productDemandPrev($prod_id,$prices ){
		$demand = collect([]);
		$prices = collect($prices);
		switch ($prod_id) {
    	case 1:
        	$demand = $prices->map(function($p){
        		return round(7600 - 57.5*$p);
        	});
        	break;
    	case 2:
        	$demand = $prices->map(function($p){
        		return round(25000*exp(-1*$p/150));
        	});
        	break;
    	case 3:
        	$demand = $prices->map(function($p){
        		
        		return round(6800 - 8 * $p**2);
        	});
        	break;
        case 4:
        	$demand = $prices->map(function($p){
        	
        		return round(7700-0.57*$p**1.75);
        	});
        	break;
		}
		return $demand;

	}
	public function socialInfluence($entreprise_id,$coeff_array){
		$indicators = ["nb_subscribers","social_presence","media_presence","event_presence"];
		$entreprise_ss = 0;
		$all_ss = 0;
		for ($i=0; $i < count($coeff_array) ; $i++) { 
			$entreprise_ss = $coeff_array[$i] * $this->getIndicator($indicators[$i],$entreprise_id)["value"];
			
		}
		$entreprises = Entreprise::all();
		foreach ($entreprises as $entreprise) {
			$eid = $entreprise->id;
			for ($i=0; $i < count($coeff_array) ; $i++) { 
				$all_ss += $coeff_array[$i] * $this->getIndicator($indicators[$i],$eid)["value"];
			}
		}
		return $entreprise_ss/$all_ss;
	}
	public function productDemandReal($prod_id,$entreprise_id,$price,$quantity){
		$demand = 0;
		switch ($prod_id) {
    	case 1:
    		$ss = $this->socialInfluence($entreprise_id,[1,1,1,1]);
        	$social_importance_coeff = 4; 
        	$demand = 7600 - 57.5*$price;
        	$demand = $demand + $ss*$demand/$social_importance_coeff;
    	case 2:
    		$ss = $this->socialInfluence($entreprise_id,[2,2,3,4]);
        	$social_importance_coeff = 1; 
        	$demand = round(25000*exp(-1*$price/150));
        	$demand = $demand + $ss*$demand/$social_importance_coeff;
        	break;
    	case 3:
    		$ss = $this->socialInfluence($entreprise_id,[1,1,1,1]);
    		
        	$social_importance_coeff = 2; // Bigger is less important
        	$demand = 6800 - 8 * $price**2;
        	$demand = $demand + $ss*$demand/$social_importance_coeff;
        	break;
        case 4:
        	$ss = $this->socialInfluence($entreprise_id,[1,1,1,1]);
        	$social_importance_coeff = 2; 
        	$demand = 7700-0.57*$price**1.75;
        	$demand = $demand + $ss*$demand/$social_importance_coeff;
        	break;
		}
		//$epsilon = mt_rand(-50,20);
		$sup = 1.05 * $demand;
		$inf = 0.95 * $demand;
		$real_demand = mt_rand($inf,$sup);
		$quant_sold = 0;
		if($real_demand > $quantity){
			$quant_sold = $quantity;
		}
		else{
			$quant_sold = $real_demand;
		}
		return round($quant_sold);
	}
	public function getProductDemandPrev(Request $request)
    {
        $prod_id = $request->product_id;
        $product = Product::whereId($prod_id)->first();
        //dd($product);
        $price_max = $product->price_max;
        $price_min = $product->price_min;
        $step = ($price_max - $price_min)/10;
        $prices = [];
        for ($i=0; $i < 10; $i++) {
        	$p = round($price_min + $i* $step);
        	array_push($prices,$p);
        }
        $demand = $this->productDemandPrev($prod_id,$prices);
        $resp = [
        	"prices" => $prices,
        	"demand" => $demand->toArray()
        ];
        return $resp;
    }
    public function getProductDemandReal(Request $request)
    {
    	//dd($request);
        $prod_id = $request->product_id;
        $entreprise_id = $request->entreprise_id;
        $product = Product::whereId($prod_id)->first();
        //dd($product);
        $price = $request->price;
        $quantity = $request->quantity;
        $demand = $this->productDemandReal($prod_id,$entreprise_id,$price,$quantity);
        //dd($this->socialInfluence($entreprise_id,[1,1,1,1]));
        $resp = [
        	"demand" => $demand,
        	"stock" => $quantity - $demand
        ];
        return $resp;
    }

    public function getAvgPrice(Request $request){
    	$prod_id = $request->product_id;
    	$productions =  DB::table("productions")->where("product_id","=",$prod_id)->latest("creation_date")->limit(10)->get();
    	$avg = 0;
    	if($productions->count() < 5){
    		$product = Product::find($prod_id);
    		//dd($product);
    		$price_max = $product->price_max;
    		$price_min = $product->price_min;
    		$avg = $price_min + ($price_max-$price_min)/2;
    	}
    	else{
    		$avg = $productions->avg("price");
    	}

    	return $avg;
    }		

}