<x-app-layout>


    <div class="py-12 w-full">
        <div class="flex justify-center gap-6 mb-6 w-full">
            <Disponibility :user="{{ Auth::user() }}" :dette="false"></Disponibility>
            <Disponibility :user="{{ Auth::user() }}" :dette="true"></Disponibility>
        </div>
        <div class=" mx-auto sm:px-6 lg:px-8">

            <div class="w-full px-3">
                <ApprovDepartment :user="{{auth()->user()}}"></ApprovDepartment>
            </div>

        </div>
    </div>
    </div>
</x-app-layout>