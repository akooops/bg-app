<?php

namespace App\Http\Middleware;

use App\Traits\HelperTrait;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class GameStarted
{
    use HelperTrait;

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        $game_started = $this->get_game_setting('game_started');

        if ($game_started) {
            return $next($request);
        }
        else {
            return new Response(view('welcome'));
        }

    }
}
