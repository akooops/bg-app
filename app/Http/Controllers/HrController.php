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
        $keys = [
            "nb_workers_lv1", "nb_workers_lv1_busy",
            "nb_workers_lv2", "nb_workers_lv2_busy",
            "nb_workers_to_hire",
            "workers_mood", "productivity_coeff"
        ];
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
        $entreprise_id = $request->entreprise_id;
        $nb_workers = $request->workers;

        if ($nb_workers < 1) {
            return Response::json(["message" => "Le nombre d'employés à recruter doit être supérieur à 0", "success" => false], 200);
        }

        $this->updateIndicator('nb_workers_to_hire', $entreprise_id, $nb_workers);

        $message = "Début des protocoles de recrutement pour " . $nb_workers . " employé(s)";
        $notification = [
            "type" => "EmployeesHired",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Employés recrutés"
        ];
        event(new NewNotification($notification));

        return Response::json(["message" => $message, "success" => true], 200);
    }

    public function launchWorkshop(Request $request)
    {
        $nb_workers_to_train = $request->nb_workers_to_train;
        $price = nova_get_setting('workshop_price');
        $caisse = $this->getIndicator('caisse', $request->entreprise_id)['value'];
        if ($caisse < $price * $nb_workers_to_train) {
            return Response::json([
                "message" => "Impossible de former " . $nb_workers_to_train . " employé(s): Disponnibilités insuffisantes.",
                "success" => false
            ], 200);
        }

        $nb_workers_lv1 = $this->getIndicator('nb_workers_lv1', $request->entreprise_id)['value'];
        $nb_workers_lv1_busy = $this->getIndicator('nb_workers_lv1_busy', $request->entreprise_id)['value'];

        if ($nb_workers_lv1 < $nb_workers_to_train) {
            return Response::json([
                "message" => "Impossible de former " . $nb_workers_to_train . " employé(s): Vous n'en avez pas autant.",
                "success" => false
            ], 200);
        }

        if ($nb_workers_lv1 - $nb_workers_lv1_busy < $nb_workers_to_train) {
            return Response::json([
                "message" => "Impossible de former " . $nb_workers_to_train . " employé(s): Les employés occupés ne sont pas formables.",
                "success" => false
            ], 200);
        }

        $this->updateIndicator('caisse', $request->entreprise_id, -1 * $nb_workers_to_train * $price);

        $this->updateIndicator('nb_workers_lv1', $request->entreprise_id, -1 * $nb_workers_to_train);
        $this->updateIndicator('nb_workers_lv2', $request->entreprise_id, $nb_workers_to_train);

        $message = "Formation de " . $nb_workers_to_train . " employé(s) réussie!";
        $notification = [
            "type" => "EmployeesTrained",
            "entreprise_id" => $request->entreprise_id,
            "message" => $message,
            "title" => "Employés formés"
        ];
        event(new NewNotification($notification));

        return Response::json(["message" => $message, "success" => true], 200);
    }
    public function primeWorkers(Request $request)
    {
        $nb_workers_lv1 = $this->getIndicator('nb_workers_lv1', $request->entreprise_id)['value'];
        $nb_workers_lv2 = $this->getIndicator('nb_workers_lv2', $request->entreprise_id)['value'];

        $workers_mood = $this->getIndicator('workers_mood', $request->entreprise_id)['value'];

        $salary_lv1 = nova_get_setting('salary_lv1');
        $salary_lv2 = nova_get_setting('salary_lv2');

        $bonus = $request->bonus;
        $total_bonus = $bonus * ($nb_workers_lv1 + $nb_workers_lv2);

        $bonus_coeff = nova_get_setting('bonus_coeff');

        $bonus_max = ((1 - $workers_mood) * ($nb_workers_lv1 * $salary_lv1 + $nb_workers_lv2 * $salary_lv2)) / ($bonus_coeff * ($nb_workers_lv1 + $nb_workers_lv2));

        $mood_increase = $request->mood_increase;

        $caisse = $this->getIndicator('caisse', $request->entreprise_id)['value'];

        if ($total_bonus > $caisse) {
            return Response::json([
                "message" => "Impossible de donner une prime aux employés: Disponnibilités insuffisantes.",
                "success" => false
            ], 200);
        }

        if ($bonus > $bonus_max) {
            return Response::json([
                "message" => "Impossible de donner une prime aux employés: La somme spécifiée implique une perte d'argent inutile.",
                "success" => false
            ], 200);
        }

        $this->updateIndicator('caisse', $request->entreprise_id, -1 * $total_bonus);

        if ($mood_increase + $workers_mood > 1) {
            $this->setIndicator('workers_mood', $request->entreprise_id, 1);
        }
        else {
            $this->updateIndicator('workers_mood', $request->entreprise_id, $mood_increase);
        }

        $message = "Primes attribuées, l'humeur des employés augmente.";
        $notification = [
            "type" => "EmployeesBonus",
            "entreprise_id" => $request->entreprise_id,
            "message" => $message,
            "title" => "Primes attribuées"
        ];
        event(new NewNotification($notification));
        return Response::json(["message" => $message, "success" => true], 200);
    }

    public function fireWorkers(Request $request)
    {
        $entreprise_id = $request->entreprise_id;
        $nb_workers_lv1_to_fire = $request->nb_workers_lv1_to_fire;
        $nb_workers_lv2_to_fire = $request->nb_workers_lv2_to_fire;

        $nb_workers_lv1 = $this->getIndicator('nb_workers_lv1', $request->entreprise_id)['value'];
        $nb_workers_lv2 = $this->getIndicator('nb_workers_lv2', $request->entreprise_id)['value'];

        $nb_workers_lv1_busy = $this->getIndicator('nb_workers_lv1_busy', $request->entreprise_id)['value'];
        $nb_workers_lv2_busy = $this->getIndicator('nb_workers_lv2_busy', $request->entreprise_id)['value'];

        $salary_lv1 = nova_get_setting('salary_lv1');
        $salary_lv2 = nova_get_setting('salary_lv2');

        $price = 3 * ($salary_lv1 * $nb_workers_lv1_to_fire + $salary_lv2 * $nb_workers_lv2_to_fire);
        $caisse = $this->getIndicator('caisse', $request->entreprise_id)['value'];

        if ($nb_workers_lv1_to_fire < 0 || $nb_workers_lv2_to_fire < 0) {
            return Response::json(["message" => "Le nombre d'employés à licencier doit être supérieur à 0", "success" => false], 200);
        }

        if ($nb_workers_lv1_to_fire == 0 && $nb_workers_lv2_to_fire == 0) {
            return Response::json(["message" => "Le nombre d'employés à licencier doit être supérieur à 0", "success" => false], 200);
        }

        if ($nb_workers_lv1 < $nb_workers_lv1_to_fire) {
            return Response::json(["message" => "Vous ne pouvez pas licencier plus d'employés simples que vous n'en avez.", "success" => false], 200);
        }
        if ($nb_workers_lv1 - $nb_workers_lv1_busy < $nb_workers_lv1_to_fire) {
            return Response::json(["message" => "Les employés simples travaillant sur une production ne peuvent être licenciés.", "success" => false], 200);
        }

        if ($nb_workers_lv2 < $nb_workers_lv2_to_fire) {
            return Response::json(["message" => "Vous ne pouvez pas licencier plus d'employés experts que vous n'en avez.", "success" => false], 200);
        }
        if ($nb_workers_lv2 - $nb_workers_lv2_busy < $nb_workers_lv2_to_fire) {
            return Response::json(["message" => "Les employés experts travaillant sur une production ne peuvent être licenciés.", "success" => false], 200);
        }

        if ($price > $caisse) {
            return Response::json(["message" => "Vos disponnibilités ne suffisent pas pour assurer une avance de salaire aux employés à licencier", "success" => false], 200);
        }

        $this->updateIndicator('nb_workers_lv1', $entreprise_id, -1 * $nb_workers_lv1_to_fire);
        $this->updateIndicator('nb_workers_lv2', $entreprise_id, -1 * $nb_workers_lv2_to_fire);

        $message = "Licenciement de " . $nb_workers_lv1_to_fire . " employé(s) simple(s) et " . $nb_workers_lv2_to_fire . " employé(s) expert(s) réussi.";
        $notification = [
            "type" => "EmployeesFired",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Employés licenciés"
        ];
        event(new NewNotification($notification));

        return Response::json(["message" => $message, "success" => true], 200);
    }
}
