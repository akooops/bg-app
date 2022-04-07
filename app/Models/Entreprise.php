<?php

namespace App\Models;

use App\Models\User;
use App\Models\Notification;

class Entreprise extends User
{
    use \Parental\HasParent;
    
    public function products()
    {
        return $this->belongsToMany('App\Models\Product','stock')->withPivot(["quantity","phase"]);
    }

    public function rawMaterials()
    {
        return $this->belongsToMany('App\Models\RawMaterial','raw_materials_stock')->withPivot(["quantity","phase"]);
    }
    
    public function notifications()
    {
        return $this->hasMany(Notification::class);
    }

}
