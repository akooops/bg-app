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
use App\Models\RawMaterial;
use App\Traits\HelperTrait;

class MonthlyCosts implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels, IndicatorTrait, HelperTrait;

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
        // Only do this job if the current week is a multiple of 4 (a month has passed)
        $current_date = (int) $this->get_game_setting("current_date");
        if ($current_date % 4 == 0) {
            // Get necessary settings
            $salary_lv1 = (int) $this->get_game_setting('salary_lv1');
            $salary_lv2 = (int) $this->get_game_setting('salary_lv2');

            $pollution_machines_lv1_factor = $this->get_game_setting('machines_lv1_pollution');
            $pollution_machines_lv2_factor = $this->get_game_setting('machines_lv2_pollution');
            $pollution_machines_lv3_factor = $this->get_game_setting('machines_lv3_pollution');
            $pollution_machines_lv0_factor = $this->get_game_setting('machines_lv0_pollution');

            $pollution_unit_cost = $this->get_game_setting('pollution_unit_cost');

            $mp_stock_price = (int) $this->get_game_setting('mp_stock_price');

            // For every entreprise
            $entreprises = Entreprise::get();
            foreach ($entreprises as $entreprise) {
                // Retrieve entreprise's funds
                $caisse = $this->getIndicator('caisse', $entreprise->id)['value'];

                $machines_lv1 = $this->getIndicator('nb_machines_lv1', $entreprise->id)['value'];
                $machines_lv2 = $this->getIndicator('nb_machines_lv2', $entreprise->id)['value'];
                $machines_lv3 = $this->getIndicator('nb_machines_lv3', $entreprise->id)['value'];
                $machines_lv0 = $this->getIndicator('nb_machines_lv0', $entreprise->id)['value'];

                $workers_lv1 = $this->getIndicator('nb_workers_lv1', $entreprise->id)['value'];
                $workers_lv2 = $this->getIndicator('nb_workers_lv2', $entreprise->id)['value'];

                $cost = 0;

                // Compute salaries cost
                $salary_cost = 0;
                $salary_cost += $workers_lv1 * $salary_lv1 + $workers_lv2 * $salary_lv2;

                // Compute raw materials stock cost
                $stock_cost = 0;
                $raw_materials =  DB::table("raw_materials_stock")->where("entreprise_id", "=", $entreprise->id)->where('quantity', '<>', 0)->get();
                foreach ($raw_materials as $raw_material) {
                    // Stock cost depends on quantity and volume of raw material
                    $stock_cost += $raw_material->quantity * RawMaterial::find($raw_material->raw_material_id)->volume * $mp_stock_price;
                }
                $stock_cost_p =0;
                $products =  DB::table("stock")->where("entreprise_id", "=", $entreprise->id)->where('quantity', '<>', 0)->get();
                foreach ($products as $product) {
                    // Stock cost depends on quantity of product
                    $stock_cost_p += $product->quantity *Product::find($product->product_id)->volume * $pf_stock_price;}

                // Compute pollution cost based on machines
                $pollution_cost = 0;
                $pollution_cost += $pollution_unit_cost *
                    ($machines_lv1 * $pollution_machines_lv1_factor +
                    $machines_lv0 * $pollution_machines_lv0_factor+
                    $machines_lv2 * $pollution_machines_lv2_factor +
                        $machines_lv3 * $pollution_machines_lv3_factor);

                // Compute CA taxes
                $monthly_ca = $this->getIndicator('ca', $entreprise->id)['value'];

                if ($current_date > 4) {
                    $prev_ca = DB::table('stats')->where('entreprise_id', '=', $entreprise->id)->where('date', '=', $current_date - 4)->where('indicator', '=', 'ca')->first()->value;
                    $monthly_ca = $this->getIndicator('ca', $entreprise->id)['value'] - $prev_ca;
                }

                $ca_tax_percent = $this->get_game_setting('ca_tax_percent');

                $ca_tax_cost = $monthly_ca * $ca_tax_percent;

                // Compute total cost
                $cost = (int) ($salary_cost + $stock_cost + $pollution_cost + $ca_tax_cost);

                // Get a loan if funds not enough to pay costs
                if ($cost > $caisse) {
                    $difference = $cost - $caisse;
                    $this->setIndicator("caisse", $entreprise->id, 0);
                    $new_loan =  Loan::create([
                        "entreprise_id" => $entreprise->id,
                        "banker_id" => Banker::first()->id,
                        "status"    => "accepted",
                        "amount" => $difference,
                        "remaining_amount" => $difference,
                        "ratio" => 4.00,
                        "payment_status" => 0,
                        "creation_date" => (int) $this->getSimulationTime(),
                        "deadline" => 15,
                        "days" =>  $this->getSimulationTime() + 15
                    ]);
                    $this->updateIndicator("dettes", $entreprise->id, $difference);

                    $notification = [
                        "entreprise_id" => $entreprise->id,
                        "type" => "NewLoan",

                        "store" => true,

                        "title" => "Manque de disponibilités",
                        "text" => "Vos disponibilités ne suffisent pas pour payer les charges de ce mois, une nouvelle dette s'est ajoutée automatiquement",
                        "icon_path" => "/assets/icons/alerte.svg",

                        "style" => "failure",
                    ];
                    event(new NewNotification($notification));
                }
                // Otherwise, just take the money from the funds and go on
                else {
                    $this->updateIndicator('caisse', $entreprise->id, -1 * $cost);
                    $notification = [
                        "entreprise_id" => $entreprise->id,
                        "type" => "MonthlyCosts",

                        "store" => true,

                        "text" => "Un mois est passé, vous payez:
                                    - Taxes ( " . $ca_tax_cost . " DA )
                                    - Salaires ( " . $salary_cost . " DA )
                                    - Stockage ( " . $stock_cost . " DA )
                                    - Stockage produit fini  ( " . $stock_cost_p ." DA)
                                    - Pollution ( " . $pollution_cost . " DA ). Total: " . $cost . " DA.",
                        "title" => "Frais mensuels",
                        "icon_path" => "/assets/icons/info.svg",

                        "style" => "info",
                    ];
                    event(new NewNotification($notification));
                }

                // This is to decrease the health of the machines
                $nb_machines_lv1 = $this->getIndicator('nb_machines_lv1', $entreprise->id)['value'];
                $machines_lv1_health = $this->getIndicator('machines_lv1_health', $entreprise->id)['value'];
                $machines_lv1_durability = $this->get_game_setting('machines_lv1_durability');
                if ($nb_machines_lv1 > 0) {
                    if ($machines_lv1_health - $machines_lv1_durability > 0) {
                        $this->updateIndicator("machines_lv1_health", $entreprise->id, -1 * $machines_lv1_durability);
                    } else {
                        $this->setIndicator("machines_lv1_health", $entreprise->id, 0);
                    }
                }

                $nb_machines_lv0 = $this->getIndicator('nb_machines_lv0', $entreprise->id)['value'];
                $machines_lv0_health = $this->getIndicator('machines_lv0_health', $entreprise->id)['value'];
                $machines_lv0_durability = $this->get_game_setting('machines_lv0_durability');
                if ($nb_machines_lv0 > 0) {
                    if ($machines_lv0_health - $machines_lv0_durability > 0) {
                        $this->updateIndicator("machines_lv0_health", $entreprise->id, -1 * $machines_lv0_durability);
                    } else {
                        $this->setIndicator("machines_lv0_health", $entreprise->id, 0);
                    }
                }

                $nb_machines_lv2 = $this->getIndicator('nb_machines_lv2', $entreprise->id)['value'];
                $machines_lv2_health = $this->getIndicator('machines_lv2_health', $entreprise->id)['value'];
                $machines_lv2_durability = $this->get_game_setting('machines_lv2_durability');
                if ($nb_machines_lv2 > 0) {
                    if ($machines_lv2_health - $machines_lv2_durability > 0 && $nb_machines_lv2 > 0) {
                        $this->updateIndicator("machines_lv2_health", $entreprise->id, -1 * $machines_lv2_durability);
                    } else {
                        $this->setIndicator("machines_lv2_health", $entreprise->id, 0);
                    }
                }

                $nb_machines_lv3 = $this->getIndicator('nb_machines_lv3', $entreprise->id)['value'];
                $machines_lv3_health = $this->getIndicator('machines_lv3_health', $entreprise->id)['value'];
                $machines_lv3_durability = $this->get_game_setting('machines_lv3_durability');

                if ($nb_machines_lv3) {
                    if ($machines_lv3_health - $machines_lv3_durability > 0 && $nb_machines_lv3 > 0) {
                        $this->updateIndicator("machines_lv3_health", $entreprise->id, -1 * $machines_lv3_durability);
                    } else {
                        $this->setIndicator("machines_lv3_health", $entreprise->id, 0);
                    }
                }

                $notification = [
                    "entreprise_id" => $entreprise->id,
                    "type" => "MachinesUpdate",

                    "store" => true,

                    "title" => "Machines",
                    "text" => "La santé de vos machines décroit",
                    "icon_path" => "/assets/icons/info.svg",

                    "style" => "info",
                ];
                event(new NewNotification($notification));
            }
        }
    }
}
