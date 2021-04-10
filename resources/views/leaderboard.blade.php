<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Leaderboard') }}
        </h2>
    </x-slot>

    <div class="py-2">
        <div class=" mx-auto sm:px-6 lg:px-8">
            
                <div class = "w-full px-3">
                   <Leaderboard ></Leaderboard>
                </div>
                
            </div>
        </div>
    </div>
</x-app-layout>
