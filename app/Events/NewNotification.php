<?php

namespace App\Events;

use App\Models\Notification;
use App\Traits\HelperTrait;
use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class NewNotification implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels, HelperTrait;

    public $notification;
    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($notification)
    {
        $this->notification = [];
        $this->notification["entreprise_id"] = $notification["entreprise_id"];
        $this->notification["type"] = $notification["type"];
        $this->notification["store"] = $notification["store"];
        $this->notification["title"] = $notification["title"];
        $this->notification["text"] = $notification["text"];
        $this->notification["style"] = $notification["style"];


        if ($notification["store"] == true)
        {
            $notif = Notification::create([
                'entreprise_id' => $notification['entreprise_id'],
                'text' => $notification['text'],
                'title' => $notification['title'],
                'icon_path' => $notification['icon_path'],
                'type' => $notification['style'],
                'time' => (int) $this->get_game_setting('current_date'),
            ]);
        }
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        return new Channel('entreprise_' .$this->notification['entreprise_id']);
    }
}
