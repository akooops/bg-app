<?php

namespace Manou\IndicatorUpdater;

use App\Models\Entreprise;
use App\Traits\HelperTrait;
use App\Events\NewNotification;
use Illuminate\Support\Facades\DB;
use App\Events\SimulationDateChanged;
use App\Models\Indicator;
use App\Models\Product;
use App\Models\RawMaterial;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\Artisan;
use Laravel\Nova\Http\Requests\NovaRequest;

class IndicatorUpdaterController
{
    use HelperTrait;

    public function getIndicators(NovaRequest $request)
    {
        $data = [
            "indicators" => DB::table('indicators')->orderBy('code')->get(),
            "entreprises" => Entreprise::get()
        ];
        return response()->json($data);
    }

    public function updateIndicators(NovaRequest $request)
    {
        $indicator_id = $request->selected_indicator;
        $entreprise_ids = $request->entreprise_ids;

        $operation = $request->selected_operation;
        $value = $request->value;

        if ($indicator_id === null) {
            return response()->json(["message" => "Opération impossible: Vous n'avez pas spécifié un indicateur valide.", "success" => false], 200);
        }
        if ($entreprise_ids === null) {
            return response()->json(["message" => "Opération impossible: Vous n'avez pas spécifié une liste d'entreprises valide.", "success" => false], 200);
        }
        if ($operation === null) {
            return response()->json(["message" => "Opération impossible: Vous n'avez pas spécifié une opération valide.", "success" => false], 200);
        }
        if ($value === null) {
            return response()->json(["message" => "Opération impossible: Vous n'avez pas spécifié une valeur valide.", "success" => false], 200);
        }

        foreach ($entreprise_ids as $entreprise_id) {
            $indicator = DB::table('entreprise_indicator')
                ->where('entreprise_id', $entreprise_id)
                ->where('indicator_id', $indicator_id);

            if ($operation == 'replace') {
                $indicator->update(["value" => $value]);
            } else if ($operation == 'add') {
                $indicator->update(["value" => $indicator->first()->value + $value]);
            } else if ($operation == 'mult') {
                if ($value < 0) {
                    return response()->json(["message" => "Impossible de mettre l'indicateur à jour: multiplication par nombre négatif.", "success" => false], 200);
                }
                $indicator->update(["value" => $indicator->first()->value * $value]);
            } else if ($operation == 'reset') {
                $default_value = DB::table('indicators')->where('indicator_id', '=', $indicator_id)->first()->starting_value;
                $indicator->update(["value" => $default_value]);
            }

            $notification = [
                "entreprise_id" => $entreprise_id,
                "type" => "AdminNotif",

                "store" => true,

                "text" => "",
                "title" => "Admin: Changement de données",
                "icon_path" => "/assets/icons/info.svg",

                "style" => "info",
            ];
            event(new NewNotification($notification));
        }

        return response()->json(["message" => "L'indicateur a été mis à jour.", "success" => true], 200);
    }

    public function getIndicators_2(NovaRequest $request)
    {
        return response()->json(DB::table('indicators')->get());
    }

    public function getEntrepriseIndicators(NovaRequest $request)
    {
        $data = DB::table('entreprise_indicator')
            ->where('indicator_id', $request->indicator_id)
            ->join('users', 'users.id', '=', 'entreprise_indicator.entreprise_id')->get();
        return response()->json($data);
    }

    public function getSettings(NovaRequest $request)
    {
        $data = [
            "settings" => DB::table('game_settings')->orderBy('code')->get(),
        ];
        return response()->json($data);
    }

    public function setSetting(NovaRequest $request)
    {
        $code = $request->code;
        $value = $request->value;

        $this->set_game_setting($code, $value);

        $entreprises = Entreprise::all();
        foreach ($entreprises as $entrep) {
            $notification = [
                "entreprise_id" => $entrep->id,
                "type" => "AdminNotif",

                "store" => false,

                "text" => "",
                "title" => "",
                "icon_path" => "",

                "style" => "",
            ];
            event(new NewNotification($notification));
        }

        if ($code == 'current_date') {
            event(new SimulationDateChanged());
        }

        return response()->json(["message" => "Le paramètre a été mis à jour.", "success" => true], 200);
    }

