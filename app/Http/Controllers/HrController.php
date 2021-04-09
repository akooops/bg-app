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
        $keys = ["nb_workers","workers_mood","productivity_coeff"];
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
        $workers = $this->getIndicator('nb_workers',$request->entreprise_id)['value'];
        $this->updateIndicator('caisse',$request->entreprise_id,-$workers*nova_get_setting('workshop_price'));
        //Must check that the coef is <1 
        $productivity_coeff = $this->getIndicator('productivity_coeff',$request->entreprise_id)['value'];
        $difference = $productivity_coeff+0.25>1?1-$productivity_coeff:0.25;
        $this->updateIndicator('productivity_coeff',$request->entreprise_id,$difference);
        return Response::json("Félicitations, vous avez lancé une formation pour l'ensemble des employés, cette page se rechargera automatiquement dans 3 secondes",200);
    }
    public function primeWorkers(Request $request)
    {
        $workers = $this->getIndicator('nb_workers',$request->entreprise_id)['value'];
        $this->updateIndicator('caisse',$request->entreprise_id,-$workers*$request->prime);
        $workers_mood = $this->getIndicator("workers_mood",$request->entreprise_id)['value'];
        $difference = $workers_mood + $request->mood>1?1-$workers_mood:$request->mood;
        $this->updateIndicator('workers_mood',$request->entreprise_id,$difference);
        return Response::json("Félicitations, vous avez lancé ajouté une prime pour l'ensemble des employés, cette page se rechargera automatiquement dans 3 secondes",200);
    }
    
}

