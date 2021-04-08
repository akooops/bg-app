<template>
    <div>
        <div v-if="mounted">
            <p v-if="message!=''" class="text-green-600 font-bold">{{message}}</p>
            <p v-if="loans.length==0">Il n'y a pas de demandes pour l'instant</p>
            <table v-else class="border-collapse w-full">
                <thead>
                    <tr>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Entreprise</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Capacité d'endettement</th>
                         <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Taux d'interet</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Montant</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Jour de creation</th>
                         <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Statut</th>
                          <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(loan,key) in loans" v-bind:key="key" class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0">
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.name}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.debt_ratio}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            <input type="text" placeholder="En % ex:1 " v-model="loans[key].ratio"/>
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            <input type="text" v-model="loans[key].amount"/>
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{loan.creation_date}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            <select v-model="loans[key].status">
                                <option value="pending">En Attente</option>
                                <option value="accepted">Accepté</option>
                                <option value="rejected">Refusé</option>
                            </select>
                        </td>
                         <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            <button  class="bg-green-400 hover:bg-green-800  text-white py-2 px-4 rounded"  @click="updateLoan(loan,key)">Envoyer</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div v-else>Veillez attendre svp ... </div>
    </div>
</template>

<script>
export default {
 name:"LoanListing",
 data(){
    return{
        loans : [],
        mounted:false,
        message:'',
    }
 },
 methods:{
    getLoans(){
    axios.get('/api/loan/get').then(response =>{
       this.loans = response.data
       this.mounted = true
    })
    .catch(function (error) {
        
    });
    },
    updateLoan(loan,key){
    axios.post('/api/loan/update',this.loans[key]).then(response =>{
       this.message = response.data
       this.getLoans()
       this.$forceUpdate()
    })
    .catch(function (error) {
        
    });
    }
 },
 mounted(){
    this.getLoans()

    window.Echo.channel("banker_channel")
    .listen('LoanCreated', (e) => {
        this.loans.unshift(e.loan)
    })
 }
}
</script>

<style>

</style>