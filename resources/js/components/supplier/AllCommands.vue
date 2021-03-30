<template>
    <div>
        <div v-if="mounted">
            <p v-if="commands.length==0">Il n'y a pas de commandes pour l'instant</p>
            <table v-else class="border-collapse w-full">
                <thead>
                    <tr>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Numéro</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Entreprise</th>

                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Nombre d'items</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Date de creation</th>
                         <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Statut</th>
                          <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(cmd,key) in commands" v-bind:key="key" class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0">
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{cmd.id}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{cmd.name}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{cmd.num_items}}                       </td>

                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{cmd.created}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            En Attente
                        </td>
                         <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            <a :href = "'/supplier/command/'+cmd.id" :disabled="commands[key].status!='pending'" class="bg-green-400 hover:bg-green-800  text-white py-2 px-4 rounded"  >Voir</a>
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
        commands : [],
        mounted:false,
    }
 },
 props: ["user"],
 methods:{
    getCommands(){
    axios.get('/api/command/get/all',{params: {
        supplier_id: this.user.id
    }}).then(response =>{
       this.commands = response.data
       this.commands = this.commands.reverse()
       this.mounted = true
    })
    .catch(function (error) {
        
    });
    }
 },
 mounted(){
    this.getCommands()
    console.log(this.commands)
    window.Echo.channel("supplier_" + this.user.id)
    .listen('CommandCreated', (e) => {
        console.log(e)
        this.commands.unshift(e.command)
    })
    
 }
}
</script>