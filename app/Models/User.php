<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\DB;

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
            if ($user->type === 'entreprise') {
                $products = Product::all();
                foreach ($products as $product) {
                    if(stock::where('entreprise_id', $user->id)->where('product_id', $product->id)->exists()) {
                        continue;
                    }
            
                    DB::table('stock')->insert([
                        'entreprise_id' => $user->id,
                        'product_id' => $product->id,
                        'quantity' => 0,
                        'phase' => 0,
                        'quantity_selling' => 0,
                        'price' => 0
                    ]);
                }

                $rawMaterials = RawMaterial::all();
                foreach ($rawMaterials as $rawMaterial) {
                    // Use raw SQL instead of Eloquent
                    if(RawMaterialStock::where('entreprise_id', $user->id)->where('raw_material_id', $rawMaterial->id)->exists()) {
                        continue;
                    }
                    DB::table('raw_materials_stock')->insert([
                        'entreprise_id' => $user->id,
                        'raw_material_id' => $rawMaterial->id,
                        'quantity' => 0,
                        'phase' => 0
                    ]);
                }
            }
        });
    }
}
