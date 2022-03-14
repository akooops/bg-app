<template>
    <div class="container mx-auto grid grid-cols-2 m-3">

   
    <div class="col-span-1 w-3/5 ml-auto bg-white rounded-lg m-3 shadow-xl">
       <div class="flex m-4 gap-5">
           <img class="w-7 h-7" src="/images/dispo.png" alt="dispo">
           <span class="ubuntu self-end text-2xl font-semibold text-gray-500">Disponibilite</span>
       </div>

       <div class="flex flex-wrap m-4 justify-around">
           <div class="">
            <h2 class="ubuntu vert text-xl font-semibold">{{caisse}}</h2>
            <h2 class="ubuntu font-semibold text-yellow-500">+235642</h2>
           </div>
           <div class="self-start">
              <img class="w-17 h-12" src="/images/disp.png" alt="">
           </div>

       </div>
       
    </div>


    <div class="col-span-1 w-3/5 mr-auto bg-white rounded-lg m-3 shadow-xl">
        <div class="flex m-4 gap-5">
            <img class="w-7 h-7" src="/images/dette.png" alt="dispo">
            <span class="ubuntu self-end text-2xl font-semibold text-gray-500">Dettes</span>
        </div>
 
        <div class="flex flex-wrap m-4 justify-around">
            <div>
             <h2 class="ubuntu vert text-xl font-semibold">{{dettes}}</h2>
             <h2 class="ubuntu font-semibold pistache">-642</h2>
            </div>
            <div class="self-start">
               <img class="w-17 h-12" src="/images/dettes.png" alt="">
            </div>
 
        </div>
        
     </div>

</div>
</template>

<script>
export default {
    name: "SimulationTime",
    props: ["user"],
    data() {
        return {
            time: null,
            show_menu: false,
            caisse: "",
            dettes: "",
        };
    },
    methods: {
        getSimulationData() {
            axios
                .get("/api/navbar", {
                    params: {
                        entreprise_id: this.user.id,
                        type: this.user.type,
                    },
                })
                .then((resp) => {
                    this.time = resp.data["time"];
                    this.caisse = resp.data["caisse"];
                    this.dettes = resp.data["dettes"];
                });
        },
    },
    mounted() {
        this.getSimulationData();
        window.Echo.channel("simulation_date").listen(
            "SimulationDateChanged",
            (e) => {
                this.time = e.date;
            }
        );
        if (this.user.type == "entreprise") {
            window.Echo.channel("entreprise_" + this.user.id).listen(
                "NavbarDataChanged",
                (e) => {
                    this.caisse = e.caisse;
                    this.dettes = e.dettes;
                }
            );
        }
    },
};
</script>

<style>
</style>
