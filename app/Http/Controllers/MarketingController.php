<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Ad;
use App\Jobs\UpdateAdStatus;
use App\Models\Entreprise;
use App\Traits\IndicatorTrait;
use App\Traits\HelperTrait;

class MarketingController extends Controller
{
    use IndicatorTrait, HelperTrait;

    public function getAd(Request $request) {
        $ads = DB::table('ads')
        ->select("*",'ads.id as ad_id','ads.type as ad_type')
        ->join('users','users.id','=','ads.entreprise_id')
        ->where('ads.entreprise_id',$request->entreprise_id)->orderBy('creation_date', 'desc')->get();
        $ads = collect($ads)->map(function($ad){
            return [
                "entreprise_id" => $ad->entreprise_id,
                "ad_type" => $this->parseAdType($ad->ad_type),
                "status" => $this->parseAdStatus($ad->status),
                "days" => $ad->days,
                "result" => $ad->result,
                "creation_date" => $ad->creation_date,
                "amount" => $ad->amount
            ];
        });
        return $ads;
    }

    public function createAd(Request $request){
        //Validating Data depending on the ad type
        $request->validate([
            'type' => 'required|string|max:255',
            'total_amount' => 'required',
            'days' => 'required',
        ]);

        //Must check if
        /*
        $entrep=Entreprise::find($request->entrepris_id);
        if($request->amount>=$entrep->){
            return response()->json("Vos disponbilités ne suffisent pas a financier votre campagne publicitaire !", 404);
        }
        */

        // Saving the expected result
        $new_ad = Ad::create([
            "entreprise_id" => $request->entreprise_id,
            "type" => $request->type,
            "amount" => $request->total_amount,
            "days" => $request->days,
            "result" => $request->result,
            "creation_date" => (int) $this->getSimulationTime(),
            "status" => "pending"
        ]);

        //Calculating the real result
        $result = random_int(0.85*$request->result, 1.15*$request->result);

        // Calculating the {type} presence
        $nb_subscribers = $this->getIndicator('nb_subscribers', $request->entreprise_id)["value"];
        $presence = round($result/$nb_subscribers, 0);
        $this->updateIndicator('caisse', $request->entreprise_id, -$request->total_amount);

        // Process it with delayed queue to send a notif when it's done
        UpdateAdStatus::dispatch($new_ad,$result,$presence)->delay(now()->addMinutes($request->days));
        return response()->json("Votre campagne publicitaire a commencé ! cette page va se recharger automatiquement dans 4 secondes", 200);
    }

    public function getMarketingIndicators(Request $request){
        // Return production useful indicators
        $keys = ["nb_subscribers","social_presence","media_presence","events_presence"];
        $entreprise_id = $request->entreprise_id;
        $resp = [];
        foreach ($keys as $ind) {
            $value = $this->getIndicator($ind,$entreprise_id);
            $resp[$ind] = $value;
        }
        return $resp;
    }
}
