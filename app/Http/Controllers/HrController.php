<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Traits\HelperTrait;

class HrController extends Controller
{
    use HelperTrait;
    public function getHrIndicators(Request $request)
    {
        $keys = ["nb_workers","salary_production","productivity_coeff","nb_workers_prod"];
        $entreprise_id = $request->entreprise_id;
        $resp = [];
        foreach ($keys as $ind) {
            $value = $this->getIndicator($ind,$entreprise_id);
            $resp[$ind] = $value;
        }
        return $resp;
    }
}
