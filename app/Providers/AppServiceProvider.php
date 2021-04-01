<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Models\Indicator;
use App\Observers\IndicatorObserver;
class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Indicator::observe(IndicatorObserver::class);
    }
}
