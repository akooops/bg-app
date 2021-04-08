<template>
  <div >
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
    <div v class="w-full bg-white shadow-md rounded my-2">
      
      <table class="min-w-max w-full table-auto">
        <thead>
          <tr>
            <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Numéro</th>


            <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Nombre d'items</th>
            <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Date de creation</th>
            <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Statut</th>
            <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Action</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(cmd,key) in commands" v-bind:key="key" class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0">
            <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
              {{cmd.command_id}}
            </td>
            <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
            {{cmd.num_items}}                       </td>

            <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
             Jour n° {{cmd.created}}
            </td>
            <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
              <span :class = "cmd.status == 'confirmed' ? 'text-green-500':'text-yellow-500'">{{getStatus(cmd.status)}}</span> 
            </td>
            <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
              <button  @click = "showDetails(cmd)" class="bg-green-400 hover:bg-green-800  text-white py-2 px-4 rounded"  >Détails</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <Modal v-if="show_details_modal" id = "modal" class="align-center modal" custom_css="w-1/2">
     <template v-slot:content>
        <h3 class = "font-extrabold text-lg my-3"> Détails sur la commande N° {{current_command.command_id}} </h3>

          <p
          v-for = "item in current_command.details"
          >- {{item.quantity}} {{item.unit}} de {{item.material}} chez <b>{{item.supplier}}</b> -  <span :class = "item.status == 'confirmed' ? 'text-green-500':'text-yellow-500'">{{getStatus(item.status)}}</span>  
          </p>

        <button class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4" @click="show_details_modal = false">Fermer</button>
      
    </template>
  </Modal>    
</div>
</template>

<script type="text/javascript">
import CommandItem from "./ui/CommandItem"
import Modal from "../Modal";
export default{
  name: "DepartmentCard",
  components: {CommandItem,Modal},
  data(){
    return {
      num_commands: 1,
      commands: [],
      show_success:false,
      show_error:false,
      message: "Test",
      current_command: {},
      show_details_modal: false
    }
  },
  props:["materials","suppliers","user"],
  computed:{
  },
  methods:{

    getCommands(){
      axios.get("/api/entreprise/commands",{params:
        {entreprise_id: this.user.id}
      }).then((resp) => {
        this.commands = resp.data
      })
    },
    showDetails(command){
      this.show_details_modal = true
      this.current_command = command
    },
    getStatus(status){
      if(status == "pending"){
        return "En Attente"
      }
      else if(status == "confirmed"){
        return "Confirmé"
      }
    }


  },
  mounted(){
    this.getCommands()
    console.log(this.user)
    window.Echo.channel("entreprise_"+this.user.id)
      .listen('NewNotification', (e) => {
    if(e.notification.type=='CommandAccepted'){
          this.getCommands()
          this.$forceUpdate()
            
    }
  });
}
}
</script>