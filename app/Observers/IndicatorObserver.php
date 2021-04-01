<?php

namespace App\Observers;

use App\Models\Indicator;
use App\Models\Entreprise;
use App\Traits\IndicatorTrait;

class IndicatorObserver
{
    /**
     * Handle the Indicator "created" event.
     *
     * @param  \App\Models\Indicator  $indicator
     * @return void
     */
    use IndicatorTrait;
    public $afterCommit = true;
    public function created(Indicator $indicator)
    {
        $entreprises_all = Entreprise::all();
        foreach ($entreprises_all as $entrep) {
            $this->updateIndicator($indicator->code,$entrep["id"],$indicator->starting_value);
        }
    }

    /**
     * Handle the Indicator "updated" event.
     *
     * @param  \App\Models\Indicator  $indicator
     * @return void
     */
    public function updated(Indicator $indicator)
    {
        //
    }

    /**
     * Handle the Indicator "deleted" event.
     *
     * @param  \App\Models\Indicator  $indicator
     * @return void
     */
    public function deleted(Indicator $indicator)
    {
        //
    }

    /**
     * Handle the Indicator "restored" event.
     *
     * @param  \App\Models\Indicator  $indicator
     * @return void
     */
    public function restored(Indicator $indicator)
    {
        //
    }

    /**
     * Handle the Indicator "force deleted" event.
     *
     * @param  \App\Models\Indicator  $indicator
     * @return void
     */
    public function forceDeleted(Indicator $indicator)
    {
        //
    }
}
