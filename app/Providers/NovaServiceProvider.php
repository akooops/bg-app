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
            // Employees salaries, formation et prime
            Number::make('Salaire employés niveau 1', 'salary_lv1'),
            Number::make('Salaire employés niveau 2', 'salary_lv2'),
            Number::make('average salary', 'avgsalary'),

            Number::make('Prix formation', 'workshop_price'),
            Number::make('Coefficient prime', 'bonus_coeff')->step('0.01'),

            Number::make('Seuil humeur pour quitter', 'mood_quitting_threshold')->step('0.01'),
            Number::make('Probabilité de démission', 'quitting_prob')->step('0.01'),
            Number::make("Probabilité d'embaucher", 'hiring_prob')->step('0.01'),

            // Vitesse de réduction de l'humeur des employés
            Number::make('Vitesse réduction humeur employés', 'workers_mood_decay_rate')->step('0.01'),

            // Machines buying cost
            Number::make('Prix machines niveau 1', 'machines_lv1_price'),
            Number::make('Prix machines niveau 2', 'machines_lv2_price'),
            Number::make('Prix machines niveau 3', 'machines_lv3_price'),

            // Machines speeds
            Number::make('Vitesse machines niveau 1', 'machines_lv1_speed')->step('0.1'),
            Number::make('Vitesse machines niveau 2', 'machines_lv2_speed')->step('0.1'),
            Number::make('Vitesse machines niveau 3', 'machines_lv3_speed')->step('0.1'),

            // Pollution units produced by machines for a defined period of time
            Number::make('Pollution machines niveau 1', 'machines_lv1_pollution'),
            Number::make('Pollution machines niveau 2', 'machines_lv2_pollution'),
            Number::make('Pollution machines niveau 3', 'machines_lv3_pollution'),

            // Machines durability (how much their lives decrement in a given amount of time)
            Number::make('Durabilité machines niveau 1', 'machines_lv1_durability')->step('0.01'),
            Number::make('Durabilité machines niveau 2', 'machines_lv2_durability')->step('0.01'),
            Number::make('Durabilité machines niveau 3', 'machines_lv3_durability')->step('0.01'),

            // Production selling parameter
            Number::make('Pourcentage de production à vendre', 'production_percentage_to_sell')->step('0.01'),

            Number::make('Cout unitaire de distribution', 'dist_unit_cost'),

            // Cost of a pollution unit
            Number::make('Cout unitaire pollution', 'pollution_unit_cost'),

            Number::make('Prix de la manutention des MP', 'mp_stock_price')->step('0.1'),
            Number::make('Prix de la manutention des PF', 'pf_stock_price')->step('0.1'),
            Boolean::make('Simulation en cours ?', 'game_started'),
            Number::make('Jour début de la simulation', 'start_date'),
            Number::make('Jour courant de la simulation', 'current_date'),
            Boolean::make('Afficher le score final', 'show_final_score')
        ], [
            'salary_lv1' => 'float',
            'salary_lv2' => 'float',

            'workshop_price' => 'float',
            'bonus_coeff' => 'float',

            'workers_mood_decay_rate' => 'float',
            'mood_quitting_threshold' => 'float',
            'quitting_prob' => 'float',
            'hiring_prob' => 'float',

            'machines_lv1_price' => 'float',
            'machines_lv2_price' => 'float',
            'machines_lv3_price' => 'float',

            'machines_lv1_pollution' => 'float',
            'machines_lv2_pollution' => 'float',
            'machines_lv3_pollution' => 'float',

            'machines_lv1_durability' => 'float',
            'machines_lv2_durability' => 'float',
            'machines_lv3_durability' => 'float',

            'production_percentage_to_sell' => 'float',
            'dist_unit_cost' => 'float',

            'pollution_unit_cost' => 'float',

            'mp_stock_price' => 'float',
            'pf_stock_price' =>'float',
            'show_final_score' => 'boolean',
            'avgsalary'=>'float'
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
