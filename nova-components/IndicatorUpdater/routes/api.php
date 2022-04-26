<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use  Manou\IndicatorUpdater\IndicatorUpdaterController;
/*
|--------------------------------------------------------------------------
| Tool API Routes
|--------------------------------------------------------------------------
|
| Here is where you may register API routes for your tool. These routes
| are loaded by the ServiceProvider of your tool. They are protected
| by your tool's "Authorize" middleware by default. Now, go build!
|
*/

// Route::get('/endpoint', function (Request $request) {
//     //
// });
Route::get('/indicators', [IndicatorUpdaterController::class,"getIndicators"]);
Route::post('/update-indicator', [IndicatorUpdaterController::class,"updateIndicators"]);

Route::post('/entreprise-indicators', [IndicatorUpdaterController::class, "getEntrepriseIndicators"]);

Route::get('/get-settings', [IndicatorUpdaterController::class, "getSettings"]);
Route::post('/set-setting', [IndicatorUpdaterController::class, "setSetting"]);
Route::post('/reset-setting', [IndicatorUpdaterController::class, "resetSetting"]);
