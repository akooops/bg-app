<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use App\Models\Loan;
use App\Traits\HelperTrait;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
class PenaltyLoan 
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels,HelperTrait,IndicatorTrait;

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
        $loans = Loan::where('payment_status',0)->where('status','accepted')->get();
        foreach($loans as $loan){
            
            $time = (int) $this->getSimulationtime();
            if($loan->days < $time){
                $loan->days += $loan->deadline;
                $debt = round(0.1*$loan->ratio*0.01*$loan->remaining_amount,2);
                $loan->remaining_amount += $debt;
                $this->updateIndicator('dettes',$loan->entreprise_id,$debt);
                $loan->ratio += 0.1*$loan->ratio;
                $loan->save();
                $notification = [
                    "type" => "LoanRateChanged",
                    "status" => "warning",
                    "entreprise_id" => $loan->entreprise_id,
                    "data" => [],
                    "message" => "Le taux d'intérêt de votre dette a augmenté, il est désormais ".$loan->ratio. " %" ,
                    "title" => "Retard d'endettement"
                ];
                event(new NewNotification($notification));
            }
        }
    }
}
