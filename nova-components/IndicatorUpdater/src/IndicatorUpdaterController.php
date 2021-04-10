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
       $indicators = DB::table('indicators')->get();

       return response()->json($indicators);
    }

    public function updateIndicators(NovaRequest $request)
    {
        DB::table('entreprise_indicator')->where('indicator_id',$request->selected_indicator)->update(['value'=>$request->value]);
        if($request->has_notification==true){
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
         return response()->json("Success", 200);
        
    }

   
}