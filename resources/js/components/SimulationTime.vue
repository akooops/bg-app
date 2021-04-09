<template>
<div class="flex">
    <p class="mr-12">Disponibilités <span class="font-bold">{{caisse}}</span> </p>
    <p class="mr-12">Dettes <span class="font-bold">{{dettes}}</span> </p>
    <p>Jour n° <span class="font-bold">{{time}}</span> </p>
    <div class="flex ml-4" @click="show_menu=!show_menu">
        <p>{{user.name}}</p>
        <div class="ml-1 mt-1">
            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
        </div>
    </div>
    <div
    v-if="show_menu"
    class="origin-top-right absolute z-999 right-0 mr-8 mt-8 w-56 rounded shadow-lg bg-white ring-1 ring-black ring-opacity-5"
    >
    <div
        class="py-1 pl-4"
        role="menu"
        aria-orientation="vertical"
        aria-labelledby="options-menu"
       
    >
    <a href='/logout'>Se déconnecter</a>
    </div>
    </div>
</div>
</template>

<script>
export default {
name:'SimulationTime',
props:['user'],
data(){
    return{
        time:null,
        show_menu:false,
        caisse:'',
        dettes:'',
    }
},
methods:{
    getSimulationData(){
        axios.get("/api/navbar",{params:{entreprise_id:this.user.id,type:this.user.type}}).then(resp=>{
            this.time = resp.data["time"]
            this.caisse = resp.data["caisse"]
            this.dettes = resp.data["dettes"]
        })
    }
},
mounted(){
    this.getSimulationData()
    window.Echo.channel("simulation_date")
    .listen('SimulationDateChanged', (e) => {
        this.time = e.date
    })
    if(this.user.type=="entreprise"){
         window.Echo.channel("entreprise_"+this.user.id)
    .listen('NavbarDataChanged', (e) => {
        console.log(e)
        this.caisse = e.caisse
        this.dettes = e.dettes
    })
    }
   
}
}
</script>

<style>

</style>