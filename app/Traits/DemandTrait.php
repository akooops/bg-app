<?php

namespace App\Traits;

use App\Models\Product;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;
use App\Traits\IndicatorTrait;

trait DemandTrait
{
    use IndicatorTrait, HelperTrait;

    // DEMANDE FICTIVE
    public function productDemandPrev($prod_id, $prices)
    {
        $demand = collect([]);
        $prices = collect($prices);

        $total_population = (int) $this->get_game_setting('population');

        switch ($prod_id) {
            case 1:         // Pantalon CARGO
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 66102 * pow(1 - ($p - 2599)/1000, 0.4);

                    $pop_percent = (float) Product::where('id', '=', 1)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;

            case 2:         //Pantalon PORTOFINO
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 7624 * (exp(cos( pi() * ($p - 25999) / 10000 )) - exp(-1)) / (exp(1) - exp(-1)) ;

                    $pop_percent = (float) Product::where('id', '=', 2)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;

            case 3:         // Robes de mariage
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 587 * (exp(cos( pi() * ($p - 91999) / 20000 )) - exp(-1)) / (exp(1) - exp(-1));

                    $pop_percent = (float) Product::where('id', '=', 3)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;

            case 4:         //T-shirt
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 341278 * pow(1 - ($p - 1999)/1000, 0.4);

                    $pop_percent = (float) Product::where('id', '=', 4)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;

            case 5:         // POLO RUGBY
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent =9660 * (exp(cos( pi() * ($p - 25999) / 10000 )) - exp(-1)) / (exp(1) - exp(-1));

                    $pop_percent = (float) Product::where('id', '=', 5)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;
            case 6:         // Pull à col rond
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 15274 * (exp(cos( pi() * ($p - 20999) / 10000 )) - exp(-1)) / (exp(1) - exp(-1));

                    $pop_percent = (float) Product::where('id', '=', 6)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;
            case 7:         // PARKA
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent =37840 * sqrt(1 - pow(($p - 4999) / 1500, 4));

                    $pop_percent = (float) Product::where('id', '=', 7)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;
            case 8:         // RICHELIEU
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent =2079 * sqrt(1 - pow(($p - 22999) / 10000, 4));

                    $pop_percent = (float) Product::where('id', '=', 8)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;
            case 9:         // TUXEDO
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 2106 * (exp(cos( pi() * ($p - 43999) / 15000 )) - exp(-1)) / (exp(1) - exp(-1));

                    $pop_percent = (float) Product::where('id', '=', 9)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;
            case 10:         //Jupe ajustée à taille ceinturée
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 7048 * (exp(cos( pi() * ($p - 20999) / 10000 )) - exp(-1)) / (exp(1) - exp(-1));

                    $pop_percent = (float) Product::where('id', '=', 10)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;
            case 11:         // JUPE LONGUE
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 74836 * pow(1 - ($p - 2399)/1000, 0.4);

                    $pop_percent = (float) Product::where('id', '=', 11)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;
            case 12:         //Pull à col bâteau
                $demand = $prices->map(function ($p) use ($total_population) {
                    $percent = 198671 * pow(1 - ($p - 2399)/1000, 0.4);

                    $pop_percent = (float) Product::where('id', '=', 12)->first()["percent_population"];

                    $pop = $total_population * $pop_percent;

                    $dem = round($percent * $pop);

                    return round(max($dem, 0));
                });
                break;
        }

        return $demand;
    }

    // CALCUL INFLUENCE SOCIALE
    public function socialInfluence($entreprise_id, $coeff_array)
    {
        $indicators = ["nb_subscribers", "social_presence", "media_presence", "events_presence"];
        $entreprise_ss = 0;
        $all_ss = 0;
        for ($i = 0; $i < count($coeff_array); $i++) {
            $entreprise_ss += $coeff_array[$i] * $this->getIndicator($indicators[$i], $entreprise_id)["value"];
        }

        $entreprises = Entreprise::all();
        foreach ($entreprises as $entreprise) {
            $eid = $entreprise->id;
            for ($i = 0; $i < count($coeff_array); $i++) {
                $all_ss += $coeff_array[$i] * $this->getIndicator($indicators[$i], $eid)["value"];
            }
        }
        return $entreprise_ss / $all_ss;
    }


