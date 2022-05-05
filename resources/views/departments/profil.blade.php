<x-app-layout>

    <div class="py-12 w-full">
        <div class="max-w-[1400px] mx-auto lg:px-12">
            <Profil v-bind:user="{{auth()->user()}}"></Profil>
        </div>
    </div>
</x-app-layout>