<x-app-layout>

    <div class="py-12 w-full">
        <div class="max-w-[1400px] mx-auto lg:px-12">
            <Finance v-bind:user="{{auth()->user()}}" v-bind:products="{{$products}}" v-bind:entreprises="{{$entreprises}}"></Finance>
        </div>
    </div>
</x-app-layout>