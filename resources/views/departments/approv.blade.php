<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Commandes') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class=" mx-auto sm:px-6 lg:px-8">

                <div class = "w-full px-3">
                    <ApprovDepartment
                    :user = "{{auth()->user()}}"
                    ></ApprovDepartment>
                </div>

            </div>
        </div>
    </div>
</x-app-layout>
