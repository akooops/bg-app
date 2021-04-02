<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;


class AddToStock implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    public $stock_items;
    public $cost;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($stock_items,$cost)
    {
        $this->stock_items = $stock_items;
        $this->cost = $cost;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
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
    }
}
