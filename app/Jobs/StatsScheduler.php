<?php

namespace App\Jobs;

use App\Models\Entreprise;
use App\Traits\HelperTrait;
use Illuminate\Bus\Queueable;
use App\Traits\IndicatorTrait;
use Illuminate\Support\Facades\DB;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use App\Events\NewNotification;

class StatsScheduler implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    use IndicatorTrait;

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

        foreach ($entreprises as $entrep) {
            $indicators = ['caisse', 'dettes', 'ca_5', 'ca_6', 'ca_7', 'ca_8', 'ca_9'];

            foreach ($indicators as $ind) {
                $row = [
                    'entreprise_id' => $entrep->id,
                    'indicator' => $ind,
                    'value' => $this->getIndicator($ind, $entrep->id)['value'],
                    'date' => (int) $this->getSimulationTime(),
                ];

                DB::table('stats')->insert($row);
            }

            $notification = [
                "entreprise_id" => $entrep->id,
                "type" => "StatsUpdate",

                "store" => false,

                "text" => "",
                "title" => "",
                "icon_path" => "",

                "style" => "",
            ];
            event(new NewNotification($notification));
        }
    }
}
