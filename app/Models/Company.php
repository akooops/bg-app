<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Support\Facades\URL;
use App\Traits\HasFiles;

class Company extends Model
{
    use HasFactory, HasFiles;

    protected $guarded = ['id'];

    protected $casts = [
        'carbon_footprint' => 'decimal:3',
        'revenue' => 'decimal:2',
        'funds' => 'decimal:2',
        'research_level' => 'integer',
    ];

    protected $appends = ['image_url', 'full_name'];

    // Relations
    public function image()
    {
        return $this->morphOne(File::class, 'model')->where('is_main', 1);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'stock')->withPivot(["quantity","phase"]);
    }

    public function rawMaterials()
    {
        return $this->belongsToMany(RawMaterial::class, 'raw_materials_stock')->withPivot(["quantity","phase"]);
    }
    
    public function notifications()
    {
        return $this->hasMany(Notification::class);
    }

    // Accessors
    public function getFullNameAttribute()
    {
        return $this->name;
    }

    public function getImageUrlAttribute()
    {
        return ($this->image) ? $this->image->url : URL::to('assets/images/default-company-image.jpg');
    }

    // Custom Methods
    public function hasSufficientFunds($amount)
    {
        return $this->funds >= $amount;
    }

    public function deductFunds($amount)
    {
        if ($this->hasSufficientFunds($amount)) {
            $this->funds -= $amount;
            $this->save();
            return true;
        }
        return false;
    }

    public function addFunds($amount)
    {
        $this->funds += $amount;
        $this->save();
    }

    public function increaseResearchLevel()
    {
        $this->research_level++;
        $this->save();
    }

    public function updateCarbonFootprint($amount)
    {
        $this->carbon_footprint += $amount;
        $this->save();
    }

    public function updateRevenue($amount)
    {
        $this->revenue += $amount;
        $this->save();
    }
} 