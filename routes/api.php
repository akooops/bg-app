<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\EntrepriseController;
use App\Http\Controllers\HrController;
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

Route::prefix("entreprise")->middleware(['game_started'])->group(function () {
	Route::get("/commands", [EntrepriseController::class, "getEntrepriseCommands"]);

	Route::get("/stock", [EntrepriseController::class, "getStock"]);
    Route::get("/products-stock", [EntrepriseController::class, "getProductsStock"]);
    Route::post("/sell-product", [EntrepriseController::class, "putProdToSell"]);

	Route::get("/production/indicators", [EntrepriseController::class, "getProdIndicators"]);
    Route::get("/marketing/indicators", [MarketingController::class, "getMarketingIndicators"]);

    Route::post("/machine/buy", [EntrepriseController::class, "buyMachine"]);
    Route::post("/machine/sell", [EntrepriseController::class, "sellMachine"]);
    Route::post("/machine/info", [EntrepriseController::class, "getMachinesInfo"]);

    Route::post("/action/apply", [EntrepriseController::class, "applyProdAction"]);

    Route::get("/hr/indicators", [HrController::class, "getHrIndicators"]);
    Route::get("/hr/get-data", [HrController::class, "getHrData"]);
    Route::post("/hr/hire", [HrController::class, "hireWorkers"]);
    Route::post("/hr/fire", [HrController::class, "fireWorkers"]);
    Route::post("/hr/launch-workshop", [HrController::class, "launchWorkshop"]);
    Route::post("/hr/prime-workers", [HrController::class, "primeWorkers"]);
    Route::post("/hr/updateworkerssalary", [HrController::class, "updateworkerssalary"]);

    Route::get("/notifications", [EntrepriseController::class, "getNotifications"]);
    Route::post("/read-notifications", [EntrepriseController::class, "readNotifications"]);

    Route::get("/stats", [EntrepriseController::class, "getStats"]);

    Route::get("/indicators", [EntrepriseController::class, "getIndicators"]);
});

Route::prefix("demand")->group(function() {
	Route::get("/prev",[EntrepriseController::class, "getProductDemandPrev"]);
    Route::get("/real",[EntrepriseController::class, "getProductDemandReal"]);
});

Route::prefix("command")->group(function() {
    Route::post('/create', [EntrepriseController::class, "createCommand"]);
    Route::get('/get/all', [SupplierController::class, "getAllCommands"]);
    Route::get('/get', [SupplierController::class, "getCommand"]);
    Route::post('/validate', [SupplierController::class, "validateCommand"]);
});

Route::prefix("production")->group(function() {
    Route::post('/launch', [EntrepriseController::class, "launchProduction"]);
    Route::get('/all', [EntrepriseController::class, "getAllProductions"]);
    Route::post("/sell", [EntrepriseController::class, "sellProd"]);
    Route::get("/avg-price", [EntrepriseController::class, "getAvgPrice"]);
});


Route::prefix("loan")->group(function() {
    Route::post('/create', [BankerController::class, "createLoan"]);
    Route::get('/get', [BankerController::class, "getLoan"]);
    Route::post('/pay', [BankerController::class, "payLoan"]);
    Route::post('/update', [BankerController::class, "updateLoan"]);
});
Route::prefix("marketing")->group(function(){
    Route::post('/create', [MarketingController::class, "createAd"]);
    Route::get('/get', [MarketingController::class, "getAd"]);
});


Route::prefix("indicator")->group(function(){
    Route::get('/market-share-prod', [EntrepriseController::class, "getProductMarketShare"]);
    Route::get('/market-share', [EntrepriseController::class, "getMarketShare"]);
     Route::get('/finance', [EntrepriseController::class, "getFinanceIndicators"]);
});

Route::get('/navbar', [EntrepriseController::class, "getNavbarData"]);




Route::get('/time', [EntrepriseController::class, "getSimulationTime"]);
Route::get('/products', [EntrepriseController::class, "getProducts"]);
Route::get('/ranking', [EntrepriseController::class, "getRanking"]);
Route::get("/test", [EntrepriseController::class, "testFunc"]);
Route::get("/supp_raw_mats", [EntrepriseController::class, "getSuppRawMatInfo"]);
