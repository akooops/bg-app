<template>
    <div>
        <Modal v-if="loan_modal" class="align-center" >
	      <template v-slot:content>
            <div class="flex flex-col text-vN p-4"> 
              <h1 class="font-semibold text-3xl text-center">Demande d'endettement</h1>
              <h2 for="amount" class="font-semibold mt-5 text-xl my-1">Motant à endetter</h2>
              <input type="number" id="amount" name="amount" v-model="amount" class="w-1/2">
              <div class="mt-6 flex items-center">
			    <input type="checkbox" @change="checkboxChanged" :checked="accept" class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded "> 
			    <label class="text-yellow-500 ml-2">Je veillerai, moi le representant de l'entreprise <span class="font-bold">{{entreprise.name}}</span>  à honorer les termes du contrat.</label>
		      </div>

              <div class="flex flex-row mt-9 gap-5 ml-auto">
                      <button class="text-lg font-semibold hover:bg-gray-200 px-4 py-2 rounded-xl" :class="sent ? 'bg-gray-200 ':''" :disabled="sent" @click="createLoan">S'endetter</button>
                      <button class="text-lg font-semibold opacity-80 hover:bg-gray-200 px-4 py-2 rounded-xl" @click="closeModal">Annuler</button>
			
		         </div>

            </div>
 
	</template>
	</Modal>

    <Modal v-if="pay_loan_modal" class="align-center">
	<template v-slot:content>

        <div class="flex flex-col text-vN py-4 px-6">
                <h1 class="font-semibold text-2xl text-vert">Remboursement de detttes</h1>
                <h2  class="mt-3 font-semibold text-xl py-2">Montant restant</h2>
                <p class="text-yellow-600 border-2 border-gray-200 py-2 pl-2 w-max pr-6">{{parseInt(selected_loan.remaining_amount)}} UM</p>
              
			    <label for="refund_amount" class="mt-3 text-xl py-2 font-semibold">
			     	Montant à rembourser
			    </label>
			    <input
				   id="refund_amount"
				   type="number"
				   name="refund_amount"
				   v-model="refund_amount"
				   class="w-full rounded-sm text-vert border-gray-200"
                   :max="selected_loan.remaining_amount"
                   :min="0"
			      />

                  <h2 class="font-semibold mt-3 text-xl py-2">Motant restant après payment</h2>
                  <p class="border-2 border-gray-200 py-2 pl-2 ">{{selected_loan.remaining_amount-refund_amount}} UM</p>


                  <div class="flex flex-row mt-9 gap-2 ml-auto">
                      <button class="text-lg font-semibold hover:bg-gray-200 px-4 py-2 rounded-xl" :class="sent_payment ? 'bg-gray-200 ':''" :disabled="sent_payment" @click="payLoan">Payer</button>
                      <button class="text-lg font-semibold opacity-80 hover:bg-gray-200 px-4 py-2 rounded-xl" @click="closePayModal">Annuler</button>
			
		         </div>
        </div>
        
	</template>
	</Modal>

    <div class="w-full" v-if="mounted">
           <div class="flex flex-row justify-between mt-5 ">
                <h1 class="text-vN font-semibold text-2xl my-auto">Liste des demandes d'endettement :</h1>
            <button v-if="loans.length > 0" class="text-vN rounded-3xl px-5 py-2 font-semibold "  @click="openModal"  style="background: linear-gradient(180deg, rgba(178, 208, 107, 0.09) 0%, rgba(178, 208, 107, 0.33) 100%);">
                    Créer une demande d'endettement
            </button>

           </div>
           
           <div v-if="loans.length==0" class="text-center mt-12">
                <p>Il semble que vous n'aviez pas encore créer votre première demande d'endettement</p>
                <button class="text-vN rounded-3xl px-5 py-2 font-semibold mt-5"  @click="openModal"  style="background: linear-gradient(180deg, rgba(178, 208, 107, 0.09) 0%, rgba(178, 208, 107, 0.33) 100%);">
                   Créer votre premier endettement
                </button>
            </div>


            <div v-else class="mt-4">

                <table class="w-full table-auto bg-white h-96 overflow-y-scroll">
                <thead
                    class="sticky  top-0 border-b bg-white font-semibold text-vN"
                >
                    <tr>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            
                        >
                            Banque
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            
                        >
                           Motant
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            
                        >
                           Date De Création
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            
                        >
                            Taux d'interet
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Délai en Semaines
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Montant restant
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Payé ?
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Statue
                        </th>
                         
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Action
                        </th>
                       
                    </tr>
                </thead>
                <tbody  >
                    <tr
                         v-for="loan in loans" v-bind:key="loan.loan_id"
                        class="bg-white  flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-gray text-vN font-light text-sm h-14"
                    >
                        <td
                            class="p-1 text-center  block lg:table-cell relative lg:static"
                        >
                           Banque locale
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{loan.amount}}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                              {{loan.loan_creation}}
                        </td>
                        
                         <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{loan.ratio ? loan.ratio : "0" }} %
                        </td>
                         <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                             {{loan.deadline ? loan.deadline : 'pas encore'}}
                        </td>
                        
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{parseInt(loan.remaining_amount)}}
                        </td>
                         <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                            :class="loan.payment_status==1 ?'text-green-500' : ''"
                        >
                            {{loan.payment_status==1 ?'Payé':'Non'}}
                        </td>
                         <td
                            class="flex flex-wrap p-1 text-center block lg:table-cell relative lg:static w-12" 
                            :class="loan.status=='En attente' ? 'text-yellow-600' : '' "
                        >
                              {{loan.status}}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static pl-4"
                        >
                            <button v-if=" loan.status=='Acceptée/Partiellement acceptée'" @click="openPayModal(loan)" class=" rounded-3xl font-semibold px-3 py-2 bg-vert"
                            :disabled="loan.payment_status==1"
                            :class="loan.payment_status!=1 ? 'hover:bg-opacity-50' :''" 
                             >{{loan.payment_status==1 ? 'Compte reglé' : 'Payer la dette'}}</button>

                            <button v-else @click="openPayModal(loan)" class="bg-gray-300  font-semibold text-vN rounded-3xl  px-3 py-2 " 
                            :disabled="true"
                             >Payer la dette</button>
                        </td>
                       
                       
                    </tr>
                </tbody>
            </table>

            </div>
        
    </div> 
        <!-- <div v-if="mounted">
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8  overflow-hidden shadow-sm sm:rounded-lg p-6 bg-white border-b border-gray-200">
            <div v-if="loans.length==0" class="text-center">
                <p>Il semble que vous n'aviez pas encore créer votre première demande d'endettement</p>
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"  @click="openModal">Créer ma première demande d'endettement</button>
            </div>
            <div v-else>
                <div class="text-right mb-2">
                <button class="bg-green-400 hover:bg-green-800  text-white px-3 py-2 rounded text-right"  @click="openModal">Créer une nouvelle demande d'endettement</button>
                </div>
                <table class="w-full bg-white h-96 overflow-y-scroll">
                <thead
                    class="sticky  top-0 border-b bg-white font-semibold text-vN"
                >
                    <tr>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('command_id')"
                        >
                            Banque
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('num_items')"
                        >
                           Motant
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('creation_date')"
                        >
                           Date De Création
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('status')"
                        >
                            Taux d'interet
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Délai en Semaines
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Montant restant
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Payé ?
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Statue
                        </th>
                         
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                           
                        >
                           Action
                        </th>
                       
                    </tr>
                </thead>
                <tbody  >
                    <tr
                         v-for="loan in loans" v-bind:key="loan.loan_id"
                        class="bg-white  flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-gray text-vN font-light text-sm h-14"
                    >
                        <td
                            class="p-1 text-center  block lg:table-cell relative lg:static"
                        >
                           Banque locale
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{loan.amount}}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                              {{loan.loan_creation}}
                        </td>
                        
                         <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{loan.ratio}} %
                        </td>
                         <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                             {{loan.deadline}}
                        </td>
                        
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{loan.remaining_amount}}
                        </td>
                         <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{loan.payment_status==1?'Payé':'Non'}}
                        </td>
                         <td
                            class="w-full flex text-wrap lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                              {{loan.status}}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
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
        </div> -->
        <div v-else class="flex flex-col items-center mt-16">
             <img class="w-16 h-16 load" src="/assets/logo/bg_logo.svg" alt="">
        <div class="text-vN pt-2 font-semibold">Veillez attendre svp ... </div>
        </div>
       
    </div>
</template>

<script>
import Modal from '../Modal.vue'

export default {
 props:['entreprise','caisse'],
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
        sent:false,
        sent_payment:false,
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
        this.pay_error_message = ''
        this.pay_message =''
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
             this.sent = true
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
        this.pay_error_message = ''
        this.pay_message =''
        if(this.refund_amount>this.selected_loan.remaining_amount || this.refund_amount<=0){
            this.pay_error_message = 'Le montant à rembourser doit etre superieur à 0 et inferieur aux dettes restantes'
            return ''
        }
        if(this.caisse<this.refund_amount){
            this.pay_error_message = 'Vos disponibilités ne suffisent pas pour rembourser le montant saisi'
            return ''
        }
        else{
            this.sent_payment=true
            axios.post('/api/loan/pay',{loan_id:this.selected_loan.loan_id,refund_amount:this.refund_amount,entreprise_id:this.entreprise.id}).then((resp)=>{
            this.pay_message = resp.data
            setTimeout(function() {
                window.location.href ='/entreprise/loans'
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
    .listen('NavbarDataChanged', (e) => {
        this.caisse = e.caisse
    })
 }
}
</script>

<style>

</style>