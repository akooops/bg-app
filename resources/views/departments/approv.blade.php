<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Commandes') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class=" mx-auto sm:px-6 lg:px-8">
            <div class="flex flex-wrap   overflow-hidden  sm:rounded-lg">
               <div class = "flex w-full justify-between items-center">
                <h1 class = "text-xl mr-5  font-bold">Vos Commandes: </h1>
                <div class = "inline-flex">
                    <a href = "/entreprise/command/create" class = "bg-green-400 hover:bg-green-800  text-white py-2 px-4 rounded cursor-pointer">Créer une commande</a>
                    <a href = "/entreprise/stock" class = "right-0 bg-blue-400 hover:bg-blue-800  text-white py-2 px-4 mx-3 rounded cursor-pointer">Afficher le stock</a>
                </div>
            </div>
                <div class = "w-full px-3">
                    <ApprovDepartment
                    :user = "{{auth()->user()}}"
                    ></ApprovDepartment>
                </div>

            </div>
        </div>
    </div>
</x-app-layout>
