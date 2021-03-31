<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Stock') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class=" mx-auto sm:px-6 lg:px-8">
            <div class="flex  flex-wrap  overflow-hidden  sm:rounded-lg">
               <div class = "flex w-full justify-between items-center">
                <h1 class = "text-xl mr-5  font-bold">Votre Stock: </h1>
                <a href = "/entreprise/department/Approvisionnement" class = "bg-green-400 hover:bg-green-800  text-white py-2 px-4 rounded cursor-pointer">Revenir aux commandes</a>
            </div>
                <div class = "w-full my-2 px-3">
                    <Stock
                    :user = "{{auth()->user()}}"
                    ></Stock>
                </div>
                
            </div>
        </div>
    </div>
</x-app-layout>
