<x-app-layout>
    <!-- <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Production') }}
        </h2>
    </x-slot> -->

    <div class="">
        <div class=" mx-auto sm:px-6 lg:px-8">
            <div class="flex flex-wrap sm:rounded-lg">
                <div class="flex w-full justify-between items-center">
                    <h1 class="text-xl font-bold mt-8 mb-4">Département Production: </h1>
                    
                </div>
                <div class="w-full px-3 h-full">
                    <ProductionDepartment :products="{{$products}}" :caisse="{{$caisse}}" :user="{{auth()->user()}}"></ProductionDepartment>
                </div>

            </div>
        </div>
    </div>
</x-app-layout>