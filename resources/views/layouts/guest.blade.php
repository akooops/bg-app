<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">

    <!-- Styles -->
    <link rel="stylesheet" href="{{ asset('css/all.css') }}">
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">


    <!-- Scripts -->
    <script src="{{ asset('js/app.js') }}" defer></script>
    <style>
        input[type="password"] {
            font-family: Verdana;
        }

        input {
            background-color: #FAEEDE !important
        }

        input[type='checkbox'] {
            background-color: white !important
        }

        input[type='checkbox']:checked {
            background-color: #C59866 !important
        }

        label {
            color: #0B3434 !important;
        }

        /* create animation for three groups of svg with slight delay */
        .group1 {
            animation: fadeIn1 1.5s ease-in;
        }

        .welcome-text {
            text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
        }

        @keyframes fadeIn1 {
            0% {
                opacity: 0;
                top: -50px;
                left: -50px;
            }

            100% {
                opacity: 1;
                top: 0;
                left: 0;
            }
        }

        .group2 {
            animation: fadeIn2 1.5s ease-in;
            animation-delay: 0.2s
        }

        @keyframes fadeIn2 {
            0% {
                opacity: 0;
                top: -50px;
                left: 100px;
            }

            100% {
                opacity: 1;
                top: 0;
                left: 144px;
            }
        }

        .group3 {
            animation: fadeIn3 1.5s ease-in-out;
            animation-delay: 0.2s
        }

        @keyframes fadeIn3 {
            0% {
                opacity: 0;
                bottom: 66px;
                left: -50px;
            }

            100% {
                opacity: 1;
                bottom: 16px;
                left: 0;
            }
        }

        .group4 {
            animation: fadeIn4 1.5s ease-out;
            animation-delay: 0.2s
        }

        @keyframes fadeIn4 {
            0% {
                opacity: 0;
                bottom: -50px;
                left: 242px;
            }

            100% {
                opacity: 1;
                bottom: 0;
                left: 192px;
            }
        }
    </style>
</head>

<body>
    <div class="font-sans text-gray-900  antialiased relative overflow-hidden">
        <div class="group1 absolute w-72">
            <img src='/assets/login/group1.svg' />
        </div>
        <div class="group2 animated-svg absolute left-36 w-64">
            <img src='/assets/login/group2.svg' />
        </div>
        <div class="group3 absolute bottom-4 w-20">
            <img src='/assets/login/group3.svg' />
        </div>
        <div class="group4 absolute bottom-0 left-48 w-40">
            <img src='/assets/login/group4.svg' />
        </div>
        {{ $slot }}
    </div>
</body>

</html>