    public function resetSetting(NovaRequest $request)
    {
        $code = $request->code;

        $this->reset_game_setting($code);

        $entreprises = Entreprise::all();
        foreach ($entreprises as $entrep) {
            $notification = [
                "entreprise_id" => $entrep->id,
                "type" => "AdminNotif",

                "store" => false,

                "text" => "",
                "title" => "",
                "icon_path" => "",

                "style" => "",
            ];
            event(new NewNotification($notification));
        }

        if ($code == 'current_date') {
            event(new SimulationDateChanged());
        }

        return response()->json(["message" => "Le paramètre a été réinitialisé.", "success" => true], 200);
    }

    public function resetGame(NovaRequest $request)
    {
        // Reset indicators
        $indicators = Indicator::all();

        foreach ($indicators as $ind) {
            DB::table('entreprise_indicator')->where('indicator_id', '=', $ind->id)->update(['value' => $ind->starting_value]);
        }

        // Reset game settings
        DB::table('game_settings')->update(['value' => DB::raw('default_value')]);

        // Reset raw materials prices
        DB::table('raw_materials')->where('id', '=', 1)->update(['price' => 150]);
        DB::table('raw_materials')->where('id', '=', 2)->update(['price' => 30]);
        DB::table('raw_materials')->where('id', '=', 3)->update(['price' => 600]);
        DB::table('raw_materials')->where('id', '=', 4)->update(['price' => 120]);
        DB::table('raw_materials')->where('id', '=', 5)->update(['price' => 900]);
        DB::table('raw_materials')->where('id', '=', 6)->update(['price' => 900]);
        DB::table('raw_materials')->where('id', '=', 7)->update(['price' => 1300]);
        DB::table('raw_materials')->where('id', '=', 8)->update(['price' => 400]);
        DB::table('raw_materials')->where('id', '=', 9)->update(['price' => 900]);

        // Reset machine prices
        $this->set_game_setting('machines_lv1_price', 500000);
        $this->set_game_setting('machines_lv2_price', 1250000);
        $this->set_game_setting('machines_lv3_price', 2500000);

        // Reset products' left demand
        DB::table('products')->update(['left_demand' => DB::raw('avg_demand')]);

        // Reset products' stocks
        $entreprises = Entreprise::all();
        $products = Product::all();

        foreach ($entreprises as $entrep) {
            foreach ($products as $prod) {
                $stock = DB::table('stock')->where('entreprise_id', '=', $entrep->id)->where('product_id', '=', $prod->id);
                if ($stock->count() > 0) {
                    $stock->update([
                        'quantity' => 0,
                        'quantity_selling' => 0,
                        'price' => ($prod->price_min + $prod->price_max) / 2,
                    ]);
                } else {
                    DB::table('stock')->insert([
                        [
                            'entreprise_id' => $entrep->id,
                            'product_id' => $prod->id,
                            'quantity' => 0,
                            'quantity_selling' => 0,
                            'phase' => 0,
                            'price' => ($prod->price_min + $prod->price_max) / 2,
                        ],
                    ]);
                }
            }
        }

        // Reset raw materials' stocks
        $raw_materials = RawMaterial::all();

        foreach ($entreprises as $entrep) {
            foreach ($raw_materials as $raw_mat) {
                $stock = DB::table('raw_materials_stock')->where('entreprise_id', '=', $entrep->id)->where('raw_material_id', '=', $raw_mat->id);

                $quantity = 0;

                switch ($raw_mat->id) {
                    case 1:         // Sucre
                        $quantity = 137.2;
                        break;

                    case 2:         // Emballage
                        $quantity = 130;
                        break;

                    case 3:         // Additifs
                        $quantity = 36;
                        break;

                    case 4:         // Blé
                        $quantity = 636;
                        break;

                    case 5:         // Lait
                        $quantity = 125;
                        break;

                    case 6:         // Beurre
                        $quantity = 165;
                        break;

                    case 7:         // Fruits
                        $quantity = 180;
                        break;

                    case 8:         // Avoine
                        $quantity = 250;
                        break;

                    case 9:         // Cacao
                        $quantity = 295;
                        break;
                }

                if ($stock->count() > 0) {
                    $stock->update([
                        'quantity' => $quantity,
                    ]);
                } else {
                    DB::table('raw_materials_stock')->insert([
                        [
                            'entreprise_id' => $entrep->id,
                            'raw_material_id' => $raw_mat->id,
                            'quantity' => $quantity,
                            'phase' => 0,
                        ],
                    ]);
                }
            }
        }

        // Make all raw materials available
        DB::table('raw_material_supplier')->update(['is_available' => true]);

        // Clear notifications
        DB::table('notifications')->delete();

        // Clear productions
        DB::table('productions')->delete();

        // Clear commands
        DB::table('commands')->delete();


        // Clear loans
        DB::table('loans')->delete();

        // Clear ads
        DB::table('ads')->delete();

        // Clear stats
        DB::table('stats')->delete();

        // Clear queue
        Artisan::call('queue:clear');

        foreach ($entreprises as $entrep) {
            $notification = [
                "entreprise_id" => $entrep->id,
                "type" => "GameReset",

                "store" => false,

                "text" => "",
                "title" => "",
                "icon_path" => "",

                "style" => "",
            ];
            event(new NewNotification($notification));
        }

        return response()->json(["message" => "Le jeu a été réinitialisé", "success" => true], 200);
    }

