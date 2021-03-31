<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BankerController;
use App\Http\Controllers\MarketingController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
Route::prefix("loan")->group(function(){
    Route::post('/create', [BankerController::class,"createLoan"]);
    Route::get('/get', [BankerController::class,"getLoan"]);
    Route::post('/update', [BankerController::class,"updateLoan"]);
});
Route::prefix("marketing")->group(function(){
    Route::post('/create', [MarketingController::class,"createAd"]);
    Route::get('/get', [MarketingController::class,"getAd"]);
    Route::post('/update', [MarketingController::class,"updateAd"]);
});