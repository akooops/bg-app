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
    public function getAd(Request $request){
        $ads = DB::table('ads')
        ->select("*",'ads.created_at as ad_creation','ads.id as ad_id','ads.type as ad_type')
        ->join('users','users.id','=','ads.entreprise_id')
        ->where('ads.entreprise_id',$request->entreprise_id)->orderBy('ad_creation', 'desc')->get();
        $ads = collect($ads)->map(function($ad){
            return [
                "entreprise_id" => $ad->entreprise_id,
                "ad_type" => $this->parseAdType($ad->ad_type),
                "status" => $this->parseAdStatus($ad->status),
                "start_date" => $ad->start_date,
                "end_date" => $ad->end_date,
                "result" => $ad->result,
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
            'start_date' => 'required|date',
            'end_date' => 'required|date',
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
            "status" => "pending"
        ]);
        $delay = round($request->days*30,0);
        //Calculating the real result 
        $result = random_int(0.8*$request->result,1.2*$request->result);
        // Calculating the {type} presence
        $nb_subscribers = $this->getIndicator('nb_subscribers',$request->entreprise_id)["value"];
        $presence = round($result/$nb_subscribers,0);
        $this->updateIndicator('caisse',$request->entreprise_id,-1000*$request->total_amount);
        // Process it with delayed queue to send a notif when it's done
        UpdateAdStatus::dispatch($new_ad,$result,$presence)->delay(now()->addMinutes($delay));
        return response()->json("Votre campagne publicitaire a commencé ! cette page va se recharger automatiquement dans 5 secondes", 200);
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
