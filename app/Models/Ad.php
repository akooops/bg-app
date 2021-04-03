<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ad extends Model
{
    use HasFactory;

    protected $fillable = [
        'entreprise_id',
        'result',
        'amount',
        'product_id',
        'start_date',
        "end_date",
        "status",
        "type"
    ];

    public function entreprises(){
        return $this->belongsTo('App\Models\Entreprise','entreprise_id','id');
        
    }
}
