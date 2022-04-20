<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ad extends Model
{
    use HasFactory;

    protected $fillable = [
        'entreprise_id',
        'predicted_result',
        'result',
        'amount',
        'product_id',
        'days',
        "status",
        "type",
        'creation_date',
    ];

    public function entreprises(){
        return $this->belongsTo('App\Models\Entreprise','entreprise_id','id');

    }
}
