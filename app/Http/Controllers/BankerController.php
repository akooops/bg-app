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
    use HelperTrait, IndicatorTrait;
    function showDashboard()
    {
        //$loans = loans::all();
        //return view("dashboard",["departments"=>$departments]);
    }
    function getLoan(Request $request)
    {

        if ($request->entreprise_id != null) {
            $loans = DB::table('loans')
                ->select("*", 'loans.id as loan_id')
                ->join('users', 'users.id', '=', 'loans.entreprise_id')
                ->where('loans.entreprise_id', $request->entreprise_id)->orderBy('creation_date', 'desc')->get();

            return collect($loans)->map(function ($loan) {
                return [
                    "loan_id" => $loan->loan_id,
                    "amount" => $loan->amount,
                    "status" => $this->parseLoanStatus($loan->status),
                    "ratio"  => $loan->ratio,
                    "debt_ratio" => $this->getIndicator('debt_ratio', $loan->entreprise_id)['value'],
                    "loan_creation" => $loan->creation_date,
                    "payment_status" => $loan->payment_status,
                    "remaining_amount" => $loan->remaining_amount,
                    "deadline" => $loan->deadline
                ];
            });
        }
        $loans = DB::table('loans')->where('status', 'pending')
            ->select("*", 'loans.id as loan_id')
            ->join('users', 'users.id', '=', 'loans.entreprise_id')->orderBy('creation_date', 'desc')->get();
        return collect($loans)->map(function ($loan) {
            return [
                "name" => $loan->name,
                "loan_id" => $loan->loan_id,
                "amount" => $loan->amount,
                "status" => $this->parseLoanStatus($loan->status),
                "debt_ratio" => round($this->getIndicator('debt_ratio', $loan->entreprise_id)['value'], 2),
                "loan_creation" => $loan->creation_date,
            ];
        });
    }
    function createLoan(Request $request)
    {
        // Do the checks
        if ($request->amount <= 0) {
            return response()->json(["message" => "Impossible d'effectuer un prêt avec une somme nulle ou négative", "success" => false], 200);
        }

        if ($request->deadline <= 0) {
            return response()->json(["message" => "Impossible d'effectuer un prêt avec un délai nul ou négatif", "success" => false], 200);
        }

        if ($request->ratio <= 0) {
            return response()->json(["message" => "Impossible d'effectuer un prêt avec un ratio nul ou négatif", "success" => false], 200);
        }

        // Create new loan and add it to database
        Loan::create([
            "entreprise_id" =>  $request->entreprise_id,

            "banker_id" => Banker::first()->id, // This is now useless, should drop column

            "status"    => "accepted",

            "amount" => $request->amount,

            "ratio" => $request->ratio,

            "deadline" => $request->deadline,
            "days" => (int) $this->getSimulationTime() + $request->deadline,
            "creation_date" => (int) $this->getSimulationTime(),

            "remaining_amount" => $request->amount,
            "payment_status" => false,
        ]);

        // Update indicators
        $this->updateIndicator('caisse', $request->entreprise_id, $request->amount);
        $this->updateIndicator('dettes', $request->entreprise_id, $request->amount);

        // Send notification
        $notification = [
            "entreprise_id" => $request->entreprise_id,
            "type" => "LoansUpdate",

            "store" => true,

            "title" => "Demande d'endettement",
            "text" => "Prêt de " . $request->amount . "DA effectué, veillez à le rembourser avant les délais pour éviter une augmentation d'intérêts",
            "icon_path" => "aaaaaaaaaaa",

            "style" => "success",
        ];
        event(new NewNotification($notification));

        // $data = [
        //     "name" => Entreprise::find($request->entreprise_id)->name,
        //     "status" => "pending",
        //     "loan_id" => $new_loan->id,
        //     "amount" => $request->amount,
        //     "debt_ratio" => round($this->getIndicator('debt_ratio', $request->entreprise_id)['value'], 2),
        //     "creation_date" => (int) $this->getSimulationTime(),
        // ];
        // event(new LoanCreated($data));

        return response()->json(["message" => "Votre demande a été envoyée avec succès.", "success" => true], 200);
    }

    function updateLoan(Request $request)
    {
        $loan = Loan::find($request->loan_id);
        $loan->amount = $request->amount;
        $loan->status = $request->status;

        if ($loan->status == "accepted") {
            $loan->deadline = $request->deadline;
            $loan->ratio = $request->ratio;
            $loan->remaining_amount = $request->amount * (1 + 0.01 * $loan->ratio);
            $loan->days = $request->deadline + $loan->creation_date;
            $loan->payment_status = false;
            $this->updateIndicator('caisse', $loan->entreprise_id, $request->amount);
            $this->updateIndicator('dettes', $loan->entreprise_id, $request->amount * (1 + 0.01 * $request->ratio));
        }
        $loan->save();

        //Calculating the newest debt ratio and loan_rate
        $old_ratio = $this->getIndicator('debt_ratio', $loan->entreprise_id)['value'];
        $debt_ratio = round($this->getIndicator('dettes', $loan->entreprise_id)['value'] / $this->getIndicator('caisse', $loan->entreprise_id)['value'], 2);
        $this->updateIndicator('debt_ratio', $loan->entreprise_id, round($debt_ratio - $old_ratio, 2));

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

    function payLoan(Request $request)
    {
        // Get the loan
        $loan = Loan::find($request->loan_id);

        // Do the checks
        if ($request->refund_amount <= 0) {
            return response()->json(["message" => "Impossible de payer la dette: Le montant à payer doit être positif", "success" => false], 200);
        }

        if ($this->getIndicator("caisse", $request->entreprise_id) < $loan->remaining_amount) {
            return response()->json(["message" => "Impossible de payer la dette: Le montant à payer spécifié dépasse vos disponnibilités", "success" => false], 200);
        }

        if ($loan->remaining_amount < $request->refund_amount) {
            return response()->json(["message" => "Impossible de payer la dette: Le montant à payer doit être inférieur à la dette restante", "success" => false], 200);
        }

        // Update the loan
        $loan->remaining_amount = $loan->remaining_amount - $request->refund_amount;
        if ($loan->remaining_amount <= 0) {
            $loan->payment_status = true;
        }

        $loan->save();

        // Update the indicators
        $this->updateIndicator("caisse", $request->entreprise_id, -$request->refund_amount);
        $this->updateIndicator("dettes", $request->entreprise_id, -$request->refund_amount);

        // Send notification
        $notification = [
            "entreprise_id" => $request->entreprise_id,
            "type" => "LoansUpdate",

            "store" => $loan->payment_status ? true : false,

            "title" => "Payement de dette",
            "text" => "Vous avez fini de rembourser la dette",
            "icon_path" => "aaaaaaaaaaa",

            "style" => "success",
        ];
        event(new NewNotification($notification));

        return response()->json(["message" => "Votre virement a été envoyé à la banque avec succès", "success" => true], 200);
    }
}
