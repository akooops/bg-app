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

      <table class="min-w-max w-full table-auto ">
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

          <tr v-for = "(cmd,key) in commands" :key = "key">
                  <td class="py-3 px-6 text-left whitespace-nowrap">
                     {{cmd.material}}
                  </td>
                  <td class="py-3 px-6 text-left">
                      {{cmd.supplier}}
                  </td>
                  <td class = "text-center">
                  {{cmd.ddl_min}}j - {{cmd.ddl_max}}j
                  </td>
                   <td class="py-3 px-6 text-left">
                      {{cmd.quantity}}
                  </td>
                  <td class = "text-center">
                      {{cmd.price}}
                  </td>
                  <td class = "text-center">
                    {{cmd.total_price}}
                  </td>
                  <td class = "text-center">
                      <div class = "flex w-full justify-center items-center">
                 <button @click = "deleteRow(key)" >
                      <i class = " mx-auto fa fa-trash text-red-500 text-xl"></i>
                  </button>
                  </div>
                      
                  </td>
              </tr>




        </tbody>
      </table>
      <div class = "flex w-full justify-center items-center">
        <button @click = "newCommandModal()" class = "bg-green-500 text-white my-3 rounded w-34 h-10 px-3 py-2">
          Ajouter une ligne 
        </button>
      </div>
      <div class = "flex w-full justify-center items-center">
        <button v-if = "commands.length > 0" @click = "sendCommand" class = "bg-blue-500 text-white my-3 rounded w-34 h-10 px-3 py-2">
         Envoyer la commande
       </button>

     </div>
   </div>
   <Modal v-if = "show_add_modal">
    <template v-slot:content>
      <div class = "w-full">
        <p>Matière : </p>
          <select v-model = "commandItem['material']" class = "w-full rounded" >
                <option :value = "mp.name" :key = "mp.name" v-for = "mp in materials">
                              {{mp.name}}
                </option>
          </select>
        <p>Fournisseur : </p>
        <select v-model = "commandItem['supplier']" class = "w-full rounded" >
          <option   v-for = "supp in suppliers">
            {{supp.name}}
          </option>
        </select>
        <p>Quantité : </p>
        <input type = "number" min = "0" placeholder = "Quantité en unité" v-model = "commandItem.quantity" >
        <p>Prix Unitaire : {{materialPrice}} </p>
        <p> Prix Total : {{totalPrice}} </p>
        <p>Délai de Livraison: {{supplierDelay}}</p>
        <button @click = "addRow" class = "px-2 py-3 bg-green-400 text-white w-40" >Ajouter</button>
        <button @click = "show_add_modal=false" class = "px-2 py-3 bg-gray-300  w-40" >Fermer</button>
      </div>
    </template>
  </Modal>
</div>
</template>

<script type="text/javascript">
import CommandItem from "./CommandItem"
import Modal from "../../Modal"
export default{
  name: "DepartmentCard",
  components: {CommandItem,Modal},
  data(){
    return {
      num_commands: 1,
      show_success:false,
      show_error:false,
      message: "Test",
      show_add_modal : false,
      commandItem:{
        material: "",
        supplier: "",
        price: null,
        quantity: 0,
        total_price: null,
        ddl: {
          min: null,
          max: null
        },
      },
      commands:[],
      filtered_materials: [],
    }
  },
  props:["materials","suppliers","user"],
  computed:{
    supplierDelay(){
      if(this.commandItem.supplier != ""){
        let supplier = this.suppliers.find((item) => this.commandItem.supplier == item.name)
        this.commandItem.ddl.min =  supplier.ddl_min
        this.commandItem.ddl.max = supplier.ddl_max 
        return supplier.ddl_min +"j - " + supplier.ddl_max + "j"
      }

    },
    materialPrice(){
      if(this.commandItem.material != "" && this.commandItem.supplier != ""){
        let material = this.materials.find((item) => this.commandItem.material == item.name)
        let supplier = this.suppliers.find((item) => this.commandItem.supplier == item.name)
        
        return Math.round(material.price * supplier.rate * 100)/100
      }
      else{
        return 0
      }

    },
    totalPrice(){
      if(this.materialPrice != null){
        return Math.round(this.materialPrice * this.commandItem.quantity * 100)/100
      }
      else{
        return 0
      }
      
    }
  },
  methods:{
    newCommandModal(){
      this.show_add_modal = true
    },
    addRow(){
      let command = {
        material: this.commandItem.material,
        supplier: this.commandItem.supplier,
        quantity: this.commandItem.quantity,
        ddl_min: this.commandItem.ddl.min,
        ddl_max: this.commandItem.ddl.max,
        price: this.materialPrice,
        total_price: this.totalPrice,
        item_id: this.num_commands
      }
      this.commands.push(command)
      this.num_commands += 1
      this.show_add_modal = false
    },
    sendCommand(){
      
      console.log(this.command)
      axios.post("/api/command/create",
      {
        command: this.commands,
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
    deleteRow(index){
      this.commands.splice(index,1)
    }

  },
  mounted(){
    console.log(this.user)

  }
}
</script>