<template>
		<tr>
		<td class="py-3 px-6 text-left whitespace-nowrap">
                      <div class="flex items-center">
                          <select v-model = "commandItem['material']" class = "w-full rounded" >
                            <option :value = "mp.name" :key = "mp.name" v-for = "mp in materials">
                              {{mp.name}}
                            </option>
                          </select>
                      </div>
                  </td>
                  <td class="py-3 px-6 text-left">
                      <div class="flex items-center">
                          <select v-model = "commandItem['supplier']" class = "w-full rounded" >
                            <option   v-for = "supp in suppliers">
                              {{supp.name}}
                            </option>
                          </select>                                        
                      </div>
                  </td>
                  <td class = "text-center">
                  {{supplierDelay}}
                  </td>
                   <td class="py-3 px-6 text-left">
                      <div class="flex items-center">
                          <input  v-model = "commandItem['quantity']" type = "number" class = "rounded border-gray-500 px-2 py-1"/>                                       
                      </div>
                  </td>
                  <td class = "text-center">
                      {{materialPrice}}
                  </td>
                  <td class = "text-center">
                  	{{totalPrice}}
                  </td>
                  <td class = "text-center">
                      <div class = "flex w-full justify-center items-center">
                 <button @click = "deleteRow()" >
                      <i class = " mx-auto fa fa-trash text-red-500 text-xl"></i>
                  </button>
                  </div>
                      
                  </td>
              </tr>

</template>

<script type="text/javascript">
export default {

	props: ["materials","suppliers","index"],
	data(){
		return {
			commandItem:{
				material: "",
        supplier: "",
        price: null,
        quantity: 0,
        total_price: null
			},
      ddl: {
        min: null,
        max: null
      },
      filtered_materials: []
		}
	},
  watch:{
    'commandItem.material': function(n,o){
      this.filtered_materials = this.materials.filter(m=>m.name != n)
    }
  },
	computed:{
		supplierDelay(){
			if(this.commandItem.supplier != ""){
				let supplier = this.suppliers.find((item) => this.	commandItem.supplier == item.name)
        this.ddl.min =  supplier.ddl_min
        this.ddl.max = supplier.ddl_max 
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
		deleteRow(){
      this.$emit("deleteRow",{index:this.index})
      this.$destroy();
      this.$el.parentNode.removeChild(this.$el);
			
		},
    getItemData(){
      this.commandItem.price = this.materialPrice
      this.commandItem.total_price = this.totalPrice
      this.commandItem.ddl_min = this.ddl.min
      this.commandItem.ddl_max = this.ddl.max
      return this.commandItem
    }
	},
  created(){
    this.filtered_materials = this.materials
  }

	};
</script>