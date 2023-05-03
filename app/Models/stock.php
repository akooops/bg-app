<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class stock extends Model
{
    use HasFactory;
    protected $table = 'stock';
    public $timestamps = false;
    protected $fillable = [
        "entreprise_id",
        "product_id",
        "quantity",
        "phase",
        "quantity_selling",
        "price"
    ];

    public function Product()
    {
        return $this->belongsTo('App\Models\Product');
    }
}
