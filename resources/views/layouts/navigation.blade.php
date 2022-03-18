<nav x-data="{ open: false }" class="bg-white border-b border-gray-100 z-10">
    <!-- Primary Navigation Menu -->
    <div class="w-full mx-auto px-8 shadow-lg">
        <div class="flex justify-between py-4">
            <!-- Logo -->
            <x-logo />
            <!-- Settings Dropdown -->
            <div class="hidden sm:flex sm:items-center sm:ml-6">
                <simulationtime class="mr-12" v-bind:user="{{Auth()->user()}}"></simulationtime>
            </div>
        </div>
    </div>
</nav>