<?php

namespace Manou\IndicatorUpdater;

use App\Models\Product;
use App\Models\Indicator;
use App\Models\Entreprise;
use App\Models\RawMaterial;
use App\Traits\HelperTrait;
use App\Traits\IndicatorTrait;
use App\Events\NewNotification;
use Illuminate\Support\Facades\DB;
use App\Events\SimulationDateChanged;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\Artisan;
use Laravel\Nova\Http\Requests\NovaRequest;

class IndicatorUpdaterController
{
    use HelperTrait, IndicatorTrait;

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
        $indicator_code = DB::table('indicators')->where('id', $indicator_id)->first()->code;
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
                // $indicator->update(["value" => $value]);
                $this->setIndicator($indicator_code, $entreprise_id, $value);
            }
            else if ($operation == 'add') {
                // $indicator->update(["value" => $indicator->first()->value + $value]);
                $this->updateIndicator($indicator_code, $entreprise_id, $value);
            }
            else if ($operation == 'mult') {
                if ($value < 0) {
                    return response()->json(["message" => "Impossible de mettre l'indicateur à jour: multiplication par nombre négatif.", "success" => false], 200);
                }
                // $indicator->update(["value" => $indicator->first()->value * $value]);
                $indicator->setIndicator($indicator_code, $entreprise_id, $indicator->first()->value * $value);
            }
            else if ($operation == 'reset') {
                // $default_value = DB::table('indicators')->where('indicator_id', '=', $indicator_id)->first()->starting_value;
                // $indicator->update(["value" => $default_value]);
                $this->resetIndicator($indicator_code, $entreprise_id);
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
        DB::table('raw_materials')->where('id', '=', 10)->update(['price' => 10000]);      // Laine   //agg
        DB::table('raw_materials')->where('id', '=', 11)->update(['price' => 3000]);       // Coton
        DB::table('raw_materials')->where('id', '=', 12)->update(['price' => 800]);      // Polyester
        DB::table('raw_materials')->where('id', '=', 13)->update(['price' => 850]);      // Garniture
        DB::table('raw_materials')->where('id', '=', 14)->update(['price' => 2500]);      // Lin
        DB::table('raw_materials')->where('id', '=', 15)->update(['price' => 25000]);      // La soie
        DB::table('raw_materials')->where('id', '=', 16)->update(['price' => 2800]);     // Cuir
        DB::table('raw_materials')->where('id', '=', 17)->update(['price' => 37000]);      // Fixation
        DB::table('raw_materials')->where('id', '=', 18)->update(['price' => 900]);      // Matières chimiques
        DB::table('raw_materials')->where('id', '=', 19)->update(['price' => 8000]);      // Packaging

        // Reset machine prices
        $this->set_game_setting('machines_lv0_price', 6200000);  //agg
        $this->set_game_setting('machines_lv1_price', 9000000);
        $this->set_game_setting('machines_lv2_price', 18000000);
        $this->set_game_setting('machines_lv3_price', 45000000);

        // Reset products' left demand
        //DB::table('products')->update(['left_demand' => DB::raw('avg_demand')]);

       // Reset products' stocks agg
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

        // Reset raw materials'stocks
        $raw_materials = RawMaterial::all();

        foreach ($entreprises as $entrep) {
            foreach ($raw_materials as $raw_mat) {
                $stock = DB::table('raw_materials_stock')->where('entreprise_id', '=', $entrep->id)->where('raw_material_id', '=', $raw_mat->id);

                $quantity = 0;

                //switch ($raw_mat->id) {   //agg
                  /*  case 10:         // Laine
                        $quantity = 6860;
                        break;

                    case 11:         // Coton
                        $quantity = 6500;
                        break;

                    case 12:         // Polyester
                        $quantity = 1800;
                        break;

                    case 13:         // Garniture
                        $quantity = 31800;
                        break;

                    case 14:         // Lin
                        $quantity = 6250;
                        break;

                    case 15:         // La soie
                        $quantity = 8250;
                        break;

                    case 16:         // Cuir
                        $quantity = 9000;
                        break;

                    case 17:         // Fixation
                        $quantity = 12500;
                        break;

                    case 18:         // Matières chimiques
                        $quantity = 14750;
                        break;

                    case 19:         // Packaging
                         $quantity = 14750;
                         break;
                } */

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

        if ($scenario == 'Changement climatique') { //agg
            // Update raw materials prices
            DB::table('raw_materials')->where('id', '=', 11)->update(['price' => 2900]);   // Coton  //agg
            DB::table('raw_materials')->where('id', '=', 14)->update(['price' => 24000]);   // Lin


            // Update % population
            DB::table('products')->where('id', '=', 4)->update(['percent_population' => 37.541]);     // T-shirt      //agg
            DB::table('products')->where('id', '=', 5)->update(['percent_population' => 1.063]);     // Polo rugby
            DB::table('products')->where('id', '=', 7)->update(['percent_population' => 4.162]);     // Parkas
            DB::table('products')->where('id', '=', 10)->update(['percent_population' => 0.775]);     // jupe ajuste
            DB::table('products')->where('id', '=', 11)->update(['percent_population' => 8.2832]);      // jupe longue
            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [  //agg
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "Des changements climatiques !",//agg
                    "title" => "Changement climatique",
                    "icon_path" => "/assets/icons/fire.svg",//agg

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == 'Un post dun influenceur') { //agg

            //prix marketing //agg
            DB::table('products')->where('id', '=', 1)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 2)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 3)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 4)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 5)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 6)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 7)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 8)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 9)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 10)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 11)->update(['ad_coef' => 1.2]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 12)->update(['ad_coef' => 1.2]);     // Pantalo Cargo


            // Update Products demand  //agg
            DB::table('products')->where('id', '=', 1)->update(['percent_population' => 5.288]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 4)->update(['percent_population' => 27.302]);    // T-shirt
            DB::table('products')->where('id', '=', 7)->update(['percent_population' => 3.027]);     // Parkas
            DB::table('products')->where('id', '=', 11)->update(['percent_population' =>5.987]);     // Jupe longue
            DB::table('products')->where('id', '=', 12)->update(['percent_population' => 15.894]);   // Pull a col bateau

            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {//agg
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "La nouvelle story de XOXO fait l'affaire ", //agg
                    "title" => "Un post dun influenceur",
                    "icon_path" => "/assets/icons/loi_finance.svg", //agg

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == 'Reglement RH') {//agg

            // Update machine Price  //agg


            $this->set_game_setting('machines_lv1_price', 9900000); //agg
            $this->set_game_setting('machines_lv2_price', 19800000); //agg
            $this->set_game_setting('machines_lv3_price', 49500000); //agg


            // Update RH decrease factor
            $this->set_game_setting('workers_mood_decay_rate', 0.0575); //agg
            // Update % de taxes sur les CA
            $this->set_game_setting('ca_tax_percent', 0.13);
            // bloquer la nouvelle machine
             //$this->set_game_setting('can_buy_machines_lv0',0 ); //agg à changer
             $entreprises = Entreprise::all();
             foreach ($entreprises as $entrep) {
             DB::table('entreprise_indicator')->where('entreprise_id', '=', $entrep->id)->where('indicator_id', '=', 52)->update(['value' => 0]) ;
             } // nb de machine nv0 devient 0
             $this->set_game_setting('machines_lv0_price',1000000000000000 );
             $this->set_game_setting('machines_lv0_durability',0 );

            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "Une crise de RH frappe l'industrie!", //agg
                    "title" => "Reglement RH",
                    "icon_path" => "/assets/icons/cacao.svg", //agg

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        }
        else if ($scenario == 'Tremblement de terre Turquie') {
            // Update raw materials prices  //agg

            DB::table('raw_materials')->where('id', '=', 10)->update(['price' => 11000]);    //laine
            DB::table('raw_materials')->where('id', '=', 11)->update(['price' => 3300]);    //coton

            // Update Products  //agg

            DB::table('products')->where('id', '=', 1)->update(['percent_population' => 8.593]);     // Pantalo Cargo
            DB::table('products')->where('id', '=', 12)->update(['percent_population' => 25.827]);     // pull col bqtequ
            DB::table('products')->where('id', '=', 7)->update(['percent_population' =>7.568]);     // Parkas

            // Update POPULATION  //agg
            $this->set_game_setting('population', 1010000); //agg

            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "Une guerre se déclenche et chamboule l'industrie mondiale!", //agg
                    "title" => "Tremblement de terre Turquie", //agg
                    "icon_path" => "/assets/icons/war.svg",  //agg

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == ' Les repercusions de la guerre') { //agg
            // Update delivery times  //agg
            DB::table('raw_material_supplier')->where('supplier_id', 1)->update(['time_to_deliver' => 7]);
            //DB::table('raw_material_supplier')->where('supplier_id', 2)->update(['time_to_deliver' => 6]);


            // Update Polyester and lin  price  //agg
            DB::table('raw_materials')->where('id', '=', 12)->update(['price' => 1100]);    //Polyester
            DB::table('raw_materials')->where('id', '=', 14)->update(['price' => 31000]);    //lin
            DB::table('raw_materials')->where('id', '=', 10)->update(['price' => 10000]);    //laine
            DB::table('raw_materials')->where('id', '=', 11)->update(['price' => 3000]);    //coton

            // Frais supplémentaires  //agg
            DB::table('products')->where('id', '=', 1)->update(['unit_prod_price' => 575]);
            DB::table('products')->where('id', '=', 2)->update(['unit_prod_price' => 2300]);
            DB::table('products')->where('id', '=', 3)->update(['unit_prod_price' => 3450]);
            DB::table('products')->where('id', '=', 4)->update(['unit_prod_price' => 575]);
            DB::table('products')->where('id', '=', 5)->update(['unit_prod_price' => 2300]);
            DB::table('products')->where('id', '=', 6)->update(['unit_prod_price' => 2300]);
            DB::table('products')->where('id', '=', 7)->update(['unit_prod_price' => 920]);
            DB::table('products')->where('id', '=', 8)->update(['unit_prod_price' => 2300]);
            DB::table('products')->where('id', '=', 9)->update(['unit_prod_price' => 2875]);
            DB::table('products')->where('id', '=', 10)->update(['unit_prod_price' => 2300]);
            DB::table('products')->where('id', '=', 11)->update(['unit_prod_price' => 575]);
            DB::table('products')->where('id', '=', 12)->update(['unit_prod_price' => 575]);


            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "La guerre continue et ses répercussions se font sentir!", //agg
                    "title" => " Les repercusions de la guerre", //agg
                    "icon_path" => "/assets/icons/war.svg",  //agg

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if ($scenario == 'Les crises geopolitiques') {

            // Update raw materials prices //agg
            DB::table('raw_materials')->where('id', '=', 15)->update(['price' => 39000]);   // La soie
            DB::table('raw_materials')->where('id', '=', 16)->update(['price' => 10000]);   // cuir
            DB::table('raw_materials')->where('id', '=', 11)->update(['price' => 4000]);   // coton

           // Update delivery times  //agg
           DB::table('raw_material_supplier')->where('supplier_id', 1)->update(['time_to_deliver' => 7]);
           DB::table('raw_material_supplier')->where('supplier_id', 2)->update(['time_to_deliver' => 4]);

            // Update Machines Prix //agg

            $this->set_game_setting('machines_lv0_price', 6820000); //agg
            $this->set_game_setting('machines_lv1_price', 9900000); //agg
            $this->set_game_setting('machines_lv2_price', 19800000); //agg
            $this->set_game_setting('machines_lv3_price', 49500000); //agg

           // Frais supplémentaires  //agg
            DB::table('products')->where('id', '=', 1)->update(['unit_prod_price' => 625]);
            DB::table('products')->where('id', '=', 2)->update(['unit_prod_price' => 2500]);
            DB::table('products')->where('id', '=', 3)->update(['unit_prod_price' => 3750]);
            DB::table('products')->where('id', '=', 4)->update(['unit_prod_price' => 625]);
            DB::table('products')->where('id', '=', 5)->update(['unit_prod_price' => 2500]);
            DB::table('products')->where('id', '=', 6)->update(['unit_prod_price' => 2500]);
            DB::table('products')->where('id', '=', 7)->update(['unit_prod_price' => 1000]);
            DB::table('products')->where('id', '=', 8)->update(['unit_prod_price' => 2500]);
            DB::table('products')->where('id', '=', 9)->update(['unit_prod_price' => 3125]);
            DB::table('products')->where('id', '=', 10)->update(['unit_prod_price' => 2500]);
            DB::table('products')->where('id', '=', 11)->update(['unit_prod_price' => 625]);
            DB::table('products')->where('id', '=', 12)->update(['unit_prod_price' => 625]);

            // couts de transport


            $entreprises = Entreprise::all();
            foreach ($entreprises as $entrep) {
                $notification = [
                    "entreprise_id" => $entrep->id,
                    "type" => "ScenarioNotif",

                    "store" => true,

                    "text" => "La guerre se termine enfin...", //agg
                    "title" => "Les crises geopolitiques", //agg
                    "icon_path" => "/assets/icons/war.svg", //agg

                    "style" => "scenario",
                ];
                event(new NewNotification($notification));
            }
        } else if  ($scenario == 'Crise banque et inflations') {
            // prix unitaire emmisions carbon 	2000
            $this->set_game_setting('pollution_unit_cost', 2000); //agg

            //  % interets des banques	*1,05
            $entreprises = Entreprise::all();
             foreach ($entreprises as $entrep) {
             DB::table('entreprise_indicator')->where('entreprise_id', '=', $entrep->id)->where('indicator_id', '=', "30")->update(['value' => 1.05]) ;
             }

            //% des taxes caf	15%
            $this->set_game_setting('ca_tax_percent', 0.15); //agg

        }


        return response()->json(["message" => "Scénario " . $scenario . " lancé.", "success" => true], 200);
    }
}
