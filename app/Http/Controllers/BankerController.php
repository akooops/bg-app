<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Banker;
use App\Models\Loan;
use App\Models\Entreprise;
use Illuminate\Support\Facades\DB;
use App\Events\LoanCreated;
use App\Events\NewNotification;


class BankerController extends Controller
{
    function showDashboard(){
    	//$loans = loans::all();
    	//return view("dashboard",["departments"=>$departments]);
    }
    function getLoan(Request $request){
        
        if(isset($request->entreprise_id)){
            $loans = DB::table('loans')
            ->select("*",'loans.created_at as loan_creation','loans.id as loan_id')
            ->join('users','users.id','=','loans.entreprise_id')
            ->where('loans.entreprise_id',$request->entreprise_id)->orderBy('loan_creation', 'desc')->get();
            
            return $loans;
        }
        $loans = DB::table('loans')->where('status','pending')
        ->select("*",'loans.created_at as loan_creation','loans.id as loan_id')
        ->join('users','users.id','=','loans.entreprise_id')->orderBy('loan_creation', 'desc')->get();
        
        return $loans;
    }
    function createLoan(Request $request){
        $new_loan =  Loan::create([
            "entreprise_id" =>  $request->entreprise_id,
            "banker_id" => Banker::first()->id,
            "status"    => "pending",
            "amount" => $request->amount
        ]);
        $data = [
            "name" => Entreprise::find($request->entreprise_id)->name,
            "status" => "pending",
            "loan_id" => $new_loan->id,
            "amount" => $request->amount,
            "loan_creation" =>  (new \DateTime())->format('Y-m-d H:i:s')
        ];
        event(new LoanCreated($data));
        return response()->json("Votre demande a été envoyée avec succès", 200);

    }
    function updateLoan(Request $request){
        $loan = Loan::find($request->loan_id);
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
