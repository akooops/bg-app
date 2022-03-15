<nav x-data="{ open: false }" class="bg-white border-b border-gray-100">
    <!-- Primary Navigation Menu -->
    <div class="max-w-7xl mx-auto px-8">
        <div class="flex justify-between py-4">
            <!-- Logo -->
            <x-logo />

            <!-- Navigation Links -->
            <!-- <div class="hidden space-x-8 sm:-my-px sm:ml-10 sm:flex">
                    <x-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')">
                        {{ __('Dashboard') }}
                    </x-nav-link>
                </div>
                <div class="hidden space-x-8 sm:-my-px sm:ml-10 sm:flex">
                    <x-nav-link href="/leaderboard" :active="request()->routeIs('leaderboard')">
                        {{ __('Classement') }}
                    </x-nav-link>
                </div> -->

            <!-- Settings Dropdown -->
            <div class="hidden sm:flex sm:items-center sm:ml-6">
                <simulationtime class="mr-12" v-bind:user="{{Auth()->user()}}"></simulationtime>
            </div>

            <!-- Hamburger -->

        </div>
    </div>

    <!-- Responsive Navigation Menu -->

</nav>