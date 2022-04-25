<x-guest-layout>
    <x-auth-card>
        <x-slot name="logo" w='full'>
            <x-logo />
        </x-slot>

        <!-- Session Status -->
        <x-auth-session-status class="mb-4" :status="session('status')" />

        <!-- Validation Errors -->
        <x-auth-validation-errors class="mb-4" :errors="$errors" />

        <form method="POST" action="{{ route('login') }}">
            @csrf

            <h1 class='font-serif text-4xl welcome-text'>
                Welcome
            </h1>
            <p class='mb-10'>
                Login below to access your account.
            </p>
            <!-- Email Address -->
            <div>
                <x-label for="email" :value="__('Email')" />

                <x-input id="email" class="block mt-1 w-full px-3 py-1" placeholder="username@bg.iec" type="email" name="email" :value="old('email')" required autofocus />
            </div>

            <!-- Password -->
            <div class="mt-4 relative">
                <x-label for="password" :value="__('Password')" />

                <x-input id="password" class="block mt-1 w-full px-3 py-1" type="password" placeholder='..........' name="password" required autocomplete="current-password" />

                <img id='closed' src='/assets/icons/closedeye.svg' alt='eye' class="absolute right-5 bottom-3" onclick="toggleShow()" />
                <img id='open' src='/assets/icons/openeye.svg' alt='eye' class="hidden absolute right-5 bottom-3" onclick="toggleShow()" />
            </div>

            <!-- Remember Me -->
            <div class="block mt-4">
                <label for="remember_me" class="inline-flex items-center">
                    <input id="remember_me" type="checkbox" class="rounded shadow-sm focus:border-indigo-300 focus:ring focus:ring-green-700 focus:ring-opacity-50" name="remember">
                    <span class="ml-2 text-sm text-gray-600">{{ __('Remember me') }}</span>
                </label>
            </div>

            <div class="flex items-center justify-center mt-4">
                <x-button class="ml-3">
                    {{ __('Login now') }}
                </x-button>
            </div>
        </form>
    </x-auth-card>
</x-guest-layout>
<script>
    var showPassword = false

    function toggleShow(show) {
        showPassword = !showPassword
        const closedIcon = document.getElementById("closed")
        const openIcon = document.getElementById("open")
        password = document.getElementsByName("password");
        if (password[0].type == "text") {
            openIcon.classList.add('hidden')
            closedIcon.classList.remove('hidden')
            password[0].type = "password"
        } else {
            closedIcon.classList.add('hidden')
            openIcon.classList.remove('hidden')
            password[0].type = "text";
        }
        password[0].focus()
    }
</script>