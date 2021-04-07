<template>
  <p>Jour n° <span class="font-bold">{{time}}</span> </p>
</template>

<script>
export default {
name:'SimulationTime',
data(){
    return{
        time:null,
    }
},
methods:{
    getSimulationDate(){
        axios.get("/api/time").then(resp=>{
            this.time = resp.data
        })
    }
},
mounted(){
    this.getSimulationDate()
    window.Echo.channel("simulation_date")
    .listen('SimulationDateChanged', (e) => {
        this.time = e.date;
    })
}
}
</script>

<style>

</style>