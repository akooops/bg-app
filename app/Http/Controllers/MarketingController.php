<?php

namespace App\Http\Controllers;

use App\Models\Ad;
use App\Models\Entreprise;
use App\Traits\HelperTrait;
use App\Jobs\UpdateAdStatus;
use Illuminate\Http\Request;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
use Illuminate\Support\Facades\DB;

class MarketingController extends Controller
{
    use IndicatorTrait, HelperTrait;

    public function getAd(Request $request)
    {
        $ads = DB::table('ads')
            ->select("*", 'ads.id as ad_id', 'ads.type as ad_type')
            ->join('users', 'users.id', '=', 'ads.entreprise_id')
            ->where('ads.entreprise_id', $request->entreprise_id)->orderBy('creation_date', 'desc')->get();
        $ads = collect($ads)->map(function ($ad) {
            return [
                "entreprise_id" => $ad->entreprise_id,
                "ad_type" => $this->parseAdType($ad->ad_type),
                "status" => $this->parseAdStatus($ad->status),
                "days" => $ad->days,
                "result" => $ad->result,
                "predicted_result" => $ad->predicted_result,
                "creation_date" => $ad->creation_date,
                "amount" => $ad->amount
            ];
        });
        return $ads;
    }

    public function createAd(Request $request)
    {
        //Validating Data depending on the ad type
        $request->validate([
            'type' => 'required|string|max:255',
            'total_amount' => 'required',
            'days' => 'required',
        ]);


        // Check if enough money
        $entreprise_id = $request->entreprise_id;
        $caisse = $this->getIndicator("caisse", $entreprise_id)["value"];

        if ($caisse < $request->total_amount) {
            return response()->json(["message" => "Vos disponbilités ne suffisent pas pour financer cette campagne publicitaire.", "success" => false], 404);
        }

        if ($request->days <= 0) {
            return response()->json(["message" => "La durée doit être positive.", "success" => false], 404);
        }

        if ($request->result <= 0) {
            return response()->json(["message" => "Le résultat doit être positif.", "success" => false], 404);
        }

        if (! in_array($request->type, ['social', 'media', 'events'])) {
            return response()->json(["message" => "Le type spécifié est erroné.", "success" => false], 404);
        }

        // Saving the expected result
        $new_ad = Ad::create([
            "entreprise_id" => $request->entreprise_id,
            "type" => $request->type,
            "amount" => $request->total_amount,
            "days" => $request->days,
            "predicted_result" => $request->result,
            "result" => 0,
            "creation_date" => (int) $this->getSimulationTime(),
            "status" => "pending"
        ]);

        // Send notification
        $notification = [
            "entreprise_id" => $request->entreprise_id,
            "type" => "AdsUpdate",

            "store" => false,

            "text" => "",
            "title" => "",
            "icon_path" => "aaaaaaaaaaa",

            "style" => "info",
        ];
        event(new NewNotification($notification));

        //Calculating the real result
        // $result = random_int(0.85 * $request->result, 1.15 * $request->result);

        // Calculating the {type} presence
        // $nb_subscribers = $this->getIndicator('nb_subscribers', $request->entreprise_id)["value"];
        // $presence = round($result / $nb_subscribers, 0);

        // Update money
        $this->updateIndicator('caisse', $request->entreprise_id, -$request->total_amount);

        // Process it with delayed queue to send a notif when it's done
        // UpdateAdStatus::dispatch($new_ad, $result, $presence)->delay(now()->addMinutes($request->days));
        return response()->json(["message" => "Votre campagne publicitaire a commencé.", "success" => true], 200);
    }

    public function getMarketingIndicators(Request $request)
    {
        // Return marketing useful indicators
        $keys = ["nb_subscribers", "social_presence", "media_presence", "events_presence", "ca"];
        $entreprise_id = $request->entreprise_id;
        $resp = [];
        foreach ($keys as $ind) {
            $value = $this->getIndicator($ind, $entreprise_id);
            $resp[$ind] = $value;
        }
        return $resp;
    }
}
