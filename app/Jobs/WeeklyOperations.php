<?php

namespace App\Jobs;

use App\Traits\HelperTrait;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\DB;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class WeeklyOperations implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    use HelperTrait;

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
        $current_date = (int) $this->get_game_setting("current_date");

        // Delete old rows from stats and notifications tables
        $nb_stat_weeks_to_keep = 20;
        $nb_notif_weeks_to_keep = 20;

        DB::table('stats')->where('date', '<', $current_date - $nb_stat_weeks_to_keep)->delete();
        DB::table('notifications')->where('time', '<', $current_date - $nb_notif_weeks_to_keep)->delete();

        // Refresh products' left demand every week
        DB::table('products')->update(['left_demand' => DB::raw('avg_demand')]);
    }
}
