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
         <modal v-if="workshop_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Formation employés</h3>
		        <p v-if="message!=''" class="text-green-500" >{{message}}</p>
		        <p v-if="error_message!=''" class="text-red-600">{{error_message}}</p>
                <p> Etes vous sur de vouloir former l'ensemble de vos employés?</p>
                <p class="mt-6">Le prix de la formation est fixé a : <span class="text-green-700 font-bold">{{workshop_price}} /personne</span></p>
                <p class="mt-4">Le prix total est fixé à: <span class="text-green-700 font-bold">{{workshop_price*indicators['nb_workers']['value']}} </span></p>
                <div class="flex">
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="launchWorkshop">Lancer la formation</button>
                <button class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4" @click="closeWorkShopModal">Annuler</button>
		        </div>
            </template>
        </modal>
        <modal v-if="prime_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Prime pour les employés</h3>
		        <p v-if="message!=''" class="text-green-500" >{{message}}</p>
		        <p v-if="error_message!=''" class="text-red-600">{{error_message}}</p>
                <div class="relative h-10 input-component mb-3">
                    <label for="prime" class=" left-2 transition-all bg-white px-1">
                        Entrez le montant de la prime
                    </label>
                    <input
                        id="prime"
                        type="number"
                        name="prime"
                        v-model="prime"
                        :min="0"
                        class="h-full w-full rounded-sm"
                    />
                </div>
                <p class="mt-10">Le montant total est  : <span class="text-yellow-600 font-bold">{{prime*indicators['nb_workers']['value']}}</span></p>
                <p class="mt-10">L'humeur des employés augmentera avec  : <span class="text-green-600 font-bold">+{{expected_mood}}</span></p>
                <div class="flex">
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="primeWorkers">Recruter</button>
                <button class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4" @click="closePrimeModal">Annuler</button>
		        </div>
            </template>
        </modal>
      
        <!-- Adding some details -->
        <div class="flex">
            <StatCard class="mr-5 h-72" v-for="(key,id) in stat_indicators" v-bind:key="id" :title="indicators[key].name" color="text-green-500"  :icon="icons[id]" :value="indicators[key].value"></StatCard>
            <div class="h-72 w-72 shadow-md rounded-lg text-center mr-5">
                <speedo-meter  :data="[{value:indicators['workers_mood'].value,name:''}]" class=" "></speedo-meter>
                <p class="">Humeur des employés</p>
            </div>
            <div class="h-72 w-72 shadow-md rounded-lg text-center">
                <speedo-meter :data="[{value:indicators['productivity_coeff'].value,name:''}]" class=" "></speedo-meter>
                <p class="">Productivité</p>
            </div>
        </div>
        <h3 class="mt-10 font-bold text-md ">Actions:</h3>
        <div class="mt-6 flex">
            <button @click="openWorkersModal" class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded mr-5">Recruter des employés</button>
             <button @click="openWorkShopModal" class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded mr-5">Former les employés</button>
             <button @click="openPrimeModal" class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded mr-5">Ajouter une prime aux employés</button>
        </div>
    </div>
</template>

<script>
import SpeedoMeter from './ui/SpeedoMeter.vue'
import StatCard from './ui/StatCard.vue'
import modal from '../Modal.vue'
export default {
props:['entreprise','salary','workshop_price','caisse'],
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
        stat_indicators:["nb_workers"],
        icons:['fa-users'],
        workers_modal:false,
        workers:0,
        message:'',
        error_message:'',
        amount:0,
        workshop_modal:false,
        prime_modal:false,
        prime:null,
        }
},
computed:{
    expected_mood(){
        let result  = (this.prime*0.01/100)
        if(this.indicators['workers_mood'].value+result>1){
            this.error_message = "Vous allez perdre de l'argent car l'humeur des employés ne pourra pas dépasser 1"
            return 1-this.indicators['workers_mood'].value
        }
        this.error_message = ''
        return parseFloat(result).toFixed(2)
    }
},
methods:{
    openWorkersModal(){
        this.workers_modal = true
        },
    closeWorkersModal(){
        this.workers_modal = false
    },
    openWorkShopModal(){
        this.workshop_modal = true
        },
    closeWorkShopModal(){
        this.workshop_modal = false
    },
     openPrimeModal(){
        this.prime_modal = true
    },
    closePrimeModal(){
        this.prime_modal = false
    },
    
    launchWorkshop(){
        if(this.workshop_price*this.indicators['nb_workers']['value']>this.caisse){
            this.error_message = 'Vos disponibilités ne vous permettent pas de lancer la formation'
            return ''
        }
        if(this.indicators['productivit_coeff'].value+0.25>1){
            this.error_message = "Vous allez perdre de l'argent car le coefficient de productivité a atteint son maximum"
            return ''
        }
        axios.post('/api/entreprise/hr/launch-workshop',{entreprise_id:this.entreprise.id}).then((resp)=>{
            this.message = resp.data
             setTimeout(function() {
                  window.location.href ='/entreprise/department/Ressources Humaines'
                }, 4000);
        })
    },
    primeWorkers(){
          if(this.prime*this.indicators['nb_workers']['value']>this.caisse){
            this.error_message = 'Vos disponibilités ne vous permettent pas de donner cette prime'
            return ''
        }
        axios.post('/api/entreprise/hr/prime-workers',{entreprise_id:this.entreprise.id,prime:this.prime,mood:this.expected_mood}).then((resp)=>{
            this.message = resp.data
             setTimeout(function() {
                  window.location.href ='/entreprise/department/Ressources Humaines'
                }, 3000);
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
            this.error_message="Le nombre d'employés à recruter doit être supérieur à 0 et inférieur à 5"
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
 window.Echo.channel("entreprise_"+this.entreprise.id)
    .listen('NavbarDataChanged', (e) => {
        this.caisse = e.caisse
    })
}
}
</script>

<style>

</style>