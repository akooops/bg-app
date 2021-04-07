<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Banker;
use App\Models\Loan;
use App\Models\Entreprise;
use Illuminate\Support\Facades\DB;
use App\Events\LoanCreated;
use App\Events\NewNotification;
use App\Traits\HelperTrait;
use App\Traits\IndicatorTrait;
use Carbon\Carbon;
class BankerController extends Controller
{
    use HelperTrait,IndicatorTrait;
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
          
            return collect($loans)->map(function($loan){
                return [
                    "loan_id" => $loan->loan_id,
                    "amount" => $loan->amount,
                    "status" => $this->parseLoanStatus($loan->status),
                    "ratio"  => $loan->ratio,
                    "debt_ratio" => $this->getIndicator('debt_ratio',$loan->entreprise_id)['value'],
                    "loan_creation" => $this->parseDateToSimulationDate(Carbon::parse($loan->loan_creation)),
                    "payment_status" => $loan->payment_status,
                    "remaining_amount" => $loan->remaining_amount
                ];
            });
            }
        $loans = DB::table('loans')->where('status','pending')
        ->select("*",'loans.created_at as loan_creation','loans.id as loan_id')
        ->join('users','users.id','=','loans.entreprise_id')->orderBy('loan_creation', 'desc')->get();
        return collect($loans)->map(function($loan){
            return [
                "name" => $loan->name,
                "loan_id" => $loan->loan_id,
                "amount" => $loan->amount,
                "status" => $this->parseLoanStatus($loan->status),
                "debt_ratio" => $this->getIndicator('debt_ratio',$loan->entreprise_id)['value'],
                "loan_creation" => $loan->loan_creation,
            ];
        });
    }
    function createLoan(Request $request){
        $new_loan =  Loan::create([
            "entreprise_id" =>  $request->entreprise_id,
            "banker_id" => Banker::first()->id,
            "status"    => "pending",
            "amount" => $request->amount,
        ]);
        $data = [
            "name" => Entreprise::find($request->entreprise_id)->name,
            "status" => "pending",
            "loan_id" => $new_loan->id,
            "amount" => $request->amount,
            "debt_ratio" => $this->getIndicator('debt_ratio',$request->entreprise_id)['value'],
            "loan_creation" =>  $this->parseDateToSimulationDate(nova_get_setting('current_date')),
        ];
        event(new LoanCreated($data));
        return response()->json("Votre demande a été envoyée avec succès", 200);

    }
    function updateLoan(Request $request){
        $loan = Loan::find($request->loan_id);
        $loan->amount = $request->amount;
        $loan->status = $request->status;
        $loan->ratio = $request->ratio;
        if($loan->status=="accepted"){
            $loan->payment_status = false;
        }
        $loan->save();
        $this->updateIndicator('caisse',$loan->entreprise_id,$request->amount);
        $this->updateIndicator('dettes',$loan->entreprise_id,$request->amount);
        //Calculating the newest debt ratio and loan_rate 
        $old_ratio = $this->getIndicator('debt_ratio',$loan->entreprise_id)['value'];
        $debt_ratio = round($this->getIndicator('dettes',$loan->entreprise_id)['value']/ $this->getIndicator('caisse',$loan->entreprise_id)['value'],2);
        $this->updateIndicator('debt_ratio',$loan->entreprise_id,$debt_ratio-$old_ratio);
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
    function payLoan(Request $request){
        
    }
}
