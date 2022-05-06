<?php

use App\Models\Command;
use App\Models\Entreprise;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EntrepriseController;

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


Route::prefix("entreprise")->middleware(["auth", "entreprise", "game_started"])->group(function () {

	Route::get('/dashboard', [EntrepriseController::class, "showDashboard"])->name("dashboard");

	Route::get('/department/Approvisionnement', [EntrepriseController::class, "showDptApprov"])->name("approv");
	Route::get('/department/Production', [EntrepriseController::class, "showDptProduction"])->name("production");
	Route::get('/department/Marketing', [EntrepriseController::class, "showMarketing"])->name("marketing");
	Route::get('/department/Finance', [EntrepriseController::class, "showFinance"])->name("finance");
	Route::get('/department/Ressources Humaines', [EntrepriseController::class, "showHr"])->name("rh");

	Route::get('/command/create', [EntrepriseController::class, "showCommandMaker"]);

	Route::get('/stock', [EntrepriseController::class, "showStock"])->name("stock");

	Route::get('/loans', [EntrepriseController::class, "showLoans"])->name("loans");
	Route::get('/profil' , [EntrepriseController::class, 'showProfil'] )->name("profil");
});

Route::prefix("supplier")->middleware(["auth", "supplier", "game_started"])->group(function () {

    Route::get('/dashboard', function () {
        return view('supplier.dashboard');
    })->name('supplier_dashboard');

    Route::get('/command/{id}', function ($id) {
        $entreprise_id = Command::where("command_id", "=", $id)->first()->entreprise_id;
        return view('supplier.single_command', ["command_id" => $id, "entreprise_id" => $entreprise_id]);
    });
});

Route::get('/logout', function () {
    Auth::logout();
    return redirect("/login");
});

Route::get('/banker/dashboard', function () {
    return view('banker.dashboard');
})->middleware(['auth', 'banker', 'game_started'])->name('banker_dashboard');


Route::get('/leaderboard', function () {
	return view('leaderboard');
});

require __DIR__ . '/auth.php';
