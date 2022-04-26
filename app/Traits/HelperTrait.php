<?php

namespace App\Traits;

use App\Models\GameSetting;
use Illuminate\Http\Request;

trait HelperTrait
{

    public function parseCommandStatus($status)
    {
        if ($status == "confirmed") {
            return "Reçue";
        } elseif ($status == "pending") {
            return "Livraison...";
        }
    }

    public function parseProductionStatus($status)
    {
        if ($status == "completed") {
            return "Fini";
        } else if ($status == "pending") {
            return "En Attente...";
        } else if ($status == "sold") {
            return "Vendu";
        } else if ($status == "selling") {
            return "En vente...";
        }
    }

    public function parseAdStatus($status)
    {
        if ($status == "done") {
            return "Terminé";
        }

        return "En cours";
    }
    public function parseAdType($type)
    {
        if ($type == "social") {
            return "Réseaux sociaux";
        } else if ($type == "media") {
            return "Média locaux";
        }
        return "Evénement";
    }
    public function parseLoanStatus($status)
    {
        if ($status == "pending") {
            return "En attente";
        } else if ($status == "accepted") {
            return "Acceptée/Partiellement acceptée";
        }
        return "Rejettée";
    }

    public function getSimulationTime()
    {
        return $this->get_game_setting('current_date');
    }

    public function in_array_all($value, $array)
    {
        return (reset($array) == $value && count(array_unique($array)) == 1);
    }

    public function get_game_setting($setting_code, $with_name_and_code=false) {
        if($with_name_and_code){
            return GameSetting::where('code', '=', $setting_code)->first();
        }

        return GameSetting::where('code', '=', $setting_code)->first()->value;
    }

    public function set_game_setting($setting_code, $value) {
        GameSetting::where('code', '=', $setting_code)->update(["value" => $value]);
    }

    public function reset_game_setting($setting_code)
    {
        $setting = GameSetting::where('code', '=', $setting_code);
        $setting->update(["value" => $setting->first()->default_value]);
    }
}
