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
                    $day_5s = $this->getIndicator("5s_day", $entreprise->id)["value"];

                    if ($day_5s < 30) {
                        $this->updateIndicator("5s_day", $entreprise->id, 1);
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
