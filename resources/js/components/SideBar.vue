<template>
     <nav class="container relative">
                        <ul class="relative">
                           <li :class="location != '/leaderboard' ? 'border-l-3 border-green-800 pistache border-pistache font-semibold' : 'vert-sombre margin-left-transparent hover:text-black'"
                               class=" block content-center">
                               <a class='flex ml-3 p-3 gap-3 focus:outline-none text-lg ' href="/entreprise/dashboard">
                                       
                                       <font-awesome-icon icon="fa-solid fa-chart-line" class="w-7 h-7" />
                                       <h2 class=" text-2xl ubuntu">Dashboard</h2>

                               </a>

                           </li>
                           <li  :class="location == '/banker/dashboard' ? 'border-l-3 border-pistache pistache font-semibold' : 'vert-sombre margin-left-transparent hover:text-black'"
                                class="my-8 block">
                               <a class='flex ml-3 gap-3 p-3 focus:outline-none text-lg'>
                                       
                                       <font-awesome-icon icon="fa-solid fa-building-columns" class="w-7 h-7" />
                                       <h2 class=" text-2xl ubuntu">Banque Locale</h2>

                               </a>

                           </li>
                           <li  :class="location == '/leaderboard' ? 'border-l-3 border-pistache pistache font-semibold' : 'vert-sombre margin-left-transparent hover:text-black'"
                                class="block">
                                 <a class='flex ml-3 p-3 focus:outline-none text-lg' href="/leaderboard">
                                       <h2 class=" text-2xl ubuntu">Classement</h2>

                               </a>

                           </li>
                         </ul>
                      
         </nav>
</template>


<script type="text/javascript">
export default {
    
   name:"SideBar",
   data() {
       return {
           location: null,
       }
   },
   beforeMount(){
       return this.location = window.location.pathname
   }
  

    
}
</script>