<x-app-layout>
   
    


    {{-- side-list --}}
<div class="overflow-hidden">

    <div  class="bg-pink-500 float-left w-1/4 h-full absolute ">

     <div class="container pt-5">
         <ul class="relative">
            <li class="relative">
              <a class="flex pistache items-center text-sm py-4 px-6 h-12 overflow-hidden text-gray-700 text-ellipsis whitespace-nowrap rounded hover:text-gray-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" >
                 
                <h2 class="pistache text-2xl ubuntu">Dashboard</h2>
            </a>
            </li>
            <li class="relative">
              <a class="flex items-center text-sm py-4 px-6 h-12 overflow-hidden text-gray-700 text-ellipsis whitespace-nowrap rounded hover:text-gray-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" data-mdb-ripple-color="dark">
                <h2 class="pistache text-2xl ubuntu">Banque</h2>

              </a>
            </li>
            <li class="relative">
              <a class="flex items-center text-sm py-4 px-6 h-12 overflow-hidden text-gray-700 text-ellipsis whitespace-nowrap rounded hover:text-gray-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" data-mdb-ripple-color="dark">
                <h2 class="pistache text-2xl ubuntu">Classement</h2>

              </a>
            </li>
          </ul>


          <getdate v-bind:user="{{Auth()->user()}}"></getdate>

          

          

        </div>



    </div>

    



    {{-- departements --}}

<div class="float-right container mx-auto  w-3/4 bg-gray-500 h-full " style="background-color: rgba(178, 208, 107, 0.04);">


    <simulationtime v-bind:user="{{Auth()->user()}}"></simulationtime>



  <div class="container mx-auto grid grid-cols-6  ">
        <div class="w-4/5 mx-auto p-5 text-center bg-white rounded-xl m-6 col-span-2">
           
             <img  class="mx-auto" src="/images/production.png" alt="">
             <h2 class="mt-3 p-3 ubuntu text-2xl" style="color: #0B3434; ">Production</h2>
             <button class=" rounded-3xl ubuntu p-3 btn-pistache mx-auto " >Acceder</button> 
            
        </div>
        <div class="w-4/5 mx-auto p-5 text-center bg-white rounded-xl m-6 col-span-2">
           
            <img  class="mx-auto" src="/images/approv.png" alt="">
            <h2 class="mt-3 p-3 ubuntu text-2xl" style="color: #0B3434; ">Approvisement</h2>
            <button class=" rounded-3xl ubuntu p-3 btn-pistache mx-auto " >Acceder</button> 
           
       </div>
       <div class="w-4/5 mx-auto p-5 text-center bg-white rounded-xl m-6 col-span-2">
           
        <img  class="mx-auto" src="/images/marketing.png" alt="">
        <h2 class="mt-3 p-3 ubuntu text-2xl" style="color: #0B3434; ">Marketing</h2>
        <button class=" rounded-3xl ubuntu p-3 btn-pistache mx-auto " >Acceder</button> 
       
   </div>
   <div class="w-3/5 ml-auto p-5 text-center bg-white rounded-xl m-8 col-span-3">
           
    <img  class="mx-auto" src="/images/finance.png" alt="">
    <h2 class="mt-3 p-3 ubuntu text-2xl" style="color: #0B3434; ">Finance</h2>
    <button class=" rounded-3xl ubuntu p-3 btn-pistache mx-auto " >Acceder</button> 
   
  </div>
  <div class="w-3/5 mr-auto p-5 text-center bg-white rounded-xl m-8 col-span-3">
           
    <img  class="mx-auto" src="/images/rh.png" alt="">
    <h2 class="mt-3 p-3 ubuntu text-2xl" style="color: #0B3434; ">Humain Ressource</h2>
    <button class=" rounded-3xl ubuntu p-3 btn-pistache mx-auto " >Acceder</button> 
   
  </div>
   
        
    </div>
</div>


</div>

    {{-- <div class= "container h-full">
        
        <div class="w-1/4 h-full  shadow-md bg-white px-1 relative">
            <ul class="relative">
              <li class="relative">
                <a class="flex items-center text-sm py-4 px-6 h-12 overflow-hidden text-gray-700 text-ellipsis whitespace-nowrap rounded hover:text-gray-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" data-mdb-ripple-color="dark">Sidenav link 1</a>
              </li>
              <li class="relative">
                <a class="flex items-center text-sm py-4 px-6 h-12 overflow-hidden text-gray-700 text-ellipsis whitespace-nowrap rounded hover:text-gray-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" data-mdb-ripple-color="dark">Sidenav link 2</a>
              </li>
              <li class="relative">
                <a class="flex items-center text-sm py-4 px-6 h-12 overflow-hidden text-gray-700 text-ellipsis whitespace-nowrap rounded hover:text-gray-900 hover:bg-gray-100 transition duration-300 ease-in-out" href="#!" data-mdb-ripple="true" data-mdb-ripple-color="dark">Sidenav link 2</a>
              </li>
            </ul>
          </div>
             <div class="w-3/4  flex " style="background: #E5E5E5;">
                
                @foreach ($departments as $dpt)
                    <DepartmentCard name="{{ $dpt->name }}" icon="{{ $dpt->icon }}"></DepartmentCard>
                @endforeach

            </div>
      
        
    </div> --}}
{{-- 
    <div class="py-12">
        <div class=" mx-auto sm:px-6 lg:px-8">
            <div class="flex justify-center items-center sm:rounded-lg">


            </div>

        </div>
        <div class="w-1/3 ml-8 my-2 max-w-sm overflow-hidden rounded border bg-white shadow ">
            <div class="flex h-32 justify-center items-center">
                <i class="fas fa-3x fa-university text-blue-500 text-6xl"></i>
            </div>
            <div class="p-3 text-center">
                <h3 class=" text-lg font-extrabold mb-4 truncate-2nd">
                    <a class="hover:text-blue-500" href="">Banque locale</a>
                </h3>
                <a href="/entreprise/loans" class="bg-green-400 text-white px-3 py-1 rounded text-center"> S'endetter </a>
            </div>
        </div>

    </div> --}}


    
</x-app-layout>
