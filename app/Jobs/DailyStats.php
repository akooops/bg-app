<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use App\Models\Entreprise;
use App\Traits\IndicatorTrait;
use App\Traits\HelperTrait;

class DailyStats implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels, IndicatorTrait, HelperTrait ;

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
        $entreprises = Entreprise::all();
        $data = [];
        foreach ($entreprises as $entrep) {
            $entreprise_id = $entrep->id;
            $daily_data = [
                "entreprise_id" => $entreprise_id,
                "day" => $this->getSimulationTime(),
                "sales" =>  $this->getIndicator("ca",$entreprise_id)["value"],
                "caisse" => $this->getIndicator("caisse",$entreprise_id)["value"]
            ];
            array_push($data, $daily_data);
        }
        DB::table('daily_stats')->insert($data);
        //dd("Daily stats added");
    }
}
