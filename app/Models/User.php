<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasFactory, Notifiable, \Parental\HasChildren;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'type'
    ];
    protected $childTypes = [
        'entreprise' => Entreprise::class,
        'banker' => Banker::class,
        'supplier' => Supplier::class,
        'admin' => Admin::class
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
    
    protected static function booted()
    {
        static::created(function ($user) {
            $rawMaterials = RawMaterial::all();
            foreach ($rawMaterials as $rawMaterial) {
                $rawMaterialStock = new RawMaterialStock;
                $rawMaterialStock->entreprise_id = $user->id;
                $rawMaterialStock->raw_material_id = $rawMaterial->id;
                $rawMaterialStock->quantity = 0;
                $rawMaterialStock->phase = 0;
                $rawMaterialStock->save();
            }
        });
}
}
