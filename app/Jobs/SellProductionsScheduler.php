<?php

namespace App\Jobs;

use App\Traits\DemandTrait;
use App\Traits\HelperTrait;
use Illuminate\Bus\Queueable;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
use Illuminate\Support\Facades\DB;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class SellProductionsScheduler implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    use HelperTrait, IndicatorTrait, DemandTrait;

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
        $productions = DB::table("productions")->where("status", "=", "selling")->get();
        foreach ($productions as $production) {
            // Get production properties
            $product_id = $production->product_id;
            $product = DB::table("products")->where("id", "=", $product_id)->first();
            $entreprise_id = $production->entreprise_id;
            $price = $production->price;

            // Check if no demand left on the this product
            if ($product->left_demand <= 0) {
                $message = "Il n'y a plus de demande sur le produit" . $product->name . " pour l'instant, impossible de continuer la vente de la production " . $production->id . ".";
                $notification = [
                    "entreprise_id" => $entreprise_id,
                    "type" => "ProductionUpdate",

                    "store" => true,

                    "text" => $message,
                    "title" => "Plus de demande",
                    "icon_path" => "aaaaaaaaaaa",

                    "style" => "failure",
                ];
                event(new NewNotification($notification));

                continue;
            }

            $production_quantity = $production->quantity;
            $production_quantity_sold = $production->sold;

            $production_percentage_to_sell = nova_get_setting("production_percentage_to_sell");
            $quantity_to_sell = round(min($this->productDemandReal($product_id, $entreprise_id, $price, round($production_quantity * $production_percentage_to_sell)),
                                          $production_quantity - $production_quantity_sold
                                        )
                                    );

            $dist_cost = $quantity_to_sell * nova_get_setting("dist_unit_cost");
            $sales = $quantity_to_sell * $price;
            $profit_value = $sales - $dist_cost;

            $ca_key = "ca_" . $product_id;

            // Update stock quantity and the production's sold quantity
            DB::table("stock")->where("entreprise_id", "=", $entreprise_id)->where("product_id", "=", $product_id)
                ->decrement("quantity", $quantity_to_sell);
            DB::table("productions")->where("id", "=", $production->id)->increment("sold", $quantity_to_sell);

            // Update caisse and chiffre d'affaire and distribution cost
            $this->updateIndicator("caisse", $entreprise_id, $profit_value);
            $this->updateIndicator($ca_key, $entreprise_id, $sales);
            $this->updateIndicator("ca", $entreprise_id, $sales);
            $this->updateIndicator("dist_cost", $entreprise_id, $dist_cost);

            // Update left demand on product
            DB::table("products")->where("id", "=", $product_id)->decrement("left_demand", $quantity_to_sell);

            // Signal sale
            $message = "Vente d'une partie de la production " . $production->id;
            $notification = [
                "entreprise_id" => $entreprise_id,
                "type" => "ProductionUpdate",

                "store" => false,
            ];
            event(new NewNotification($notification));

            // Mark production as sold if no more to sell after this
            if (
                $production_quantity_sold + $quantity_to_sell >= $production_quantity
            ) {
                DB::table("productions")->where("id", "=", $production->id)->update(["status" => "sold"]);

                if ($production_quantity_sold + $quantity_to_sell > $production_quantity) {
                    DB::table("productions")->where("id", "=", $production->id)->update(["sold" => $production_quantity]);
                }

                $message = "Production " . $production->id . " entièrement vendue.";
                $notification = [
                    "entreprise_id" => $entreprise_id,
                    "type" => "ProductionUpdate",

                    "store" => true,

                    "message" => $message,
                    "title" => "Production vendue",
                    "icon_path" => "aaaaaaaaaaa",

                    "style" => "info",
                ];
                event(new NewNotification($notification));
            }
        }
    }
}
