<nav x-data="{ open: false }" class="bg-white border-b border-gray-100">
    <!-- Primary Navigation Menu -->
    <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div class="flex h-16">
        



  <div class="flex ml-auto">
     <div class=" p-4" style="color: #0B3434">
       
          <svg xmlns="http://www.w3.org/2000/svg" class="h-9 w-9" viewBox="0 0 20 20" fill="currentColor">
            <path d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z" />
          </svg>
     </div>
   {{-- nom de l'entreprise --}}
     <div class="p-5 text-2xl font-bold" style="color: #0B3434">
        {{auth()->user()->name}}
     </div>
     
     <button class="ml-4"><img  class="bg-vert rounded-full h-12 w-12" src="/images/iec.png" alt=""></button>

  </div>


                <!-- Navigation Links -->
                {{-- <div class="hidden space-x-8 sm:-my-px sm:ml-10 sm:flex">
                    <x-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')">
                        {{ __('Dashboard') }}
                    </x-nav-link>
                </div>
                 <div class="hidden space-x-8 sm:-my-px sm:ml-10 sm:flex">
                    <x-nav-link href="/leaderboard" :active="request()->routeIs('leaderboard')">
                        {{ __('Classement') }}
                    </x-nav-link>
                </div>
            </div> --}}

            <!-- Settings Dropdown -->

            {{-- <div class="hidden sm:flex sm:items-center sm:ml-6">
            <simulationtime class="mr-12" v-bind:user="{{Auth()->user()}}"></simulationtime>
                
            </div> --}}

            <!-- Hamburger -->
     


        </div>
    </div>

    <!-- Responsive Navigation Menu -->
  
</nav>