    // DEMANDE REELLE
    public function productDemandReal($prod_id, $entreprise_id, $price, $quantity)
    {
        $demand = 0;
        $total_population = (int) $this->get_game_setting('population');

        $product = Product::where('id', '=', $prod_id)->first();

        $tot_quant = DB::table('stock')->where('product_id', '=', $prod_id)->get()->sum('quantity_selling');

        $nb_entrep = count(Entreprise::all());

        switch ($prod_id) {
            case 1: // cargo
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 66102 * pow(1 - ($p - 2599)/1000, 0.4);

                $pop_percent = (float) Product::where('id', '=', 1)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;

            case 2: // portofino
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 7624 * (exp(cos( pi() * ($p - 25999) / 10000 )) - exp(-1)) / (exp(1) - exp(-1));

                $pop_percent = (float) Product::where('id', '=', 2)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;

            case 3: // robe marriage
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 587 * (exp(cos( pi() * ($p - 91999) / 20000 )) - exp(-1)) / (exp(1) - exp(-1));

                $pop_percent = (float) Product::where('id', '=', 3)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;

            case 4: // tshirt
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 341278 * pow(1 - ($p - 1999)/1000, 0.4);

                $pop_percent = (float) Product::where('id', '=', 4)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;

            case 5: //polo rugby
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 9660 * (exp(cos( pi() * ($p - 25999) / 10000 )) - exp(-1)) / (exp(1) - exp(-1))                ;

                $pop_percent = (float) Product::where('id', '=', 5)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;
            case 6: // pull a col rond
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 15274 * (exp(cos( pi() * ($p - 20999) / 10000 )) - exp(-1)) / (exp(1) - exp(-1))                ;

                $pop_percent = (float) Product::where('id', '=', 6)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;
            case 7: // parka
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 37840 * sqrt(1 - pow(($p - 4999) / 1500, 4));                ;

                $pop_percent = (float) Product::where('id', '=', 7)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;
            case 8: //richelieu
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 2079 * sqrt(1 - pow(($p - 22999) / 10000, 4));                ;

                $pop_percent = (float) Product::where('id', '=', 8)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;
            case 9: //  tuxedo
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 2106 * (exp(cos( pi() * ($p - 43999) / 15000 )) - exp(-1)) / (exp(1) - exp(-1))                ;

                $pop_percent = (float) Product::where('id', '=', 9)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;
            case 10: // jupe ajustéé
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 7048 * (exp(cos( pi() * ($p - 20999) / 10000 )) - exp(-1)) / (exp(1) - exp(-1))                ;

                $pop_percent = (float) Product::where('id', '=', 10)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;
            case 11: // jupe longue
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 74836 * pow(1 - ($p - 2399)/1000, 0.4)                ;

                $pop_percent = (float) Product::where('id', '=', 11)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;
            case 12: // pull col bateau
                $coeffs = [1, 1, 1, 1];
                $ss = $this->socialInfluence($entreprise_id, $coeffs);
                $x = (($quantity / $tot_quant) - (1 / $nb_entrep)) < 0 || ($ss - (1 / $nb_entrep)) < 0 ? $product->price_max : $product->price_min;

                $p = $price + (0.1 / (1 - (1 / $nb_entrep))) * (($quantity / $tot_quant) - (1 / $nb_entrep)) * ($x - $price) + (0.1 / (1 - (1 / $nb_entrep))) * ($ss - (1 / $nb_entrep)) * ($x - $price);

                // $p = $price;

                $percent = 198671 * pow(1 - ($p - 2399)/1000, 0.4)                ;

                $pop_percent = (float) Product::where('id', '=', 12)->first()["percent_population"];

                $pop = $total_population * $pop_percent;

                $demand = round($percent * $pop);

                break;
        }

        $demand = max($demand, 0);

        //$epsilon = mt_rand(-50,20);
        $sup = 1.02 * $demand;
        $inf = 0.98 * $demand;
        $real_demand = mt_rand($inf, $sup);
        $quant_sold = 0;
        if ($real_demand > $quantity) {
            $quant_sold = $quantity;
        } else {
            $quant_sold = $real_demand;
        }
        return (int) round($quant_sold);
    }

    // Renvoie la demande fictive selon le prix entre prix_min et prix_max (pour les graphes de la dashboard)
    public function getProductDemandPrev(Request $request)
    {
        $prod_id = $request->product_id;
        $product = Product::whereId($prod_id)->first();

        $price_max = $product->price_max;
        $price_min = $product->price_min;

        $nb_points = 20;
        $step = ($price_max - $price_min) / ($nb_points - 1);

        $prices = [];
        for ($i = 0; $i < $nb_points; $i++) {
            $p = round($price_min + $i * $step);
            array_push($prices, $p);
        }

        $demand = $this->productDemandPrev($prod_id, $prices);

        $resp = [
            "prices" => $prices,
            "demand" => $demand->toArray()
        ];
        return $resp;
    }

    // Renvoie la demande réelle selon la quantité et le prix choisis
    public function getProductDemandReal(Request $request)
    {
        // dd($request);
        $prod_id = $request->product_id;
        $entreprise_id = $request->entreprise_id;
        // $product = Product::whereId($prod_id)->first();
        // dd($product);
        $price = $request->price;
        $quantity = $request->quantity;
        $demand = $this->productDemandReal($prod_id, $entreprise_id, $price, $quantity);
        // dd($this->socialInfluence($entreprise_id,[1,1,1,1]));
        $resp = [
            "demand" => $demand,
            "stock" => $quantity - $demand
        ];
        return $resp;
    }

    // Returns (supposedly) the average price of a product over the last 10 productions, however if
    // the number of productions hasn't yet reached 5, it will return a value of
    // price_min + (price_max - price_min) / 2
    public function getAvgPrice(Request $request)
    {
        $prod_id = $request->product_id;
        $productions =  DB::table("productions")->where("product_id", "=", $prod_id)->latest("creation_date")->limit(10)->get();
        $avg = 0;
        if ($productions->count() < 5) {
            $product = Product::find($prod_id);
            //dd($product);
            $price_max = $product->price_max;
            $price_min = $product->price_min;
            $avg = $price_min + ($price_max - $price_min) / 2;
        } else {
            $avg = $productions->avg("price");
        }

        return $avg;
    }
}
