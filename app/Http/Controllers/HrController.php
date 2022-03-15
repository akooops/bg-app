<?php

namespace App\Http\Controllers;

use App\Traits\HelperTrait;
use Illuminate\Http\Request;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
use Illuminate\Support\Facades\Response;

class HrController extends Controller
{
    use HelperTrait, IndicatorTrait;
    public function getHrIndicators(Request $request)
    {
        $keys = ["nb_workers_lv1", "nb_workers_lv1_busy", "workers_mood", "productivity_coeff"];
        $entreprise_id = $request->entreprise_id;
        $resp = [];
        foreach ($keys as $ind) {
            $value = $this->getIndicator($ind, $entreprise_id);
            $resp[$ind] = $value;
        }
        return $resp;
    }
    
    public function hireWorkers(Request $request)
    {
        // $request->validate([
        //     'workers' => 'required|integer|max:5|min:1'
        // ]);
        
        $entreprise_id = $request->entreprise_id;
        $nb_workers = $request->workers;

        if ($nb_workers < 1) {
            return Response::json(["message" => "Le nombre d'employés à recruter doit être supérieur à 0", "success" => false], 200);
        }

        $this->updateIndicator('nb_workers_lv1', $entreprise_id, $nb_workers);

        $message = "Félicitations, vous avez recruté " . $nb_workers . " employé(s)";
        $notification = [
            "type" => "EmployeesHired",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Employés recrutés"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message], 200);

        return Response::json(["message" => $message, "success" => true], 200);
    }

    public function launchWorkshop(Request $request)
    {
        $workers = $this->getIndicator('nb_workers', $request->entreprise_id)['value'];
        $this->updateIndicator('caisse', $request->entreprise_id, -$workers * nova_get_setting('workshop_price'));
        //Must check that the coef is <1 
        $productivity_coeff = $this->getIndicator('productivity_coeff', $request->entreprise_id)['value'];
        $difference = $productivity_coeff + 0.25 > 1 ? 1 - $productivity_coeff : 0.25;
        $this->updateIndicator('productivity_coeff', $request->entreprise_id, $difference);
        return Response::json("Félicitations, vous avez lancé une formation pour l'ensemble des employés, cette page se rechargera automatiquement dans 3 secondes", 200);
    }
    public function primeWorkers(Request $request)
    {
        $workers = $this->getIndicator('nb_workers', $request->entreprise_id)['value'];
        $this->updateIndicator('caisse', $request->entreprise_id, -$workers * $request->prime);
        $workers_mood = $this->getIndicator("workers_mood", $request->entreprise_id)['value'];
        $difference = $workers_mood + $request->mood > 1 ? 1 - $workers_mood : $request->mood;
        $this->updateIndicator('workers_mood', $request->entreprise_id, $difference);
        return Response::json("Félicitations, vous avez lancé ajouté une prime pour l'ensemble des employés, cette page se rechargera automatiquement dans 3 secondes", 200);
    }
}
