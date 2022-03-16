<x-app-layout>

    <div class="py-10 flex-grow">
        <div class="flex justify-center gap-6">
            <Disponibility :user="{{ Auth::user() }}" :dette="false"></Disponibility>
            <Disponibility :user="{{ Auth::user() }}" :dette="true"></Disponibility>
        </div>
        <div class="p-6 mx-auto">

            <h2 style='text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);' class='mb-12 font-bold text-lg '>
                Département - Tableau de Bord
            </h2>
            <div class="grid grid-rows-2 grid-cols-3 gap-x-6 gap-y-10 justify-between">

                @foreach ($departments as $dpt)
                <DepartmentCard name="{{ $dpt->name }}" icon="{{ $dpt->icon }}"></DepartmentCard>
                @endforeach

            </div>
        </div>

    </div>
</x-app-layout>