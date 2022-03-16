<?php

namespace App\Console;

use App\Jobs\DailyStats;
use App\Jobs\PenaltyLoan;
use App\Jobs\MonthlyCosts;
use App\Models\Entreprise;

use App\Traits\HelperTrait;

use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
use App\Events\SimulationDateChanged;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    use HelperTrait, IndicatorTrait;
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        //
    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        $schedule->call(function () {
            //Checking if the simulation started
            $game_status = nova_get_setting("game_started", null);
            if ($game_status === "1") {
                $current_date = nova_get_setting("current_date");
                if ($current_date != null) {
                    $current_date += 1;
                } else {
                    $current_date = nova_get_setting("start_date");
                }

                nova_set_setting_value("current_date", $current_date);
                event(new SimulationDateChanged($current_date));

                if ($current_date % 30 == 0) {
                    MonthlyCosts::dispatch();
                }

                PenaltyLoan::dispatch();

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

                    $nb_workers_lv1_busy = $this->getIndicator("nb_workers_lv1_busy", $entreprise->id)["value"];
                    $nb_workers_lv2_busy = $this->getIndicator("nb_workers_lv2_busy", $entreprise->id)["value"];

                    $workers_mood = $this->getIndicator("workers_mood", $entreprise->id)["value"];
                    $workers_mood_th = nova_get_setting("mood_quitting_threshold");

                    if ($workers_mood - nova_get_setting('workers_mood_decay_rate') < $workers_mood_th) {

                        $notification = [
                            "type" => "MoodWarning",
                            "status" => "warning",
                            "entreprise_id" => $entreprise->id,
                            "data" => [],
                            "message" => "Attention, l'humeur de vos employés est mauvaise, Il y a des riques de démissions.",
                            "title" => "Risques de démissions"
                        ];
                        event(new NewNotification($notification));
                    }

                    if ($workers_mood <= $workers_mood_th) {
                        $pick = mt_rand() / mt_getrandmax();
                        $quitting_prob = nova_get_setting("quitting_prob");

                        if ($pick <= $quitting_prob) {
                            $quitting_prob_lv2 = $nb_workers_lv2 / ($nb_workers_lv1 + $nb_workers_lv2);
                            $pick = mt_rand() / mt_getrandmax();

                            $message = "";
                            if ($pick <= $quitting_prob_lv2) {
                                if ($nb_workers_lv2 == $nb_workers_lv2_busy) {
                                    $this->updateIndicator("nb_workers_lv2_busy", $entreprise->id, -1);
                                }
                                $this->updateIndicator("nb_workers_lv2", $entreprise->id, -1);

                                $message = "Vos employés sont entrain de démissionner! Vous avez perdu un employé expert.";
                            } else {
                                if ($nb_workers_lv1 == $nb_workers_lv1_busy) {
                                    $this->updateIndicator("nb_workers_lv1_busy", $entreprise->id, -1);
                                }
                                $this->updateIndicator("nb_workers_lv1", $entreprise->id, -1);

                                $message = "Vos employés sont entrain de démissionner! Vous avez perdu un employé simple.";
                            }


                            $notification = [
                                "type" => "EmployeesQuitting",
                                "status" => "warning",
                                "entreprise_id" => $entreprise->id,
                                "data" => [],
                                "message" => $message,
                                "title" => "Les employés démissionnent"
                            ];
                            event(new NewNotification($notification));
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
                                "type" => "EmployeesHired",
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
        })->everyMinute();
        // $schedule->job(new PenaltyLoan)->everyMinute();
        //$schedule->job(new DailyStats)->everyMinute();
        // $schedule->command('inspire')->hourly();
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__ . '/Commands');

        require base_path('routes/console.php');
    }
}
