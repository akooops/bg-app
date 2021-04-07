<?php
namespace App\Traits;
use Illuminate\Http\Request;

trait HelperTrait{

	public function parseCommandStatus($status){
		if($status == "confirmed"){
			return "Confirmé";
		}
		elseif($status == "pending"){
			return "En Attente";
		}

	}

	public function parseProductionStatus($status){
		if($status == "completed"){
			return "Finis";
		}
		elseif($status == "pending"){
			return "En Attente";
		}

	}

	public function parseAdStatus($status){
		if($status == "done"){
			return "Terminé";
		}
		
		return "En cours";
	}
	public function parseAdType($type){
		if($type == "social"){
			return "Réseaux sociaux";
		}
		else if($type == "media"){
			return "Média locaux";
		}
		return "Evénement";
	}
	public function parseLoanStatus($status){
		if($status == "pending"){
			return "En attente";
		}
		else if($status == "accepted"){
			return "Acceptée/Partiellement acceptée";
		}
		return "Rejettée";
	}
	public function parseDateToSimulationDate($date){
		return $date->diffInDays(nova_get_setting("start_date"));
	}
	public function parseSimulationDateToDate($date){
		return nova_get_setting("start_date")->addDays($date);
	}
	public function getSimulationTime(Request $request){
		return $this->parseDateToSimulationDate(nova_get_setting('current_date'));
	}

	public function in_array_all($value, $array)
    {
        return (reset($array) == $value && count(array_unique($array)) == 1);
    }	

}