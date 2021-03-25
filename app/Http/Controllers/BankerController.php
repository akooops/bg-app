<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Banker;
use App\Models\Loan;
use App\Models\Entreprise;
use Illuminate\Support\Facades\DB;
use App\Events\LoanCreated;


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
        Loan::create([
            "entreprise_id" =>  $request->entreprise_id,
            "banker_id" => Banker::first()->id,
            "status"    => "pending",
            "amount" => $request->amount
        ]);
        $loan = [
            "name" => Entreprise::find($request->entreprise_id)->name,
            "status" => "pending",
            "amount" => $request->amount,
            "loan_creation" =>  (new \DateTime())->format('Y-m-d H:i:s')
        ];
        event(new LoanCreated($loan));
        return response()->json("Votre demande a été envoyé avec succès", 200);

    }
}
