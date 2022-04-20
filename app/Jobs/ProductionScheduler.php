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

    public function __construct($production, $prod_id)
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

        // Update stock quantity for produced product
        $stock = DB::table("stock")
            ->where("entreprise_id", "=", $entreprise_id)
            ->where("product_id", "=", $product_id);

        if (count($stock->get()->toArray()) == 0) {
            DB::table("stock")->insert([
                "entreprise_id" => $entreprise_id,
                "product_id" => $product_id,
                "quantity" => $this->production["quantity"],
                "quantity_selling" => 0,
                "price" => 0,
                "phase" => 0,
            ]);
        } else {
            $quant = $this->production["quantity"];
            $stock->increment("quantity", $quant);
        }

        // Update production table
        DB::table("productions")->where("id", "=", $this->production_id)->update(["status" => "completed"]);
        $production = DB::table("productions")->where("id", "=", $this->production_id)->first();

        // Remove from raw materials stock
        $product = Product::find($product_id);

        // Release busy machines and workers
        $this->updateIndicator("nb_machines_lv1_busy", $entreprise_id, -1 * $production->machines_lv1);
        $this->updateIndicator("nb_machines_lv2_busy", $entreprise_id, -1 * $production->machines_lv2);
        $this->updateIndicator("nb_machines_lv3_busy", $entreprise_id, -1 * $production->machines_lv3);

        $this->updateIndicator("nb_workers_lv1_busy", $entreprise_id, -1 * $production->workers_lv1);
        $this->updateIndicator("nb_workers_lv2_busy", $entreprise_id, -1 * $production->workers_lv2);

        // Notify player
        $message = "La production de " . $this->production["quantity"] . " unités de " . $product->name . " est terminée.";
        $notification = [
            "entreprise_id" => $entreprise_id,
            "type" => "ProductionUpdate",

            "store" => true,

            "text" => $message,
            "title" => "Production Finie",
            "icon_path" => "aaaaaaaaaaa",

            "style" => "success",
        ];
        event(new NewNotification($notification));
    }
}
