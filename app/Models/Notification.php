<?php

namespace App\Models;

use App\Models\Icon;
use App\Models\Entreprise;
use App\Models\NotificationText;
use App\Models\NotificationTitle;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Notification extends Model
{
    use HasFactory;

    protected $table = 'notifications';

    protected $fillable = [
        'entreprise_id',
        'text',
        'title',
        'icon_path',
        'type',
        'time',
    ];

    public function entreprise()
    {
        return $this->belongsTo(Entreprise::class);
    }
}
