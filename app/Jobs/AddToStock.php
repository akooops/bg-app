<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;

class AddToStock implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels,IndicatorTrait;
    public $stock_items;
    public $cost;
    public $entreprise_id;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($stock_items,$cost,$entreprise_id)
    {
        $this->stock_items = $stock_items;
        $this->cost = $cost;
        $this->entreprise_id = $entreprise_id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $entreprise_id = $this->entreprise_id;
        $cost = $this->cost;
        foreach ($this->stock_items as $stock_item) {
            $stock = DB::table("raw_materials_stock")->where("raw_material_id","=",$stock_item["raw_material_id"])->where("entreprise_id","=",$stock_item["entreprise_id"]);
            //dd(count($stock->get()->toArray()));
            if(count($stock->get()->toArray()) == 0){
                DB::table("raw_materials_stock")->insert($stock_item);
            }
            else{
                // update quant
                $quant = $stock_item["quantity"];
                $stock->increment("quantity",$quant);
            }
        }
        //dd("working until now");
        $this->updateIndicator("raw_materials_cost",$entreprise_id,$cost);
        $this->updateIndicator("caisse",$entreprise_id,-1*$cost);
  
        $message = "Votre commande a été livrée";

        $notification = [
            "type" => "CommandDelivered",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Commande Livrée"
        ];
        event(new NewNotification($notification));
    }
}
