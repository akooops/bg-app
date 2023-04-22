<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class RawMaterialStock extends Model
{
    use HasFactory;
    protected $table = 'raw_materials_stock';
    public $timestamps = false;
    protected $fillable = [
        'entreprise_id',
        'raw_material_id',
        'quantity',
        'phase'
    ];

    public function rawMaterial()
    {
        return $this->belongsTo('App\Models\RawMaterial');
    }
}