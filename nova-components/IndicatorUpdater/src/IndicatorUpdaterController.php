<?php

namespace Manou\IndicatorUpdater;

use App\Models\Entreprise;
use App\Traits\HelperTrait;
use App\Events\NewNotification;
use Illuminate\Support\Facades\DB;
use App\Events\SimulationDateChanged;
use Illuminate\Database\Query\Builder;
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

        // $indicator = DB::table('entreprise_indicator')->where('indicator_id', $request->selected_indicator);
        // if ($request->all_entreprises == false) {
        //     $indicator = $indicator->where('entreprise_id', $request->selected_entreprise);
        // }

        // if ($request->replace == true) {
        //     $indicator->update(["value" => (int)$request->value]);
        // }

        // if ($request->has_rate == true) {
        //     $indicator = $indicator->get();
        //     foreach ($indicator as $ind) {
        //         $temp = DB::table('entreprise_indicator')->where("id", $ind->id);
        //         $temp->update(['value' => (100 - (int)$request->rate) * 0.01 * $ind->value]);
        //     }
        // } else {
        //     $indicator->increment('value', (int)$request->increment);
        // }
        // if ($request->has_notification == true && $request->all_entreprises == true) {
        //     $entreprises = Entreprise::get();
        //     foreach ($entreprises as $entreprise) {
        //         $notification = [
        //             "type" => "NewNotif",
        //             "entreprise_id" => $entreprise->id,

        //             "store" => true,

        //             "text" => $request->description,
        //             "title" => $request->title,
        //             "icon_path" => "aaaaaaaaaaa",

        //             "style" => $request->notification_type,
        //         ];
        //         event(new NewNotification($notification));
        //     }
        // } else {
        //     $notification = [
        //         "entreprise_id" => $request->selected_entreprise,
        //         "type" => "NewNotif",

        //         "store" => true,

        //         "text" => $request->description,
        //         "title" => $request->title,
        //         "icon_path" => "aaaaaaaaaaa",

        //         "style" => $request->notification_type,
        //     ];
        //     event(new NewNotification($notification));
        // }
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
}
