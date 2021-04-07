<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use App\Traits\IndicatorTrait;
use App\Models\Entreprise;
use App\Models\Loan;
class MonthlyCosts implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels,IndicatorTrait;

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
        $salary = nova_get_setting('salary_production');
        $entreprises = Entreprise::get(); 
        foreach ($entreprises as $entreprise) {
            //Removing salary costs
            $workers = $this->getIndicator('nb_workers',$entreprise->id);
            $this->updateIndicator('caisses',$entreprise->id,-$workers*$salary);
            //Increasing loan_rate for the non-paid loans
            $loans = Loan::where('entreprise_id',$entreprise->id)->where('status','accepted')->where('payment_status',0)->get();
            foreach($loans as $loan){
                $loan->ratio+= 0.01;
                $loan->save();
                $this->updateIndicator('dettes',$entreprise->id,0.01*$loan->remaining_amount);
            }

        }
        

    }
}
