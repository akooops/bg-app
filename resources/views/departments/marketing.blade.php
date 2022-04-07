<x-app-layout>
    <div class="py-12 w-full">
        <div class="flex justify-center gap-6 mb-6 w-full">
            <Disponibility :user="{{ Auth::user() }}" :dette="false"></Disponibility>
            <Disponibility :user="{{ Auth::user() }}" :dette="true"></Disponibility>
        </div>
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="">
                <Marketing v-bind:entreprise="{{auth()->user()}}" v-bind:products="{{$products}}" v-bind:ad_coef="{{$ad_coef}}" v-bind:caisse="{{$caisse}}"></Marketing>
            </div>
        </div>
    </div>
</x-app-layout>