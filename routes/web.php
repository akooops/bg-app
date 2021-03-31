<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EntrepriseController;
use App\Models\Command;
use App\Models\Entreprise;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});





Route::prefix("entreprise")->middleware(["auth","entreprise"])->group(function(){
	
	Route::get('/dashboard',[EntrepriseController::class,"showDashboard"])->name("dashboard");

	Route::get('/department/Approvisionnement',[EntrepriseController::class,"showDptApprov"])->name("approv");
	Route::get('/department/Production',[EntrepriseController::class,"showDptProduction"])->name("production");
	Route::get('/command/create',[EntrepriseController::class,"showCommandMaker"])->name("approv");
	Route::get('/stock',[EntrepriseController::class,"showStock"])->name("stock");
    Route::get('/loans',function(){
        return view('loans');
    })->name("loans");

});

Route::prefix("supplier")->middleware(["auth","supplier"])->group(function(){
	
	Route::get('/dashboard', function () {
    	return view('supplier.dashboard');
	})->name('supplier_dashboard');
	Route::get('/command/{id}',function ($id) {
		$entreprise_id = Command::where("command_id","=",$id)->first()->entreprise_id;
    	return view('supplier.single_command',["command_id"=>$id,"entreprise_id"=>$entreprise_id]);
	});
});

    Route::get('/entreprise/department/Marketing', function () {
        return view('departments.marketing');
    });

Route::get('/banker/dashboard', function () {
    return view('banker.dashboard');
})->middleware(['auth','banker'])->name('banker_dashboard');

require __DIR__.'/auth.php';
