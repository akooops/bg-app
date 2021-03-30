<template>
    <div>
        <div v-if="mounted">
            <p v-if="command.length==0">Il n'y a pas de commandes pour l'instant</p>
     <div v-if = "show_success"  class=" my-2 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
      <strong class="font-bold">{{message}}</strong>
    
      <span @click = "show_success = false" class="absolute top-0 bottom-0 right-0 px-4 py-3">
        <svg class="fill-current h-6 w-6 text-green-500" role="button"    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>  Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10    11.819l-2.651 3.029a1.2 1.2 0 1   1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1     1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697    1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
      </span>
    </div>

      <div v-if = "show_error"  class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
      <strong class="font-bold">{{message}}</strong>
    
      <span @click = "show_error = false" class="absolute top-0 bottom-0 right-0 px-4 py-3">
        <svg class="fill-current h-6 w-6 text-red-500" role="button"    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>  Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10    11.819l-2.651 3.029a1.2 1.2 0 1   1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1     1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697    1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
      </span>
    </div>
            <table v-else class="border-collapse w-full">
                <thead>
                    <tr>

                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Matière Première </th>

                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Prix Unitaire</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Quantité</th>
                         <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Prix Total</th>
                          
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(item,key) in command" v-bind:key="key" class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0">
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{item.name}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                        <div class="flex justify-center items-center">
                             <input v-model = "command[key].price" type = "number" class = "rounded border-gray-500 px-2 py-1"/>                                       
                        </div>
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{item.quantity}}                       </td>

                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{command[key].price * item.quantity}}
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class = "flex items-center w-full my-2 justify-center">
            <button @click = "sendCommand" class="bg-green-400 hover:bg-green-800  text-white w-auto py-2 px-4 rounded" >
                Valider la commande
            </button>
        </div>
        </div>
        <div v-else>Veillez attendre svp ... </div>
    </div>
</template>

<script>
export default {
 name:"LoanListing",
 data(){
    return{
        command : [],
        mounted:false,
        show_success: false,
        show_error: false,
        message: ""
    }
 },
 props: ["user","commandId","entrepriseId"],
 methods:{
    getCommand(){
    axios.get('/api/command/get',{params: {
        supplier_id: this.user.id,
        command_id: this.commandId
    }}).then(response =>{
       this.command = response.data
       //this.commands = this.commands.reverse()
       this.mounted = true
    })
    
    },
    sendCommand(){
        axios.post("/api/command/validate",{
            supplier_id: this.user.id,
            command: this.command,
            command_id: this.commandId,
            entreprise_id: this.entrepriseId
            }).then((resp)=>{
                this.show_success = true
                this.message = resp.data.message
                setTimeout(function() {
                  window.location.href ='/supplier/dashboard'
                }, 4000);
            }).catch(e=>{
                this.show_error = true
                this.message = "Une erreur s'est produite"
        });
    }
 },
 mounted(){
    this.getCommand()
    console.log(this.commands)
    
    
 }
}
</script>