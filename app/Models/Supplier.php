<?php

namespace App\Models;

use App\Models\User;
use App\Models\RawMaterial;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Supplier extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'foreign',
    ];

    public function raw_materials()
    {
        return $this->belongsToMany(RawMaterial::class)->withPivot('price_factor', 'quantity_available', 'time_to_deliver');
    }
}
