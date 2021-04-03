<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Ad;
use App\Jobs\UpdateAdStatus;
use App\Models\Entreprise;
class MarketingController extends Controller
{
    function getAd(Request $request){
        $ads = DB::table('ads')
        ->select("*",'ads.created_at as ad_creation','ads.id as ad_id')
        ->join('users','users.id','=','ads.entreprise_id')
        ->where('ads.entreprise_id',$request->entreprise_id)->orderBy('ad_creation', 'desc')->get();
        
        return $ads;
    }
    function createAd(Request $request){
        //Calculating result depending on the ad type
        $request->validate([
            'type' => 'required|string|max:255',
            'amount' => 'required',
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
        dd(stats_dens_normal($request->result,50,sqrt(10)));
        $new_ad = Ad::create([
            "entreprise_id" => $request->entreprise_id,
            "product_id" => $request->product,
            "type" => $request->type,
            "amount" => $request->amount,
            "start_date" => strtok($request->start_date, 'T'),
            "end_date" => strtok($request->end_date, 'T'),
            "result" => $request->result,
            "status" => "pending"
        ]);
        $delay = round($request->duration*30,0);
        //Calculating the real result 
        $result = stats_dens_normal($request->result,50,10);  
        // Process it with delayed queue to send a notif when it's done
        UpdateAdStatus::dispatch($new_ad,$result)->delay(now()->addMinutes($delay));
        return response()->json("Votre campagne publicitaire a commencé !", 200);

    }
}
