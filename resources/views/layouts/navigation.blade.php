<nav x-data="{ open: false }" class="bg-white border-b border-gray-100 z-10">
    <!-- Primary Navigation Menu -->
    <div class="w-full mx-auto px-8 shadow-lg">
        <div class="flex justify-between py-4">
            <!-- Logo -->
            <x-logo />
            @if (request()->routeIs('dashboard') || Request::is('entreprise/department/*'))
            <div class="flex flex-row gap-3 justify-center  rounded-3xl px-3 py-2 bg-vert bg-opacity-10" >
                <x-bar-dep name="Production" :active="request()->routeIs('production')" link="{{ route('production') }}"></x-bar-dep>
                <x-bar-dep name="Approvisement" :active="request()->routeIs('approv')" link="{{ route('approv') }}"></x-bar-dep>
                <x-bar-dep name="Marketing" :active="request()->routeIs('marketing')" link="{{ route('marketing') }}"></x-bar-dep>
                <x-bar-dep name="Finance" :active="request()->routeIs('finance')" link="{{ route('finance') }}"></x-bar-dep>
                <x-bar-dep name="Human Resources" :active="request()->routeIs('rh')" link="{{ route('rh') }}"></x-bar-dep>

            </div>
            @endif
            
            <!-- Settings Dropdown -->
            <div class="hidden sm:flex sm:items-center sm:ml-6">
                <simulationtime class="mr-12" v-bind:user="{{Auth()->user()}}"></simulationtime>
            </div>
        </div>
    </div>
</nav>