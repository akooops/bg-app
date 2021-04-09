<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Loan extends Model
{
    use HasFactory;
    protected $fillable = [
        'entreprise_id',
        'banker_id',
        'status',
        'amount',
        "payment_status",
        "remaining_amount",
        "creation_date",
        "deadline",
        'days',
    ];
    public function entreprises(){
        return $this->belongsTo('App\Models\Entreprise','entreprise_id','id');
        
    }
}
