<?php

namespace App\Traits;

use App\Models\Product;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;

use App\Events\SimulationDateChanged;
use App\Traits\HelperTrait;
use App\Events\NavbarDataChanged;

trait IndicatorTrait
{
    use HelperTrait;

    public function updateIndicator($indicator_code, $entreprise_id, $value)
    {
        $indicator = DB::table("indicators")->where("code", "=", $indicator_code)->first();
        $entrep_indicator = DB::table("entreprise_indicator")->where("entreprise_id", "=", $entreprise_id)->where("indicator_id", "=", $indicator->id);

        if (count($entrep_indicator->get()->toArray()) == 0) {
            // Create indicator
            DB::table("entreprise_indicator")->insert([
                "indicator_id" =>  $indicator->id,
                "entreprise_id" => $entreprise_id,
                "value" => $value,
                "phase" => 0
            ]);
        } else {
            $entrep_indicator->increment("value", $value);
        }

        if ($indicator_code == 'dettes' || $indicator_code == 'caisse') {
            $data = [
                "entreprise_id" => $entreprise_id,
                "dettes" => $this->getIndicator("dettes", $entreprise_id)['value'],
                "caisse" => $this->getIndicator("caisse", $entreprise_id)['value'],
            ];
            event(new NavbarDataChanged($data));
        }
    }
    public function setIndicator($indicator_code, $entreprise_id, $value)
    {
        $indicator = DB::table("indicators")->where("code", "=", $indicator_code)->first();
        $entrep_indicator = DB::table("entreprise_indicator")->where("entreprise_id", "=", $entreprise_id)->where("indicator_id", "=", $indicator->id);

        if (count($entrep_indicator->get()->toArray()) == 0) {
            // Create indicator
            DB::table("entreprise_indicator")->insert([
                "indicator_id" =>  $indicator->id,
                "entreprise_id" => $entreprise_id,
                "value" => $value,
                "phase" => 0
            ]);
        } else {
            $entrep_indicator->update(["value" => $value]);
        }

        if ($indicator_code == 'dettes' || $indicator_code == 'caisse') {
            $data = [
                "entreprise_id" => $entreprise_id,
                "dettes" => $this->getIndicator("dettes", $entreprise_id)['value'],
                "caisse" => $this->getIndicator("caisse", $entreprise_id)['value'],
            ];
            event(new NavbarDataChanged($data));
        }
    }
    public function resetIndicator($indicator_code, $entreprise_id)
    {
        $indicator = DB::table("indicators")->where("code", "=", $indicator_code)->first();
        $entrep_indicator = DB::table("entreprise_indicator")->where("entreprise_id", "=", $entreprise_id)->where("indicator_id", "=", $indicator->id);
        $entrep_indicator->update(["value" => $indicator->starting_value]);
    }

    public function getFinanceIndicators(Request $request)
    {
        $cost_keys = ["prod_cost", "dist_cost", "raw_materials_cost"];
        $ca_keys = ["ca_1", "ca_2", "ca_3", "ca_4", "ca"];
        $other_keys = ["caisse", "dettes", "debt_ratio"];
        $data = [];
        $costs = [];
        $ca = [];
        $other = [];

        foreach ($cost_keys as $ind) {
            $ind = $this->getIndicator($ind, $request->entreprise_id);
            $value = $ind["value"];
            $name = $ind["name"];
            array_push($costs, ["name" => $name, "value" => $value]);
        }

        foreach ($ca_keys as $ind) {
            $ind = $this->getIndicator($ind, $request->entreprise_id);
            $value = $ind["value"];
            $name = $ind["name"];
            array_push($ca, ["name" => $name, "value" => $value]);
        }

        foreach ($other_keys as $ind) {
            $ind = $this->getIndicator($ind, $request->entreprise_id);
            $value = $ind["value"];
            $name = $ind["name"];
            array_push($other, ["name" => $name, "value" => $value]);
        }

        $resp = [
            "costs" => $costs,
            "ca" => $ca,
            "other" => $other
        ];

        return $resp;
    }

    public function getIndicator($indicator_code, $entreprise_id)
    {
        $indicator = DB::table("indicators")->where("code", "=", $indicator_code)->first();
        $entrep_indicator = DB::table("entreprise_indicator")->where("entreprise_id", "=", $entreprise_id)->where("indicator_id", "=", $indicator->id)->first();

        $resp = [
            "name" => $indicator->name,
            "value" => $entrep_indicator->value,
            "phase" => $entrep_indicator->phase
        ];
        return $resp;
    }

    // Specific functions



    public function getMarketShare(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $products = Product::all();
        $entreprises = Entreprise::all();
        $prod_names = $products->map(function ($p) {
            return $p->name;
        })->toArray();
        $market_share_prod = 0;
        $values = [];
        foreach ($products as $prod) {
            $key = "ca_" . $prod->id;
            $value = $this->getIndicator($key, $entreprise_id)["value"];
            $total = 0;
            foreach ($entreprises as $entrep) {
                $total += $this->getIndicator($key, $entrep->id)["value"];
            }
            $market_share_prod = round($value / $total, 3);
            array_push($values, $market_share_prod);
        }
        $resp = ["names" => $prod_names, "values" => $values];
        return $resp;
    }
    public function getProductMarketShare(Request $request)
    {
        $product_id = $request->product_id;
        $entreprises = Entreprise::all();
        $key = "ca_" . $product_id;
        $total = 0;
        $data = [];
        foreach ($entreprises as $entrep) {
            $value = $this->getIndicator($key, $entrep->id)["value"];
            $total += $value;
        }
        foreach ($entreprises as $entrep) {
            $value = $this->getIndicator($key, $entrep->id)["value"];

            $prod_share = round($value / $total, 3);
            $prod_share = ["name" => $entrep->name, "value" => $prod_share];
            array_push($data, $prod_share);
        }
        return $data;
    }

    public function getDailySalesProfit(Request $request)
    {
    }
}
