<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Entreprise;
use App\Models\Supplier;
use App\Models\Banker;
use App\Providers\RouteServiceProvider;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class RegisteredUserController extends Controller
{
    /**
     * Display the registration view.
     *
     * @return \Illuminate\View\View
     */
    public function create()
    {
        return view('auth.register');
    }

    /**
     * Handle an incoming registration request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|confirmed|min:8',
        ]);
        if($request->type=='banker'){
            Auth::login($user = Banker::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'type' => 'banker'
            ]));
        }
        else if($request->type == 'supplier'){
            Auth::login($user = Supplier::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'type' => 'supplier'
            ]));
        }
        else{
            Auth::login($user = Entreprise::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'type' => 'entreprise'
            ]));
        }
        event(new Registered($user));
        
        if($user->type=='supplier'){
            return redirect(RouteServiceProvider::SUPPLIER_HOME);
        }
        if($user->type == 'banker'){
            return redirect(RouteServiceProvider::BANKER_HOME);
        }
        return redirect(RouteServiceProvider::HOME);
    }
}
