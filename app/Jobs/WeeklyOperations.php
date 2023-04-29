<?php

namespace App\Jobs;

use App\Models\Entreprise;
use App\Traits\HelperTrait;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\DB;
use App\Events\SimulationDateChanged;
use App\Models\Product;
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

        // Change current week
        if ($current_date != null) {
            $current_date += 1;
        } else {
            $current_date = (int) $this->get_game_setting("start_date");
        }

        $this->set_game_setting("current_date", $current_date);

        // Delete old rows from stats and notifications tables
        $nb_stat_weeks_to_keep = 10;
        $nb_notif_weeks_to_keep = 10;

        DB::table('stats')->where('date', '<', $current_date - $nb_stat_weeks_to_keep)->delete();
        DB::table('notifications')->where('time', '<', $current_date - $nb_notif_weeks_to_keep)->delete();

        // Compute new avg demand for the seasonal product
        $x = $current_date % 52;
        $pop_percent = 0;
        if ($x <= 13 || 39 <= $x) {
            $pop_percent = 0;
        }
        else {
            $val = ($x - 13) / 26;
           // $pop_percent = 0.8 * sqrt( 1 - $val ) * $val * exp($val);
           $pop_percent = (1-(pow((($val-0.375)*2-0.25),2)))*exp(pow((($val-0.375)*2-0.25),2));
        }

        DB::table('products')->where('id', '=', 7)->update(['percent_population' => $pop_percent]);

        // Refresh products' left demand every week
        $nb_entrep = count(Entreprise::all());
        $population = $this->get_game_setting('population');        ;
        $coeff = $population ;
       // $coeff = $nb_entrep * $population / 2;

        $products = Product::all();
        foreach($products as $product) {
            DB::table('products')->where('id', $product->id)->update(['left_demand' =>  $product->lot_quantity]);
        }

        // Send changing date event
        event(new SimulationDateChanged());
    }
}
