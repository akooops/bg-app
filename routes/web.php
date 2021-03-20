<?php

use Illuminate\Support\Facades\Route;

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

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth','entreprise'])->name('dashboard');

Route::get('/supplier/dashboard', function () {
    return view('supplier.dashboard');
})->middleware(['auth','supplier'])->name('supplier_dashboard');

Route::get('/banker/dashboard', function () {
    return view('banker.dashboard');
})->middleware(['auth','banker'])->name('banker_dashboard');

require __DIR__.'/auth.php';
