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
        <div class="w-1/3 ml-8 my-2 max-w-sm overflow-hidden rounded border bg-white shadow">
		<div class="flex h-32 justify-center items-center">
			<i class="fas fa-3x fa-university text-blue-500 text-6xl"></i>
		</div>
		<div class="p-3 text-center">
			<h3 class=" text-lg font-extrabold mb-4 truncate-2nd">
				<a class="hover:text-blue-500" href="">Banque de développement local</a>
			</h3>
			<a href="/entreprise/loans"
			class = "bg-green-400 text-white px-3 py-1 rounded text-center"> S'endetter </a>
		</div>
        </div>
      
    </div>
</x-app-layout>
