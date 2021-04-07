<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Traits\HelperTrait;
use App\Traits\IndicatorTrait;
use Illuminate\Support\Facades\Response;

class HrController extends Controller
{
    use HelperTrait,IndicatorTrait;
    public function getHrIndicators(Request $request)
    {
        $keys = ["nb_workers","workers_mood"];
        $entreprise_id = $request->entreprise_id;
        $resp = [];
        foreach ($keys as $ind) {
            $value = $this->getIndicator($ind,$entreprise_id)??null;
            $resp[$ind] = $value;
        }
        return $resp;
    }
    public function hireWorkers(Request $request)
    {
        $request->validate([
            'workers' => 'required|integer|max:5|min:1']);
        $this->updateIndicator('nb_workers',$request->entreprise_id,$request->workers);
        $this->updateIndicator('nb_workers_prod',$request->entreprise_id,$request->workers);
        return Response::json(["message"=>"Félicitations, vous avez recruté ". $request->workers . "employés" ],200);
    }
    public function launchWorkshop(Request $request)
    {
        $this->updateIndicator('nb_workers',$request->entreprise_id,$request->workers);
        return Response::json(["message"=>"Félicitations, vous avez recruté ". $request->workers . "employés, cette page va se recharger automatiquement dans 4 secondes" ],200);
    }
}

