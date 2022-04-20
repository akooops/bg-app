<x-app-layout>
    <div class="mx-auto px-8 py-10">
        <div class="flex flex-wrap sm:rounded-lg">
            <div class="flex justify-center gap-6 mb-6 w-full">
                <Disponibility :user="{{ Auth::user() }}" :dette="false"></Disponibility>
                <Disponibility :user="{{ Auth::user() }}" :dette="true"></Disponibility>
            </div>
            <div class="w-full px-2 h-full">
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

</x-app-layout>
