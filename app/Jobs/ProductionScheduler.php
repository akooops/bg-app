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
use App\Models\Product;
use App\Events\NewNotification;
class ProductionScheduler implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels, IndicatorTrait;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public $production;
    public $production_id;
    public function __construct($production,$prod_id)
    {
       $this->production = $production;
       $this->production_id = $prod_id; 
      
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $entreprise_id = $this->production["entreprise_id"];
        $product_id = $this->production["product_id"];
        $stock = DB::table("stock")->where("product_id","=",$product_id)->where("entreprise_id","=",$entreprise_id);
            //dd(count($stock->get()->toArray()));
        if(count($stock->get()->toArray()) == 0){
            DB::table("stock")->insert([
            "entreprise_id" => $entreprise_id,
            "product_id" => $product_id,
            "quantity" => $this->production["quantity"],
            "phase" => 0
            ]);
            }
        else{
                // update quant
                $quant = $this->production["quantity"];
                $stock->increment("quantity",$quant);
            }
        
        // Update production table 
        DB::table("productions")->where("id","=",$this->production_id)->update(["status"=>"completed"]);
        // Remove from raw materials stock
        $product = Product::find($product_id);

        $materials = $product->rawMaterials()->get();
        
        $materials->map(function($mat) use ($entreprise_id){
            $mat_id = $mat->id;
            $quant_mat = $mat->pivot->quantity;
            
            DB::table("raw_materials_stock")->where("entreprise_id","=",$entreprise_id)->where("raw_material_id","=",$mat_id)->decrement("quantity",$quant_mat);
        });
        // update indicators
 
        $this->updateIndicator("caisse",$entreprise_id,-1*$this->production["cost"]);
        $this->updateIndicator("prod_cost",$entreprise_id,$this->production["cost"]);

        $this->resetIndicator("busy_machines",$entreprise_id);
        
        $message = "La production de ".$this->production["quantity"]." unités de ".$product->name." est terminée.";
        $notification = [
            "type" => "ProductionDone",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Production Finis"
        ];
        event(new NewNotification($notification));
    }
}
