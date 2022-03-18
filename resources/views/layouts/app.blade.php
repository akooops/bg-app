<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap">

    <!-- Styles -->
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    <link rel="stylesheet" href="{{ asset('css/all.css') }}">
    <!-- Scripts -->
    <script src="{{ mix('js/app.js') }}" defer></script>
    <script src="{{ asset('js/fontawesome.min.js') }}" defer></script>
    <!-- <script src="https://kit.fontawesome.com/97bf32ee89.js" crossorigin="anonymous"></script>-->
</head>

<body class="font-sans antialiased">
    <div id="app" class="min-h-screen bg-vert bg-opacity-5">
        @include('layouts.navigation')

        <!-- Page Content -->
        <main class='flex'>
            <!-- <notification v-bind:user="{{auth()->user()}}"></notification> -->
            <div class="flex flex-col w-1/4 z-10  bg-white py-10 min-h-screen gap-10">
                <div class=" flex gap-8 flex-col">
                    <x-nav-link :href="route('dashboard')" :path='["/assets/icons/dashboard.svg", "/assets/icons/dashboard_inactive.svg"]' :active="request()->routeIs('dashboard')">
                        {{ __('Dashboard') }}
                    </x-nav-link>
                    <x-nav-link href="/entreprise/loans" :path='["/assets/icons/banque.svg", "/assets/icons/banque_inactive.svg"]' :active="request()->routeIs('loans')">
                        {{ __('Banque Locale') }}
                    </x-nav-link>
                    <x-nav-link href="/leaderboard" :path='["/assets/icons/classement.svg", "/assets/icons/classement_inactive.svg"]' :active="request()->routeIs('leaderboard')">
                        {{ __('Classement') }}
                    </x-nav-link>
                </div>
                <Calendar v-bind:user="{{ Auth()->user() }}"></Calendar>
            </div>
            {{ $slot }}
        </main>
    </div>
</body>

</html>