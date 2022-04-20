<x-app-layout>


    <div class="mx-auto px-8 py-10">
        <div class="flex flex-wrap sm:rounded-lg">
            <div class="flex justify-center gap-6 mb-6 w-full">
                <Disponibility :user="{{ Auth::user() }}" :dette="false"></Disponibility>
                <Disponibility :user="{{ Auth::user() }}" :dette="true"></Disponibility>
            </div>
            <div class="w-full px-2 h-full">
                <ProductionDepartment :products="{{$products}}" :caisse="{{$caisse}}" :user="{{auth()->user()}}"></ProductionDepartment>
            </div>
        </div>
    </div>
</x-app-layout>