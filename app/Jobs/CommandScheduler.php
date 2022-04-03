<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use App\Events\NewNotification;
use Illuminate\Support\Facades\DB;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class CommandScheduler implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     *
     * @return void
     */

    public $command;
    public $item_id;

    public function __construct($command, $item_id)
    {
        $this->command = $command;
        $this->item_id = $item_id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $entreprise_id = $this->command["entreprise_id"];
        $raw_mat_id = $this->command["raw_material_id"];

        $raw_mat = DB::table("raw_materials")->where("id", "=", $raw_mat_id)->first();

        // Update stock quantity for bought raw material
        $raw_mat_stock = DB::table("raw_materials_stock")->where("entreprise_id", "=", $entreprise_id);

        if (count($raw_mat_stock->get()->toArray()) == 0) {
            DB::table("raw_materials_stock")->insert([
                "entreprise_id" => $entreprise_id,
                "raw_material_id" => $raw_mat_id,
                "quantity" => $this->command["quantity"],
                "phase" => 0
            ]);
        } else {
            $quant = $this->command["quantity"];
            $raw_mat_stock->increment("quantity", $quant);
        }

        // Update command status
        DB::table("commands")
            ->where("command_id", "=", $this->command["command_id"])
            ->where("item_id", "=", $this->item_id)
            ->update(["status" => "confirmed"]);

        $message = "Les " . $this->command["quantity"] . " " .
                    $raw_mat->unit . " de " . $raw_mat->name .
                    " de la commande " . $this->command["command_id"] . " vous ont été livrés";
        $notification = [
            "type" => "CommandUpdate",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Livraison de la commande"
        ];
        event(new NewNotification($notification));


        $message = "Les " . $this->command["quantity"] . " " .
                    $raw_mat->unit . " de " . $raw_mat->name .
                    " de la commande " . $this->command["command_id"] . " vous ont été livrés";
        $notification = [
            "type" => "StockUpdate",
            "entreprise_id" => $entreprise_id,
            "message" => $message,
            "title" => "Livraison de la commande"
        ];
        event(new NewNotification($notification));
    }
}
