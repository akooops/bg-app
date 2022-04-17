<?php

namespace App\Console;

use App\Jobs\DailyStats;
use App\Jobs\PenaltyLoan;
use App\Jobs\MonthlyCosts;
use App\Models\Entreprise;

use App\Traits\DemandTrait;

use App\Traits\HelperTrait;
use App\Jobs\ProcessWorkers;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
use Illuminate\Support\Facades\DB;
use App\Events\SimulationDateChanged;
use App\Jobs\AdScheduler;
use App\Jobs\SellProductionsScheduler;
use Illuminate\Support\Facades\Response;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    use HelperTrait, IndicatorTrait, DemandTrait;
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
        $game_status = nova_get_setting("game_started");

        if ($game_status == "1") {
            $schedule->call(function () {
                $current_date = (int) nova_get_setting("current_date");
                if ($current_date != null) {
                    $current_date += 1;
                } else {
                    $current_date = (int) nova_get_setting("start_date");
                }

                nova_set_setting_value("current_date", $current_date);
                event(new SimulationDateChanged($current_date));
            })->everyMinute();

            // Sell parts of productions that are on sale
            $schedule->job(new SellProductionsScheduler)->everyMinute();

            // Apply action on every entreprise
            $schedule->job(new ProcessWorkers)->everyMinute();

            // Sell parts of productions that are on sale
            $schedule->job(new MonthlyCosts)->everyMinute();

            // Take out penalty loans
            $schedule->job(new PenaltyLoan)->everyMinute();

            // Process ads that are still on going
            $schedule->job(new AdScheduler)->everyMinute();

            //$schedule->job(new DailyStats)->everyMinute();
            // $schedule->command('inspire')->hourly();
        }
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
