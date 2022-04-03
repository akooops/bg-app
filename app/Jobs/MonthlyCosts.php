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

class MonthlyCosts implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels, IndicatorTrait;

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
        $current_date = nova_get_setting("current_date");
        if ($current_date % 30 != 0) {
            return;
        }

        $salary_lv1 = (int) nova_get_setting('salary_lv1');
        $salary_lv2 = (int) nova_get_setting('salary_lv2');

        $pollution_machines_lv1_factor = nova_get_setting('machines_lv1_pollution');
        $pollution_machines_lv2_factor = nova_get_setting('machines_lv2_pollution');
        $pollution_machines_lv3_factor = nova_get_setting('machines_lv3_pollution');

        $pollution_unit_cost = nova_get_setting('pollution_unit_cost');

        $mp_stock_price = (int) nova_get_setting('mp_stock_price');

        $entreprises = Entreprise::get();
        foreach ($entreprises as $entreprise) {
            $caisse = $this->getIndicator('caisse', $entreprise->id)['value'];
            $cost = 0;

            $salary_cost = 0;
            $workers_lv1 = $this->getIndicator('nb_workers_lv1', $entreprise->id)['value'];
            $workers_lv2 = $this->getIndicator('nb_workers_lv2', $entreprise->id)['value'];
            $salary_cost += $workers_lv1 * $salary_lv1 + $workers_lv2 * $salary_lv2;

            $stock_cost = 0;
            $raw_materials =  DB::table("raw_materials_stock")->where("entreprise_id", "=", $entreprise->id)->where('quantity', '<>', 0)->get();
            foreach ($raw_materials as $raw_material) {
                $stock_cost += $raw_material->quantity * RawMaterial::find($raw_material->raw_material_id)->volume * $mp_stock_price;
            }

            $pollution_cost = 0;
            $machines_lv1 = $this->getIndicator('nb_machines_lv1', $entreprise->id)['value'];
            $machines_lv2 = $this->getIndicator('nb_machines_lv2', $entreprise->id)['value'];
            $machines_lv3 = $this->getIndicator('nb_machines_lv3', $entreprise->id)['value'];
            $pollution_cost += $pollution_unit_cost *
                ($machines_lv1 * $pollution_machines_lv1_factor +
                 $machines_lv2 * $pollution_machines_lv2_factor +
                 $machines_lv3 * $pollution_machines_lv3_factor);

            $cost = (int) ($salary_cost + $stock_cost + $pollution_cost);
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
                    "type" => "NewLoan",
                    "status" => "warning",
                    "entreprise_id" => $entreprise->id,
                    "data" => [],
                    "message" => "Vos disponibilités ne suffisent pas pour payer les charges de ce mois, une nouvelle dette s'est ajoutée automatiquement",
                    "title" => "Manque de disponibilités"
                ];
                event(new NewNotification($notification));
            } else {
                $this->updateIndicator('caisse', $entreprise->id, -1 * $cost);
                $notification = [
                    "type" => "MonthlyCosts",
                    "status" => "info",
                    "entreprise_id" => $entreprise->id,
                    "data" => [],
                    "message" => "Un mois est passé, vous payez:
                                  Salaires ( " . $salary_cost . " DA )
                                  - Stockage ( " . $stock_cost . " DA )
                                  - Pollution ( " . $pollution_cost . " DA ). Total: " . $cost . " DA.",
                    "title" => "Frais mensuels"
                ];
                event(new NewNotification($notification));
            }



            $nb_machines_lv1 = $this->getIndicator('nb_machines_lv1', $entreprise->id)['value'];
            $machines_lv1_health = $this->getIndicator('machines_lv1_health', $entreprise->id)['value'];
            $machines_lv1_durability = nova_get_setting('machines_lv1_durability');
            if ($nb_machines_lv1 > 0) {
                if ($machines_lv1_health - $machines_lv1_durability > 0) {
                    $this->updateIndicator("machines_lv1_health", $entreprise->id, -1 * $machines_lv1_durability);
                } else {
                    $this->setIndicator("machines_lv1_health", $entreprise->id, 0);
                }
            }

            $nb_machines_lv2 = $this->getIndicator('nb_machines_lv2', $entreprise->id)['value'];
            $machines_lv2_health = $this->getIndicator('machines_lv2_health', $entreprise->id)['value'];
            $machines_lv2_durability = nova_get_setting('machines_lv2_durability');
            if ($nb_machines_lv2 > 0) {
                if ($machines_lv2_health - $machines_lv2_durability > 0 && $nb_machines_lv2 > 0) {
                    $this->updateIndicator("machines_lv2_health", $entreprise->id, -1 * $machines_lv2_durability);
                } else {
                    $this->setIndicator("machines_lv2_health", $entreprise->id, 0);
                }
            }

            $nb_machines_lv3 = $this->getIndicator('nb_machines_lv3', $entreprise->id)['value'];
            $machines_lv3_health = $this->getIndicator('machines_lv3_health', $entreprise->id)['value'];
            $machines_lv3_durability = nova_get_setting('machines_lv3_durability');

            if ($nb_machines_lv3) {
                if ($machines_lv3_health - $machines_lv3_durability > 0 && $nb_machines_lv3 > 0) {
                    $this->updateIndicator("machines_lv3_health", $entreprise->id, -1 * $machines_lv3_durability);
                } else {
                    $this->setIndicator("machines_lv3_health", $entreprise->id, 0);
                }
            }

            $notification = [
                "type" => "MachinesUpdate",
                "status" => "info",
                "entreprise_id" => $entreprise->id,
                "data" => [],
                "message" => "Santé des machines",
                "title" => "La santé des machines décroit"
            ];
            event(new NewNotification($notification));
        }
    }
}
