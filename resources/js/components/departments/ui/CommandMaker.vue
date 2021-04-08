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
              <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                  <th class="py-3 px-6 text-left">Matière Première</th>
                  <th class="py-3 px-6 text-center">Fournisseur</th>
                   <th class="py-3 px-6 text-center">Délai Liv.</th>
                  <th class="py-3 px-6 text-left">Qt.</th>
                  <th class="py-3 px-6 text-center">Prix Unitaire</th>
                   <th class="py-3 px-6 text-center">Prix Total</th>
                  <th class="py-3 px-6 text-center">Actions</th>
              </tr>
          </thead>
          <tbody class="text-gray-600 text-sm font-light">
             
                  <CommandItem
                  v-for = "i in num_commands" class="border-b border-gray-200 hover:bg-gray-100"
                  :suppliers = "suppliers"
                  :materials = "materials"
                  :key = "i"
                  :ref = "i"
                  :index = "i"
                  @deleteRow = "deleteItem($event)"
                  ></CommandItem>

              
              
          </tbody>
      </table>
        <div class = "flex w-full justify-center items-center">
        <button @click = "addRow" class = "bg-green-500 text-white my-3 rounded w-34 h-10 px-3 py-2">
            Ajouter une ligne 
        </button>
        </div>
        <div class = "flex w-full justify-center items-center">
                <button @click = "sendCommand" class = "bg-blue-500 text-white my-3 rounded w-34 h-10 px-3 py-2">
           Envoyer la commande
        </button>

      </div>
    </div>
  </div>
</template>

<script type="text/javascript">
import CommandItem from "./CommandItem"
export default{
        name: "DepartmentCard",
        components: {CommandItem},
        data(){
            return {
                num_commands: 1,
                command: [],
                show_success:false,
                show_error:false,
                message: "Test"
            }
        },
        props:["materials","suppliers","user"],
        computed:{
        },
        methods:{
            addRow(){
                this.num_commands += 1
            },
            sendCommand(){
              for (var i = 1; i <= this.num_commands; i++) {
                let cmd_item = this.$refs[i][0].getItemData()
                this.command.push(cmd_item)
              }
              console.log(this.command)
              axios.post("/api/command/create",
                {
                  command: this.command,
                  entreprise_id: this.user.id
                }
              ).then(resp=>{
                this.show_success = true
                this.message = resp.data.message
                setTimeout(function() {
                  window.location.href ='/entreprise/department/Approvisionnement'
                }, 4000);

              }).catch(e=>{
                this.show_error = true
                this.message = "Une erreur s'est produite"
              })
            },
            deleteItem(e){
              console.log("Row should be deleted")
              this.num_commands -= 1;
              delete this.$refs[e.index]
              this.$forceUpdate()
            }
            
        },
        mounted(){
          console.log(this.user)

        }
    }
</script>