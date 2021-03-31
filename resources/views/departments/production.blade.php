<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Production') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class=" mx-auto sm:px-6 lg:px-8">
            <div class="flex flex-wrap   overflow-hidden  sm:rounded-lg">
               <div class = "flex w-full justify-between items-center">
                <h1 class = "text-xl mr-5  font-bold">Département Production: </h1>
                <div class = "inline-flex">
                    
                </div>
            </div>
                <div class = "w-full px-3">
                    <ProductionDepartment
                    :products = "{{$products}}"
                    
                    :user = "{{auth()->user()}}"
                    ></ProductionDepartment>
                </div>
                
            </div>
        </div>
    </div>
</x-app-layout>
