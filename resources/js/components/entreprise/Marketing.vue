<template>
    <div>
        <Modal v-if="ad_modal" class="align-center" custom_css="w-1/3">
	<template v-slot:content>
		<h3 class="text-2xl font-bold mb-4">Nouvelle compagne</h3>
		<p v-if="message!=''" class="text-green-500" >{{message}}</p>
		<p v-if="error_message!=''" class="text-red-600">{{error_message}}</p>
		<div class="relative h-10 input-component mb-5">
			<label for="amount" class=" left-2 transition-all bg-white px-1">
				Montant 
			</label>
			<input
				id="amount"
				type="text"
				name="amount"
				v-model="amount"
				class="h-full w-full rounded-sm"
			/>
			
		</div>
		<div class="mt-12">
            <label>Type</label>
			<select v-model="type">
                <option value="social">Réseaux sociaux</option>
                <option value="tv">Télé</option>
                <option value="sponsoring">Sponsoring</option>
            </select>
		</div>
        <p>Le résultat prévisionnel : <span class="text-green-600">+230 abonnées</span> </p>
		<div class="flex">
		<button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="createAd">Créer</button>
		<button class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4" @click="closeModal">Annuler</button>
		</div>
	</template>
	</Modal>
        <div v-if="mounted">
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 bg-white overflow-hidden sm:rounded-lg p-6 bg-white ">
            <div v-if="ads.length==0" class="text-center">
                <p>Il semble que vous n'aviez pas encore créer votre première compagne publicitaire</p>
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="openModal">Créer ma première compagne publicitaire</button>
            </div>
            <div v-else>
                <div class="text-right mb-2">
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded text-right"  @click="openModal">Créer une nouvelle compagne publicitaire</button>
                </div>
            <table  class="border-collapse w-full">
                <thead>
                    <tr>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Banque</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Montant/ Montant accepté</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Date de creation</th>
                         <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Statut</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="ad in ads" v-bind:key="ad.ad_id" class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0">
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            Banque Sponsor 
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{ad.amount}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{ad.ad_creation}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{ad.type}}
                        </td>
                    </tr>
                </tbody>
            </table>
            </div>
        </div>
        </div>
        </div>
        <div v-else>Veuillez attendre svp ... </div>
    </div>
</template>

<script>
import Modal from '../Modal.vue'

export default {
 props:['entreprise'],
 components:{ Modal },
 name:"Marketing",
 data(){
    return{
        ads : [],
        mounted:false,
        ad_modal:false,
        amount:null,
        message:'',
        error_message:'',
        accept: false,
    }
 },
 methods:{
    getAds(){
    axios.get('/api/marketing/get',{
  params: {entreprise_id:this.entreprise.id}}).then(response =>{
       this.ads = response.data
       this.mounted = true
    })
    .catch(function (error) {
        
    });
    },
    openModal(){
		this.ad_modal = true
	},
	closeModal(){
		this.message = ''
		this.errr_messsage=''
		this.ad_modal = false
	},
	checkboxChanged(){
		this.accept = !this.accept
	},
	createAd(){
		if(this.amount!=null && this.accept){
			axios.post("/api/ad/create",{entreprise_id:this.entreprise.id,amount:this.amount}).then(resp=>{
			this.message = resp.data
            this.ads.unshift({
                amount : this.amount,
                ad_creation: new Date().toLocaleString(),
                status : "pending"
            })
    	})
		}
		else{
			this.error_message = "Veuillez remplire tous les champs"
		}
		
	}
 },
 mounted(){
   this.getAds()
    /*
    window.Echo.channel("entreprise_"+this.entreprise.id)
    .listen('NewNotification', (e) => {
        if(e.notification.type=='AdStatusChanged'){
            let index = this.ads.findIndex(ad => ad.ad_id == e.notification.data.id)
            this.ads[index].amount = e.notification.data.amount
            this.ads[index].status = e.notification.data.status
            this.$forceUpdate()
            //this.ads.unshift(e.notification.data)
        }
    })
    */
 }
}
</script>

<style>

</style>