<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Command extends Model
{
    use HasFactory;
    protected $fillable = [
        'command_id',
        'entreprise_id',
        'supplier_id',
        'raw_material_id',
        'price',
        'quantity',
    ];
}
