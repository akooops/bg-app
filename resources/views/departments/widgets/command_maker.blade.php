<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Commandes') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class=" mx-auto sm:px-6 lg:px-8">
            <div class="flex flex-wrap  overflow-hidden  sm:rounded-lg">
                <h1 class = "text-xl font-bold">Nouvelle Commande:</h1>
                    <CommandMaker
                    :materials = "{{$materials}}"
                    :suppliers = "{{$suppliers}}" 
                    :user = "{{auth()->user()}}"
                    :caisse = "{{$caisse}}"
                    ></CommandMaker>
                
            </div>
        </div>
    </div>
</x-app-layout>
