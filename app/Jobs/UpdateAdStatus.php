<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use App\Models\Ad;
use App\Models\Product;
use App\Events\NewNotification;
use App\Traits\IndicatorTrait;
use App\Traits\HelperTrait;

class UpdateAdStatus implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels, IndicatorTrait, HelperTrait;
    public $result;
    public $ad;
    public $presence;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct(Ad $ad, $result, $presence)
    {
        $this->ad = $ad;
        $this->result = $result;
        $this->presence = $presence;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $this->ad->status = "done";
        $this->ad->result = $this->result;
        $this->ad->save();

        $this->updateIndicator('nb_subscribers', $this->ad->entreprise_id, $this->result);
        $this->updateIndicator($this->ad->type . '_presence', $this->ad->entreprise_id, $this->presence);

        $notification = [
            "entreprise_id" => $this->ad->entreprise_id,
            "type" => "AdsUpdate",
            // "data" =>  $this->ad,

            "store" => true,

            "text" => "Votre campagne publicitaire sur " . $this->parseAdType($this->ad->type) . " est terminée.",
            "title" => "Campagne publicitaire",
            "icon_path" => "/assets/icons/info.svg",

            "style" => "info",
        ];
        event(new NewNotification($notification));
    }
}
