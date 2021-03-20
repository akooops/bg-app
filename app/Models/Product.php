<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;
     /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
    ];
    public function producedBy()
    {
        return $this->belongsToMany('App\Models\Entreprise','stock')->withPivot(["quantity","phase"]);
    }
    public function rawMaterials()
    {
        return $this->belongsToMany('App\Models\RawMaterial','raw_materials_products')->withPivot(["quantity"]);
    }
}
