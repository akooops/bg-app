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
            <div class="w-1/4 z-0 bg-white flex py-10 gap-10 flex-col min-h-screen">
                <x-nav-link :href="route('dashboard')" :path='["/assets/icons/dashboard.svg"]' :active="request()->routeIs('dashboard')">
                    {{ __('Dashboard') }}
                </x-nav-link>
                <x-nav-link href="/entreprise/loans" :path='["/assets/icons/banque.svg"]' :active="request()->routeIs('loans')">
                    {{ __('Banque Locale') }}
                </x-nav-link>
                <x-nav-link href="/leaderboard" :path='["/assets/icons/classement.svg"]' :active="request()->routeIs('leaderboard')">
                    {{ __('Classement') }}
                </x-nav-link>
            </div>
            {{ $slot }}
        </main>
    </div>
</body>

</html>