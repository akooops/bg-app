<?php

namespace App\Models;

use App\Models\Supplier;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

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
        'unit',
        'volume'
    ];

    public function products()
    {
        return $this->belongsToMany('App\Models\Product','raw_materials_products')->withPivot(["quantity"]);
    }

    public function suppliers() {
        return $this->belongsToMany(Supplier::class)->withPivot('price_factor', 'is_available', 'time_to_deliver');
    }

}
