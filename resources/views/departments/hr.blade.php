<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Département Ressources humaines') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <Humanressource 
                        v-bind:user="{{ auth()->user() }}" 
                        v-bind:salary_lv1="{{ $salary_lv1 }}"
                        v-bind:salary_lv2="{{ $salary_lv2 }}"
                        v-bind:workshop_price="{{ $workshop_price }}" 
                        v-bind:bonus_coeff="{{ $bonus_coeff }}" 
                        v-bind:caisse="{{ $caisse }}"
                    >
                    </Humanressource>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
