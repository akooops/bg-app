<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use App\Traits\HelperTrait;
use App\Events\SimulationDateChanged;

use App\Jobs\DailyStats;

use App\Jobs\MonthlyCosts;
use App\Jobs\PenaltyLoan;

class Kernel extends ConsoleKernel
{
    use HelperTrait;
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
                if (nova_get_setting("current_date") != null) {
                    $value = nova_get_setting("current_date") + 1;
                } else {
                    $value = nova_get_setting("start_date") + 1;
                }
                nova_set_setting_value("current_date", $value);
                event(new SimulationDateChanged($value));
            }
        })->everyMinute();
        $schedule->job(new MonthlyCosts)->everyThirtyMinutes();
        $schedule->job(new PenaltyLoan)->everyMinute();
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
