<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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
            'amount' => 'required|float',
        ]);
        $new_ad =  Loan::create([
            "entreprise_id" =>  $request->entreprise_id,
            "type" => $request->type,
            "amount" => $request->amount
        ]);
        $data = [
            "name" => Entreprise::find($request->entreprise_id)->name,
            "status" => "pending",
            "ad_id" => $new_ad->id,
            "amount" => $request->amount,
            "ad_creation" =>  (new \DateTime())->format('Y-m-d H:i:s')
        ];
        event(new LoanCreated($data));
        return response()->json("Votre demande a été envoyée avec succès", 200);

    }
    function updateAd(Request $request){
        $loan = Loan::find($request->ad_id);
        $loan->amount = $request->amount;
        $loan->status = $request->status;
        $loan->save();
        $notification = [
            "type" => "LoanStatusChanged",
            "entreprise_id" => $loan->entreprise_id,
            "data" => $loan,
            "message" => "Le statut de votre demande d'endettement a changé, veuillez consulter votre banque",
            "title" => "Demande d'endettement"
        ];
        event(new NewNotification($notification));
        return response()->json("Votre réponse a été envoyée avec succès à l'entreprise concernée", 200);
    }
}
