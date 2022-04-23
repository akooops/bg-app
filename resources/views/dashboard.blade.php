<x-app-layout>

    <div class="py-10 flex-grow">
        <div class="flex justify-center gap-6 mb-6">
            <Disponibility :user="{{ Auth::user() }}" :dette="false"></Disponibility>
            <Disponibility :user="{{ Auth::user() }}" :dette="true"></Disponibility>
        </div>
        <div class="p-6 mx-auto">

            <h2 style='text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);' class='mb-12 font-medium font-heading text-vN text-2xl '>
                Département - Tableau de Bord
            </h2>
            <div class="flex flex-col gap-9">
                <div class="flex gap-10 justify-between">
                    <DepartmentCard name="Production"></DepartmentCard>
                    <DepartmentCard name="Approvisionnement"></DepartmentCard>
                    <DepartmentCard name="Marketing"></DepartmentCard>

                </div>
                <div class="flex justify-center gap-10">
                    <DepartmentCard name="Finance"></DepartmentCard>
                    <DepartmentCard name="Ressources Humaines"></DepartmentCard>

                </div>
            </div>
        </div>

    </div>
</x-app-layout>