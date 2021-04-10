<?php

namespace Manou\IndicatorUpdater;

use Illuminate\Database\Query\Builder;
use Laravel\Nova\Http\Requests\NovaRequest;
use Illuminate\Support\Facades\DB;
use App\Events\NewNotification;
use App\Models\Entreprise;
class IndicatorUpdaterController
{
    public function getIndicators(NovaRequest $request)
    {
       $data=[
        "indicators" => DB::table('indicators')->get(),
        "entreprises" => Entreprise::get()
       ];
       return response()->json($data);
    }

    public function updateIndicators(NovaRequest $request)
    {
        $indicator = DB::table('entreprise_indicator')->where('indicator_id',$request->selected_indicator);
        if($request->all_entreprises==false){
            $indicator = $indicator->where('entreprise_id',$request->selected_entreprise);
        }
        if($request->replace==true){
            $indicator->update(["value"=>(int)$request->value]);   
        }
        if($request->has_rate==true){
            $indicator = $indicator->get();
            foreach($indicator as $ind){
                $temp = DB::table('entreprise_indicator')->where("id",$ind->id);
                $temp->update(['value'=>(100-(int)$request->rate)*0.01*$ind->value]);
            }   
        }
        else{
            $indicator->increment('value',(int)$request->increment);
        }
        if($request->has_notification==true && $request->all_entreprises==true){
        $entreprises = Entreprise::get();
        foreach($entreprises as $entreprise){
                $notification = [
                    "type" => "NewNotif",
                    "status" => $request->notification_type,
                    "entreprise_id" => $entreprise->id,
                    "data" => [],
                    "message" => $request->description,
                    "title" => $request->title,
                ];
                event(new NewNotification($notification));
            }
        }
        else{
            $notification = [
                "type" => "NewNotif",
                "status" => $request->notification_type,
                "entreprise_id" => $request->selected_entreprise,
                "data" => [],
                "message" => $request->description,
                "title" => $request->title,
            ];
            event(new NewNotification($notification));
        }

         return response()->json("Success", 200);
        
    }

   
}