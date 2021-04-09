<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Département Marketing') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <Marketing  v-bind:entreprise="{{auth()->user()}}" 
                    v-bind:products="{{$products}}"  v-bind:ad_coef="{{$ad_coef}}"
                    v-bind:caisse ="{{$caisse}}"></Marketing>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
