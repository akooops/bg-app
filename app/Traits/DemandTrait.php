<?php
namespace App\Traits;

use App\Models\Product;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;

trait DemandTrait{

	public function productDemandPrev($prod_id,$prices ){
		$demand = collect([]);
		$prices = collect($prices);
		switch ($prod_id) {
    	case 1:
        	$demand = $prices->map(function($p){
        		return round(700 - 10*$p);
        	});
        	break;
    	case 2:
        	$demand = $prices->map(function($p){
        		return round(500*exp(-$p/20));
        	});
        	break;
    	case 3:
        	$demand = $prices->map(function($p){
        		$alpha = -1.25;
        		$c = 500;
        		return round($c*$p**($alpha));
        	});
        	break;
        case 4:
        	$demand = $prices->map(function($p){
        		$alpha = -1.75;
        		$c = 400;
        		return round($c*$p**($alpha));
        	});
        	break;
		}
		return $demand;

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

}