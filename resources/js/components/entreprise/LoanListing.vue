<template>
    <div>
        <Modal v-if="loan_modal" class="align-center" custom_css="w-1/3">
	<template v-slot:content>
		<h3 class="text-2xl font-bold mb-4">Demande d'endettement</h3>
		<p v-if="message!=''" class="text-green-500" >{{message}}</p>
		<p v-if="error_message!=''" class="text-red-600">{{error_message}}</p>
		<div class="relative h-10 input-component mb-5">
			<label for="amount" class=" left-2 transition-all bg-white px-1">
				Montant à endetter
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
			<input type="checkbox" @change="checkboxChanged" :checked="accept" class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"> 
			<label>Je veillerai, moi le representant de l'entreprise <span class="font-bold">{{entreprise.name}}</span>  à honorer les termes du contrat.</label>
		</div>
		<div class="flex">
		<button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="createLoan">S'endetter</button>
		<button class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4" @click="closeModal">Annuler</button>
		</div>
	</template>
	</Modal>
        <div v-if="mounted">
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 bg-white border-b border-gray-200">
            <div v-if="loans.length==0" class="text-center">
                <p>Il semble que vous n'aviez pas encore créer votre première demande d'endettement</p>
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="openModal">Créer ma première demande d'endettement</button>
            </div>
            <div v-else>
                <div class="text-right mb-2">
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded text-right"  @click="openModal">Créer une nouvelle demande d'endettement</button>
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
                    <tr v-for="loan in loans" v-bind:key="loan.loan_id" class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0">
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            Banque Sponsor 
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.amount}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.loan_creation}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.status}}
                        </td>
                    </tr>
                </tbody>
            </table>
            </div>
        </div>
        </div>
        </div>
        <div v-else>Veillez attendre svp ... </div>
    </div>
</template>

<script>
import Modal from '../Modal.vue'

export default {
 props:['entreprise'],
 components:{ Modal },
 name:"EntrepriseLoanListing",
 data(){
    return{
        loans : [],
        mounted:false,
        loan_modal:false,
        amount:null,
        message:'',
        error_message:'',
        accept: false,
    }
 },
 methods:{
    getLoans(){
    axios.get('/api/loan/get',{entreprise_id:this.entreprise.id}).then(response =>{
       this.loans = response.data
       this.mounted = true
    })
    .catch(function (error) {
        
    });
    },
    openModal(){
		this.loan_modal = true
	},
	closeModal(){
		this.message = ''
		this.errr_messsage=''
		this.loan_modal = false
	},
	checkboxChanged(){
		this.accept = !this.accept
	},
	createLoan(){
		if(this.amount!=null && this.accept){
			axios.post("/api/loan/create",{entreprise_id:this.entreprise.id,amount:this.amount}).then(resp=>{
			this.message = resp.data
            this.loans.unshift({
                amount : this.amount,
                loan_creation: new Date().toLocaleString(),
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
   this.getLoans()
 }
}
</script>

<style>

</style>