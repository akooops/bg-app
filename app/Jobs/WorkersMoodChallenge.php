<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class WorkersMoodChallenge implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $entreprises=Entreprse::get();
        foreach($entreprises as $entreprise){
            $mood = $this->getIndicator('workers_mood');
            $difference = $mood - 0.3;
            $this->updateIndicator('workers_mood',$entreprise->id,);
            $notification= [

            ];
            event(new NewNotification($notification));

        }
    }
}
