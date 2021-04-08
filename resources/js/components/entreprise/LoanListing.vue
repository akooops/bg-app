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
    <Modal v-if="pay_loan_modal" class="align-center" custom_css="w-1/3">
	<template v-slot:content>
		<h3 class="text-2xl font-bold mb-4">Remboursement de dettes</h3>
		<p v-if="pay_message!=''" class="text-green-500" >{{pay_message}}</p>
		<p v-if="pay_error_message!=''" class="text-red-600">{{pay_error_message}}</p>
        <p  class="mt-1">Le montant restant est <span class="text-yellow-600">{{selected_loan.remaining_amount}}</span></p>
		<div class="relative h-10 input-component mb-5">
			<label for="refund_amount" class=" left-2 transition-all bg-white px-1">
				Montant à rembourser
			</label>
			<input
				id="refund_amount"
				type="number"
				name="refund_amount"
				v-model="refund_amount"
				class="h-full w-full rounded-sm"
                :max="selected_loan.remaining_amount"
                :min="0"
			/>
			
		</div>
		<div class="mt-12">
			<p>Le montant restant après le paiement de <span class="text-green-600">{{refund_amount}}</span> est {{selected_loan.remaining_amount-refund_amount}}</p>
		</div>
		<div class="flex">
		<button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="payLoan">Payer</button>
		<button class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4" @click="closePayModal">Annuler</button>
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
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Taux d'interet</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Payé? </th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Montant restant </th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Action </th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="loan in loans" v-bind:key="loan.loan_id" class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0">
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            Banque locale
                        </td>
                        <td class="w-full lg:w-auto p-3 font-bold text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.amount}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.loan_creation}}
                        </td>
                        <td class="w-full lg:w-auto p-3 font-bold text-center border border-b block lg:table-cell relative lg:static"
                        :class="loan.status=='En attente'?'text-yellow-600':loan.status=='Rejettée'?' text-red-700':'text-green-600'">
                            {{loan.status}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.ratio}} %
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.payment_status==1?'Payé':'Non'}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.remaining_amount}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            <button v-if=" loan.status=='Acceptée/Partiellement acceptée'" @click="openPayModal(loan)" class=" rounded text-white"
                            :class="loan.payment_status==1 ?'bg-gray-600':'bg-green-400 hover:bg-green-800'"
                            :disabled="loan.payment_status==1"
                             >Payer la dette</button>
                            <button v-else @click="openPayModal(loan)" class="bg-gray-600 rounded text-white"
                            :disabled="true"
                             >Payer la dette</button>
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
        pay_loan_modal:false,
        selected_loan:null,
        refund_amount:0,
        pay_error_message:'',
        pay_message:'',
    }
 },
 computed:{

 },
 methods:{
    getLoans(){
    axios.get('/api/loan/get',{
  params: {entreprise_id:this.entreprise.id}}).then(response =>{
       this.loans = response.data
       this.mounted = true
    })
    .catch(function (error) {
        
    });
    },
    openPayModal(loan){
        this.selected_loan = loan
        this.pay_loan_modal = true
    },
    closePayModal(){
         this.selected_loan = null
        this.pay_loan_modal = false
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
            setTimeout(function() {
                window.location.href ='/entreprise/loans'
            }, 4000);
    	})
		}
		else{
			this.error_message = "Veuillez remplire tous les champs"
		}
		
	},
    payLoan(){
        if(this.refund_amount>this.selected_loan.remaining_amount || this.refund_amount<=0){
            this.pay_error_message = 'Le montant à rembourser doit etre superieur à 0 et inferieur aux dettes restantes'
        }
        else{
            axios.post('/api/loan/pay',{loan_id:this.selected_loan.loan_id,refund_amount:this.refund_amount,entreprise_id:this.entreprise.id}).then((resp)=>{
            this.message = resp.data.pay_messsage
            setTimeout(function() {
                window.location.href ='/entreprise/dashboard'
            }, 4000);
        })
        }
        
    },
 },
 mounted(){
   this.getLoans()
    window.Echo.channel("entreprise_"+this.entreprise.id)
    .listen('NewNotification', (e) => {
        if(e.notification.type=='LoanStatusChanged'){
            this.getLoans()
        }
    })
 }
}
</script>

<style>

</style>