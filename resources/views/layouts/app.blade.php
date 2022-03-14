<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'Laravel') }}</title>

        <!-- Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap">

        <!-- Styles -->
        <link rel="stylesheet" href="{{ asset('css/app.css') }}">
        <link rel="stylesheet" href="{{ asset('css/all.css') }}">
        <link rel="stylesheet" href="/css/moncss.css">

        <!-- Scripts -->
        <script src="{{ mix('js/app.js') }}" defer></script>
        <script src="{{ asset('js/fontawesome.min.js') }}" defer></script>
       <!-- <script src="https://kit.fontawesome.com/97bf32ee89.js" crossorigin="anonymous"></script>-->
    </head>
    <body class="font-sans antialiased">
        <div id="app" class="min-h-screen bg-gray-100">
            @include('layouts.navigation')

          
            <!-- Page Content -->
            <main>
            <notification v-bind:user="{{auth()->user()}}"></notification>
            <div class="overflow-hidden">
                <div  class="bg-gray-100 float-left w-1/5 h-full absolute grid grid-cols-1 content-evenly">

                    <div class="container relative pt-5 ">
                        <ul class="relative">
                           <li class=" my-3">
                             <a class="flex pistache gap-7 justify-center p-6 mx-auto items-center text-sm py-4 px-6 h-12 overflow-hidden  text-ellipsis whitespace-nowrap rounded hover:text-green-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" data-mdb-ripple-color="dark"  >
                               <h2 class=" text-3xl ubuntu">Dashboard</h2>
                               <font-awesome-icon icon="fa-solid fa-chart-line" class="w-7 h-7" />
                               
                           </a>
                           </li>
                           <li class="my-5">
                             <a class="flex justify-center gap-7 mx-auto pistache items-center text-sm py-4 px-6 h-12 overflow-hidden text-gray-700 text-ellipsis whitespace-nowrap rounded hover:text-green-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" data-mdb-ripple-color="dark">
                               
                               <h2 class=" text-3xl ubuntu">Banque</h2>
                               <font-awesome-icon icon="fa-solid fa-building-columns" class="h-7 w-7"/>
                               
               
                             </a>
                           </li>
                           <li class="my-3">
                             <a class="flex justify-center gap-7 mx-auto pistache items-center text-sm py-4 px-6 h-12 overflow-hidden text-gray-700 text-ellipsis whitespace-nowrap rounded hover:text-green-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" data-mdb-ripple-color="dark">
                               <h2 class=" text-3xl ubuntu">Classement</h2>
               
                             </a>
                           </li>
                         </ul>
                         
                    
               
                       </div>
               
               
                       <div class="container flex mx-auto relative justify-center ">
                         <getdate v-bind:user="{{Auth()->user()}}" ></getdate>
                       </div>
               
                   </div>

                   <div class="float-right container mx-auto  w-4/5 bg-gray-500 h-full " style="background-color: rgba(178, 208, 107, 0.04);">
                    {{ $slot }}
                </div>
            </div>


                

            </main>
        </div>
    </body>
</html>
