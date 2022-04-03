<?php

namespace App\Jobs;

use App\Models\Entreprise;
use App\Traits\DemandTrait;
use App\Traits\HelperTrait;
use Illuminate\Bus\Queueable;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class ProcessWorkers implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    use HelperTrait, IndicatorTrait, DemandTrait;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $current_date = nova_get_setting("current_date");
        $entreprises = Entreprise::get();

        foreach ($entreprises as $entreprise) {

            // Increment 5s day if 5s active
            $day_5s = $this->getIndicator("5s_day", $entreprise->id)["value"];

            if ($day_5s < 30) {
                $this->updateIndicator("5s_day", $entreprise->id, 1);
            }

            // Workers quit if mood too low
            $nb_workers_lv1 = $this->getIndicator("nb_workers_lv1", $entreprise->id)["value"];
            $nb_workers_lv2 = $this->getIndicator("nb_workers_lv2", $entreprise->id)["value"];
            $nb_workers = $nb_workers_lv1 + $nb_workers_lv2;

            $nb_workers_lv1_busy = $this->getIndicator("nb_workers_lv1_busy", $entreprise->id)["value"];
            $nb_workers_lv2_busy = $this->getIndicator("nb_workers_lv2_busy", $entreprise->id)["value"];

            $workers_mood = $this->getIndicator("workers_mood", $entreprise->id)["value"];
            $workers_mood_th = nova_get_setting("mood_quitting_threshold");

            // Workers mood decrease every month
            if ($current_date % 30 == 0 && $nb_workers > 0) {
                $workers_mood_decay_rate = nova_get_setting('workers_mood_decay_rate');
                if ($workers_mood - $workers_mood_decay_rate >= 0) {
                    $this->updateIndicator("workers_mood", $entreprise->id, -1 * $workers_mood_decay_rate);
                } else {
                    $this->setIndicator("workers_mood", $entreprise->id, 0);
                }

                $notification = [
                    "type" => "WorkersUpdate",
                    "status" => "info",
                    "entreprise_id" => $entreprise->id,
                    "data" => [],
                    "message" => "L'humeur au sein de votre entreprise décroit",
                    "title" => "L'humeur décroit"
                ];
                event(new NewNotification($notification));
            }

            // Warn that workers are going to quit
            if ($workers_mood - nova_get_setting('workers_mood_decay_rate') < $workers_mood_th && $nb_workers > 0) {
                if ($current_date % 30 == 0) {
                    $notification = [
                        "type" => "WorkersUpdate",
                        "status" => "warning",
                        "entreprise_id" => $entreprise->id,
                        "data" => [],
                        "message" => "Attention, l'humeur de vos employés est mauvaise, Il y a des riques de démissions.",
                        "title" => "Risques de démissions"
                    ];
                    event(new NewNotification($notification));
                }
            }

            // Workers quitting
            if ($workers_mood <= $workers_mood_th && $nb_workers > 0) {
                $pick = mt_rand() / mt_getrandmax();
                $quitting_prob = nova_get_setting("quitting_prob");

                if ($pick <= $quitting_prob) {
                    $quitting_prob_lv2 = $nb_workers_lv2 / $nb_workers;
                    $pick = mt_rand() / mt_getrandmax();

                    $message = "";

                    if ($pick <= $quitting_prob_lv2) {
                        if ($nb_workers_lv2 == $nb_workers_lv2_busy) {
                            $this->updateIndicator("nb_workers_lv2_busy", $entreprise->id, -1);
                        }
                        $this->updateIndicator("nb_workers_lv2", $entreprise->id, -1);

                        $message = "Vos employés sont entrain de démissionner! Vous avez perdu un employé expert.";
                        $notification = [
                            "type" => "WorkersUpdate",
                            "status" => "warning",
                            "entreprise_id" => $entreprise->id,
                            "data" => [],
                            "message" => $message,
                            "title" => "Les employés démissionnent"
                        ];
                        event(new NewNotification($notification));
                    }

                    else {
                        if ($nb_workers_lv1 == $nb_workers_lv1_busy) {
                            $this->updateIndicator("nb_workers_lv1_busy", $entreprise->id, -1);
                        }
                        $this->updateIndicator("nb_workers_lv1", $entreprise->id, -1);

                        $message = "Vos employés sont entrain de démissionner! Vous avez perdu un employé simple.";
                        $notification = [
                            "type" => "WorkersUpdate",
                            "status" => "warning",
                            "entreprise_id" => $entreprise->id,
                            "data" => [],
                            "message" => $message,
                            "title" => "Les employés démissionnent"
                        ];
                        event(new NewNotification($notification));
                    }
                }
            }

            // Hire workers if company looking for
            $nb_workers_to_hire = $this->getIndicator("nb_workers_to_hire", $entreprise->id)["value"];

            if ($nb_workers_to_hire > 0) {
                $pick = mt_rand() / mt_getrandmax();
                $hiring_prob = nova_get_setting("hiring_prob");

                if ($pick < $hiring_prob) {
                    $this->updateIndicator("nb_workers_lv1", $entreprise->id, 1);
                    $this->updateIndicator("nb_workers_to_hire", $entreprise->id, -1);

                    $message = "Vous avez réussi à recruter un employé!";
                    $notification = [
                        "type" => "WorkersUpdate",
                        "status" => "info",
                        "entreprise_id" => $entreprise->id,
                        "data" => [],
                        "message" => $message,
                        "title" => "Employé recruté"
                    ];
                    event(new NewNotification($notification));
                }
            }
        }
    }
}
