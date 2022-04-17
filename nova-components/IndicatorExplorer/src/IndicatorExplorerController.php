<?php

namespace Manou\IndicatorExplorer;

use Illuminate\Database\Query\Builder;
use Laravel\Nova\Http\Requests\NovaRequest;
use Illuminate\Support\Facades\DB;

class IndicatorExplorerController
{
    public function getIndicators(NovaRequest $request)
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
}
