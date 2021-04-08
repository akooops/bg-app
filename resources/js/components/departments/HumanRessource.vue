<template>
    <div>
        <modal v-if="workers_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Recrutement employés</h3>
		        <p v-if="message!=''" class="text-green-500" >{{message}}</p>
		        <p v-if="error_message!=''" class="text-red-600">{{error_message}}</p>
                <div class="relative h-10 input-component mb-3">
                    <label for="workers" class=" left-2 transition-all bg-white px-1">
                        Entrez le nombre d'employés à recruter
                    </label>
                    <input
                        id="workers"
                        type="number"
                        name="workers"
                        v-model="workers"
                        class="h-full w-full rounded-sm"
                    />
                </div>
                <p class="mt-10">Le salaire mensuel d'un seul employé est fixé a : <span class="text-yellow-600 font-bold">{{salary}}</span></p>
                <p>Le salaire pour le nombre d'employé choisis est fixé a : <span class="text-green-700 font-bold">{{salary*workers}}</span></p>
                <div class="flex">
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="hireWorker">Recruter</button>
                <button class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4" @click="closeWorkersModal">Annuler</button>
		        </div>
            </template>
        </modal>
        <speedo-meter :data="temp"></speedo-meter>
        <!-- Adding some details -->
        <div class="flex">
            <StatCard class="mr-3" v-for="(key,id) in stat_indicators" v-bind:key="id" :title="indicators[key].name" color="text-green-500"  :icon="icons[id]" :value="indicators[key].value"></StatCard>
        </div>
        <div class="mt-6">
            <button @click="openWorkersModal" class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded">Recruter des employés</button>
        </div>
    </div>
</template>

<script>
import SpeedoMeter from './ui/SpeedoMeter.vue'
import StatCard from './ui/StatCard.vue'
import modal from '../Modal.vue'
export default {
props:['entreprise'],
components:{
    SpeedoMeter,
    StatCard,
    modal
},
name:'HumanRessource',
data(){
    return{
        indicators:[],
        mounted: false,
        temp:[{
            value: 0.7,
            name: 'HR'
        }],
        stat_indicators:["nb_workers"],
        icons:['fa-users'],
        workers_modal:false,
        workers:0,
        message:'',
        error_message:'',
        salary:10000,
        amount:0,
        }
},
methods:{
    openWorkersModal(){
        this.workers_modal = true
        },
    closeWorkersModal(){
        this.workers_modal = false
    },
    hireWorker(){
        axios.post('/api/entreprise/hr/launch-workshop',{workers:workers,entreprise_id:this.entreprise.id}).then((resp)=>{
            this.message = resp.data
        })
    },
    hireWorker(){
        if(this.workers>1 && this.workers<5){
            axios.post('/api/entreprise/hr/hire',{workers:this.workers,entreprise_id:this.entreprise.id}).then((resp)=>{
            this.message = resp.data.message
             setTimeout(function() {
                  window.location.href ='/entreprise/department/Ressources Humaines'
                }, 4000);
        })
        }
        else{
            this.error_message="Le nombre d'employés à recruter doit etre superieur à 0 et inferieur à 5"
        }
        
    },
    getIndiators(){
        axios.get('/api/entreprise/hr/indicators',{params:{entreprise_id:this.entreprise.id}}).then((resp)=>{
            this.indicators = resp.data
            this.mounted = true
        })
    }
},
mounted(){
this.getIndiators()
}
}
</script>

<style>

</style>