<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\EntrepriseController;
use App\Http\Controllers\SupplierController;
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


//Route::post("/commands/create",[EntrepriseController::class,"createCommand"]);

Route::prefix("entreprise")->group(function(){
	Route::get("/commands",[EntrepriseController::class,"getEntrepriseCommands"]);
	Route::get("/stock",[EntrepriseController::class,"getStock"]);
	Route::get("/production/indicators",[EntrepriseController::class,"getProdIndicators"]);
});

Route::prefix("demand")->group(function(){
	Route::get("/prev",[EntrepriseController::class,"getProductDemandPrev"]);
});

Route::prefix("command")->group(function(){
    Route::post('/create', [EntrepriseController::class,"createCommand"]);
    Route::get('/get/all', [SupplierController::class,"getAllCommands"]);
    Route::get('/get', [SupplierController::class,"getCommand"]);
    Route::post('/validate', [SupplierController::class,"validateCommand"]);
});


Route::prefix("loan")->group(function(){
    Route::post('/create', [BankerController::class,"createLoan"]);
    Route::get('/get', [BankerController::class,"getLoan"]);
    Route::post('/update', [BankerController::class,"updateLoan"]);
});
Route::prefix("marketing")->group(function(){
    Route::post('/create', [MarketingController::class,"createAd"]);
    Route::get('/get', [MarketingController::class,"getAd"]);
});
