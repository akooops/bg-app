<x-app-layout>
    <!-- <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Production') }}
        </h2>
    </x-slot> -->

    <div class="mx-auto px-8 py-10">
        <div class="flex flex-wrap sm:rounded-lg">
            <div class="flex justify-center gap-6 mb-6 w-full">
                <Disponibility :user="{{ Auth::user() }}" :dette="false"></Disponibility>
                <Disponibility :user="{{ Auth::user() }}" :dette="true"></Disponibility>
            </div>
            <div class="w-full px-3 h-full">
                <ProductionDepartment :products="{{$products}}" :caisse="{{$caisse}}" :user="{{auth()->user()}}"></ProductionDepartment>
            </div>
        </div>
    </div>
</x-app-layout>