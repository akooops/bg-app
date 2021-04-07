<template>
  
</template>

<script>
export default {
props:['entreprise'],
name:'HumanRessource',
data(){
    return{
        indicators:[],
        mounted: false,
    }
},
methods:{
getIndiators(){
    axios.get('/api/hr/indicators',{entreprise_id:this.entreprise.id}).then((resp)=>{
        this.indicators = resp.data
        this.mounted = true
    })
}
},
mounted(){
this.getIndiators
}
}
</script>

<style>

</style>