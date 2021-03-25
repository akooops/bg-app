<template>
    <div >
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
import CommandItem from "./ui/CommandItem"
export default{
        name: "DepartmentCard",
        components: {CommandItem},
        data(){
            return {
                num_commands: 1,
                command: []
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
              axios.post("/api/commands/create",
                {
                  command: this.command,
                  entreprise_id: this.user.id
                }
              )
            },
            deleteItem(index){

            }
            
        },
        mounted(){
          console.log(this.user)

        }
    }
</script>