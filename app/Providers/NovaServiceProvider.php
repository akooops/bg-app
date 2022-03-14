<?php

namespace App\Providers;

use Illuminate\Support\Facades\Gate;
use Laravel\Nova\Cards\Help;
use Laravel\Nova\Nova;
use Laravel\Nova\NovaApplicationServiceProvider;
use Laravel\Nova\Fields\Boolean;
use Laravel\Nova\Fields\DateTime;
use Laravel\Nova\Fields\Number;
use Manou\IndicatorUpdater\IndicatorUpdater;
use Manou\IndicatorExplorer\IndicatorExplorer;

class NovaServiceProvider extends NovaApplicationServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        parent::boot();
        \OptimistDigital\NovaSettings\NovaSettings::addSettingsFields([
            // Employees salaries
            Number::make('Salaire des employés (niveau 1)', 'salary_lv1'),
            Number::make('Salaire des employés (niveau 2)', 'salary_lv2'),

            // Vitesse de réduction de l'humeur des employés
            Number::make('Vitesse réduction humeur employés', 'workers_mood_decay_rate')->step('0.01'),

            // Machines buying cost
            Number::make('Prix machines (niveau 1)', 'machines_lv1_price'),
            Number::make('Prix machines (niveau 2)', 'machines_lv2_price'),
            Number::make('Prix machines (niveau 3)', 'machines_lv3_price'),

            // Machines speeds
            Number::make('Vitesse machines (niveau 1)', 'machines_lv1_speed')->step('0.1'),
            Number::make('Vitesse machines (niveau 2)', 'machines_lv2_speed')->step('0.1'),
            Number::make('Vitesse machines (niveau 3)', 'machines_lv3_speed')->step('0.1'),

            // Pollution units produced by machines for a defined period of time
            Number::make('Pollution machines (niveau 1)', 'machines_lv1_pollution'),
            Number::make('Pollution machines (niveau 2)', 'machines_lv2_pollution'),
            Number::make('Pollution machines (niveau 3)', 'machines_lv3_pollution'),

            // Machines durability (how much their lives decrement in a given amount of time)
            Number::make('Durabilité machines (niveau 1)', 'machines_lv1_durability')->step('0.01'),
            Number::make('Durabilité machines (niveau 2)', 'machines_lv2_durability')->step('0.01'),
            Number::make('Durabilité machines (niveau 3)', 'machines_lv3_durability')->step('0.01'),

            // Cost of a pollution unit
            Number::make('Cout unitaire pollution', 'pollution_unit_cost'),

            Number::make('Prix de la formation', 'workshop_price'),
            Number::make('Prix de la manutention des MP', 'mp_stock_price')->step('0.1'),
            Boolean::make('Simulation en cours ?', 'game_started'),
            Number::make('Jour début de la simulation', 'start_date'),
            Number::make('Jour courant de la simulation', 'current_date'),
            Boolean::make('Afficher le score finale', 'show_final_score')
        ], [
            'salary_lv1' => 'float',
            'salary_lv2' => 'float',

            'workers_mood_decay_rate' => 'float',

            'machines_lv1_price' => 'float',
            'machines_lv2_price' => 'float',
            'machines_lv3_price' => 'float',

            'machines_lv1_pollution' => 'float',
            'machines_lv2_pollution' => 'float',
            'machines_lv3_pollution' => 'float',

            'machines_lv1_durability' => 'float',
            'machines_lv2_durability' => 'float',
            'machines_lv3_durability' => 'float',

            'pollution_unit_cost' => 'float',

            'workshop_price' => 'float',
            'mp_stock_price' => 'float',
            'show_final_score' => 'boolean'
        ], "Général");
    }

    /**
     * Register the Nova routes.
     *
     * @return void
     */
    protected function routes()
    {
        Nova::routes()
            ->withAuthenticationRoutes()
            ->withPasswordResetRoutes()
            ->register();
    }

    /**
     * Register the Nova gate.
     *
     * This gate determines who can access Nova in non-local environments.
     *
     * @return void
     */
    protected function gate()
    {
        Gate::define('viewNova', function ($user) {
            return in_array($user->email, [
                //
            ]);
        });
    }

    /**
     * Get the cards that should be displayed on the default Nova dashboard.
     *
     * @return array
     */
    protected function cards()
    {
        return [
            new Help,
        ];
    }

    /**
     * Get the extra dashboards that should be displayed on the Nova dashboard.
     *
     * @return array
     */
    protected function dashboards()
    {
        return [];
    }

    /**
     * Get the tools that should be listed in the Nova sidebar.
     *
     * @return array
     */
    public function tools()
    {
        return [
            new IndicatorUpdater,
            new IndicatorExplorer,
            new \OptimistDigital\NovaSettings\NovaSettings,


        ];
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
