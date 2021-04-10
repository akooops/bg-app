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
use Illuminate\Support\Facades\DB;
use App\Events\NewNotification;
use App\Models\Banker;
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
        $salary =(int) nova_get_setting('salary_production');
        $mp_stock_price =(int) nova_get_setting('mp_stock_price');
        $entreprises = Entreprise::get(); 
        foreach ($entreprises as $entreprise) {
            $caisse = $this->getIndicator('caisse',$entreprise->id)['value'];
            //Removing salary costs
            $cost = 0;
            $workers = $this->getIndicator('nb_workers',$entreprise->id)['value'];
            $cost += $workers*$salary;
            //Removing stock costs
            $raw_materials =  DB::table("raw_materials_stock")->where("entreprise_id","=",$entreprise->id)->where('quantity','<>',0)->get();
            foreach($raw_materials as $raw_material){
                $cost+= $raw_material->quantity*$mp_stock_price;
            }
            if($cost>$caisse){
                $difference = $cost-$caisse;
                $this->updateIndicator("caisse",$entreprise->id,-$caisse);
                $new_loan =  Loan::create([
                    "entreprise_id" => $entreprise->id,
                    "banker_id" => Banker::first()->id,
                    "status"    => "accepted",
                    "amount" => $difference,
                    "remaining_amount" => $difference,
                    "rate" => 4,
                    "payment_status" => 0,
                    "creation_date" => (int) $this->getSimulationTime(),
                    "deadline"=> 15,
                    "days" =>  $this->getSimulationTime()+15
                ]);
                $this->updateIndicator("dettes",$entreprise->id,$difference);
                $notification = [
                    "type" => "NewLoan",
                    "status" => "warning",
                    "entreprise_id" => $entreprise->id,
                    "data" => [],
                    "message" => "Vos disponibilités ne suffisent pas pour payer les charge de ce mois, une nouvelle dette s'est ajoutée automatiquement" ,
                    "title" => "Manque disponibilités"
                ];
                event(new NewNotification($notification));
            }
            else{
                $this->updateIndicator('caisse',$entreprise->id,-$cost);
            }
            

        }
        

    }
}
