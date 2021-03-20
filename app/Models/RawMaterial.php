<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RawMaterial extends Model
{
    use HasFactory;
     /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'price',
        'unit'
    ];
    public function usedIn()
    {
        return $this->belongsToMany('App\Models\Product','raw_materials_products')->withPivot(["quantity"]);
    }

}
