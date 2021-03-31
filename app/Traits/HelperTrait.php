<?php
namespace App\Traits;
trait HelperTrait{

	public function parseCommandStatus($status){
		if($status == "confirmed"){
			return "Confirmé";
		}
		elseif($status == "pending"){
			return "En Attente";
		}

	}
	public function in_array_all($value, $array)
    {
        return (reset($array) == $value && count(array_unique($array)) == 1);
    }	

}