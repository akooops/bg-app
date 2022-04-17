<?php

namespace App\Jobs;

use App\Traits\HelperTrait;
use Illuminate\Bus\Queueable;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
use Illuminate\Support\Facades\DB;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class AdScheduler implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels, IndicatorTrait, HelperTrait;

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
        $ads = DB::table("ads")->where("status", "=", "pending")->get();

        foreach ($ads as $ad) {
            // Compute weekly subscribers gain
            $weekly_result = $ad->predicted_result / $ad->days;
            $weekly_result = random_int(0.85 * $weekly_result, 1.15 * $weekly_result);

            // Compute the presence of the company
            $nb_subscribers = $this->getIndicator('nb_subscribers', $ad->entreprise_id)["value"];
            $presence = round($weekly_result / $nb_subscribers, 0);

            // Update number of subscribers of the company
            $this->updateIndicator('nb_subscribers', $ad->entreprise_id, $weekly_result);

            // Update the current number of subscribers in the ad's row of the database
            $ad->result += $weekly_result;
            DB::table("ads")->where("id", "=", "$ad->id")->increment("result", $weekly_result);

            // Update the presence given the ad's type
            $this->updateIndicator($ad->type . '_presence', $ad->entreprise_id, $presence);

            // Mark ad compaign as finished once it is
            $current_date = (int) $this->getSimulationTime();
            $end_date = $ad->creation_date + $ad->days;

            if ($current_date >= $end_date) {
                $ad->status = "done";
                DB::table("ads")->where("id", "=", "$ad->id")->update(["status" => "done"]);
            }

            // Send notification
            $notification = [
                "entreprise_id" => $ad->entreprise_id,
                "type" => "AdsUpdate",

                "store" => $ad->status == "done" ? true : false,

                "text" => "Votre campagne publicitaire sur " . $this->parseAdType($ad->type) . " est terminée, résultat final: " . $ad->result . " nouveaux abonnés.",
                "title" => "Campagne publicitaire",
                "icon_path" => "aaaaaaaaaaa",

                "style" => "info",
            ];
            event(new NewNotification($notification));
        }
    }
}