    public function changeScenario(NovaRequest $request)
    {
        $scenario = $request->scenario;

        if ($scenario == 'incendies') {
            // Update raw materials prices
            DB::table('raw_materials')->where('id', '=', 1)->update(['price' => 200]);   // Sucre
            DB::table('raw_materials')->where('id', '=', 4)->update(['price' => 130]);   // Blé
            DB::table('raw_materials')->where('id', '=', 5)->update(['price' => 1300]);   // Lait
            DB::table('raw_materials')->where('id', '=', 8)->update(['price' => 700]);   // Avoine

            // Update % population
            DB::table('products')->where('id', '=', 1)->update(['percent_population' => 0.99]);     // Galettes
            DB::table('products')->where('id', '=', 2)->update(['percent_population' => 0.55]);     // Cookies
            DB::table('products')->where('id', '=', 3)->update(['percent_population' => 0.35]);     // Sandwich glacé
            DB::table('products')->where('id', '=', 4)->update(['percent_population' => 0.35]);     // Céréales
            DB::table('products')->where('id', '=', 5)->update(['percent_population' => 0.1]);      // Granola

            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "Des incendies se sont déclenchés!",
                    "title" => "Incendies",
                    "icon_path" => "/assets/icons/fire.svg",

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == 'loi des finances') {
            // Update CA taxes %
            $this->set_game_setting('ca_tax_percent', 0.215);

            // // Update pollution taxes %
            // $this->set_game_setting('pollution_unit_cost', '');

            // Update raw materials prices
            DB::table('raw_materials')->where('id', '=', 1)->update(['price' => 230]);   // Sucre
            DB::table('raw_materials')->where('id', '=', 4)->update(['price' => 132]);   // Blé
            DB::table('raw_materials')->where('id', '=', 5)->update(['price' => 1350]);   // Lait
            DB::table('raw_materials')->where('id', '=', 6)->update(['price' => 1000]);   // Beurre

            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "La nouvelle loi des finances a été mise en place!",
                    "title" => "Loi des finances",
                    "icon_path" => "/assets/icons/loi_finance.svg",

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == 'crise cacao') {
            // Update cocoa availability
            // DB::table('raw_materials_supplier')
            //     ->where('raw_material_id', '=', 9)
            //     ->update(['is_available' => false]);   // Chocolat

            // Update % population
            DB::table('products')->where('id', '=', 1)->update(['percent_population' => 0.85]);   // Galettes
            DB::table('products')->where('id', '=', 2)->update(['percent_population' => 0.47]);   // Cookies
            DB::table('products')->where('id', '=', 3)->update(['percent_population' => 0.32]);   // Sandwich glacé
            DB::table('products')->where('id', '=', 4)->update(['percent_population' => 0.28]);   // Céréales
            DB::table('products')->where('id', '=', 5)->update(['percent_population' => 0.04]);   // Granola


            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "Une crise de cacao frappe l'industrie!",
                    "title" => "Crise cacao",
                    "icon_path" => "/assets/icons/cacao.svg",

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == 'war start') {
            // Update raw materials prices
            DB::table('raw_materials')->where('id', '=', 1)->update(['price' => 250]);   // Sucre
            DB::table('raw_materials')->where('id', '=', 4)->update(['price' => 140]);   // Blé
            DB::table('raw_materials')->where('id', '=', 8)->update(['price' => 900]);   // Avoine
            DB::table('raw_materials')->where('id', '=', 9)->update(['price' => 1100]);   // Cacao

            // Update CA taxes %
            $this->set_game_setting('ca_tax_percent', 0.23);

            // Update % population
            DB::table('products')->where('id', '=', 1)->update(['percent_population' => 0.9]);   // Galettes
            DB::table('products')->where('id', '=', 2)->update(['percent_population' => 0.5]);   // Cookies
            DB::table('products')->where('id', '=', 3)->update(['percent_population' => 0.35]);   // Sandwich glacé
            DB::table('products')->where('id', '=', 4)->update(['percent_population' => 0.3]);   // Céréales
            DB::table('products')->where('id', '=', 5)->update(['percent_population' => 0.05]);   // Granola

            // Update RH decrease factor
            $this->set_game_setting('workers_mood_decay_rate', 0.0575);

            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "Une guerre se déclenche et chamboule l'industrie mondiale!",
                    "title" => "Guerre_1",
                    "icon_path" => "/assets/icons/war.svg",

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == 'war middle') {
            // Update delivery times
            DB::table('raw_material_supplier')->where('supplier_id', 1)->update(['time_to_deliver' => 3]);
            DB::table('raw_material_supplier')->where('supplier_id', 2)->update(['time_to_deliver' => 6]);

            // // Update loans interests

            // Update % population
            DB::table('products')->where('id', '=', 1)->update(['percent_population' => 0.9]);   // Galettes
            DB::table('products')->where('id', '=', 2)->update(['percent_population' => 0.4]);   // Cookies
            DB::table('products')->where('id', '=', 3)->update(['percent_population' => 0.28]);   // Sandwich glacé
            DB::table('products')->where('id', '=', 4)->update(['percent_population' => 0.24]);   // Céréales
            DB::table('products')->where('id', '=', 5)->update(['percent_population' => 0.05]);   // Granola

            // Update machines prices
            $this->set_game_setting('machines_lv1_price', 600000);
            $this->set_game_setting('machines_lv2_price', 1500000);
            $this->set_game_setting('machines_lv3_price', 3000000);

            // Update RH decrease factor
            $this->set_game_setting('workers_mood_decay_rate', 0.0625);

            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "La guerre continue et ses répercussions se font sentir!",
                    "title" => "Guerre_2",
                    "icon_path" => "/assets/icons/war.svg",

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == 'war end') {
            // Update % population
            DB::table('products')->where('id', '=', 1)->update(['percent_population' => 0.95]);   // Galettes
            DB::table('products')->where('id', '=', 2)->update(['percent_population' => 0.55]);   // Cookies
            DB::table('products')->where('id', '=', 3)->update(['percent_population' => 0.40]);   // Sandwich glacé
            DB::table('products')->where('id', '=', 4)->update(['percent_population' => 0.35]);   // Céréales
            DB::table('products')->where('id', '=', 5)->update(['percent_population' => 0.12]);   // Granola

            // Update raw materials prices
            DB::table('raw_materials')->where('id', '=', 1)->update(['price' => 250]);   // Sucre
            DB::table('raw_materials')->where('id', '=', 4)->update(['price' => 90]);   // Blé
            DB::table('raw_materials')->where('id', '=', 8)->update(['price' => 700]);   // Avoine

            // Update CA taxes %
            $this->set_game_setting('ca_tax_percent', 0.17);

            // Update machines prices
            $this->set_game_setting('machines_lv1_price', 450000);
            $this->set_game_setting('machines_lv2_price', 1125000);
            $this->set_game_setting('machines_lv3_price', 2250000);

            // Update RH decrease factor
            $this->set_game_setting('workers_mood_decay_rate', 0.05);

            // Update marketing price

            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "La guerre se termine enfin...",
                    "title" => "Guerre_3",
                    "icon_path" => "/assets/icons/war.svg",

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        }

        return response()->json(["message" => "Scénario " . $scenario . " lancé.", "success" => true], 200);
    }
}
