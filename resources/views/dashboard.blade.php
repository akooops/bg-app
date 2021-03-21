<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Business Game - Tableau de Bord') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class=" mx-auto sm:px-6 lg:px-8">
            <div class="flex flex-wrap  overflow-hidden  sm:rounded-lg">
               
                    @foreach($departments as $dpt)
                    <DepartmentCard name = "{{$dpt->name}}" icon = "{{$dpt->icon}}"></DepartmentCard>
                    @endforeach
                
            </div>
        </div>
    </div>
</x-app-layout>
