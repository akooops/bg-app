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
use App\Jobs\StatsScheduler;
use App\Jobs\WeeklyOperations;
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
        $game_status = $this->get_game_setting("game_started");

        if ($game_status == "1") {
            // Increment week, clean DB from unused data, also refresh demand on products
            $schedule->job(new WeeklyOperations)->everyMinute();

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

            // Register weekly stats
            $schedule->job(new StatsScheduler)->everyMinute();

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
