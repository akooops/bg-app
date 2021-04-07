<template>
	<div class = "w-full">
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
	<div class = "flex w-full flex-wrap">
		<div class="w-1/3 mr-3 my-2 max-w-sm overflow-hidden rounded border bg-white shadow">
			<div class="relative">
				<div class="flex h-24 justify-center items-center">
					<i class = "fa fa-rocket text-green-300 text-6xl"></i>
				</div>
			</div>
			<div class="p-3 text-center">
				<h3 class=" text-lg font-extrabold mb-4 truncate-2nd">
					Lancer une Production
				</h3>
				<p>En lançant une production, vous produirez une quantité d'un produit que vous pourrez par la suite vendre. </p>
				<p><span class = "font-bold text-sm">Astuce : </span>Planifiez bien votre production en amont pour eviter les coûts de stock !</p>
				<button
				@click = "launch_prod_modal = true"
				class = "bg-blue-500 text-white w-56 my-2 px-3 py-1 rounded text-center"> Lancer </button>
			</div>
		</div>
		<div class="w-1/3 mr-3 my-2 max-w-sm overflow-hidden rounded border bg-white shadow">
			<div class="relative">
				<div class="flex h-24 justify-center items-center">
					<i class = "fa fa-cogs text-green-300 text-6xl"></i>
				</div>
			</div>
			<div class="p-3 text-center">
				<h3 class=" text-lg font-extrabold mb-4 truncate-2nd">
					Machines
				</h3>
				<p>En achetant de nouvelles machines ou en réparant des anciennes machines vous pourrez produire plus de quantité. </p>
				<p><span class = "font-bold text-sm">Astuce : </span>Attention à ne pas sur-estimer vos besoins en machines</p>
				<button @click = "setMachineTransaction('buy')"
				class = "bg-blue-500 text-white w-56 my-2 px-3 py-1 rounded text-center"> Acheter une machine </button>
				<button
				@click = "setMachineTransaction('sell')"
				class = "bg-blue-500 text-white w-56 my-2 px-3 py-1 rounded text-center"> Vendre une machine </button>
			</div>
		</div>
		<div class="w-1/3 mr-3 my-2 max-w-sm overflow-hidden rounded border bg-white shadow">
			<div class="relative">
				<div class="flex h-24 justify-center items-center">
					<i  class = " fa fa-industry text-green-300 text-6xl"></i>
				</div>
			</div>
			<div class="p-3 text-center">
				<h3 class=" text-lg font-extrabold mb-4 truncate-2nd">
					Ateliers
				</h3>
				<p>Dans cette section vous pouvez lancer des actions pour améliorer l'état de vos usines et votre productivité. </p>
				<select v-model = "action.value">
					<option value = "5s">Appliquer les 5S</option>
					<option value = "hse">Effectuer un audit HSI</option>
					<option value = "maintenance">Lancer une maintenance générale</option>
				</select>
				<button
				class = "bg-blue-500 text-white w-56 my-2 px-3 py-1 rounded text-center" @click = "showActionInfo"> Appliquer</button>
				
			</div>
		<Modal v-if = "launch_prod_modal">
			<template v-slot:content>
				<div class ="w-full flex flex-wrap p-2 ">
				<div class = "w-1/2">	
				<h1>Lancer une Production</h1>
				<p class = "my-1 mx-4">Produit :</p>
				<select class = "mx-4 w-1/3" v-model = "launch_data.prod_id">
					<option :value = "prod.id" v-for = "prod in products">{{prod.name}}</option>
				</select>
				<p class = "my-1 mx-4" v-model = "launch_data.quantity">Quantité (en lot de 100 pièces)</p>
				<input v-model = "launch_data.quantity" class="mx-4 w-2/3" type = "number"/>
				<p class = "my-1 mx-4" >Prix (Unitaire)</p>
				<input class = "mx-4 w-2/3" v-model = "launch_data.price" type = "number"/>
				<div class = "h-auto ">
				<button :disabled = "can_produce == false" @click = "launchProduction" class = "bg-blue-400 mx-4 my-2 py-1 px-4 text-white" v-if = "can_produce">Lancer ! </button>
				<p class = "text-red-500" v-if = "can_produce== false">{{can_produce_msg}}</p>
			</div>
				
				</div>
				<div class = "w-1/2">
					<h1 class = "font-bold text-xl">Informations Importantes</h1>
					<h2 class = "font-bold text-lg">Nécessite: </h2>
					<p>Pour un lot:</p>
					<p>- Machines x <span class = "text-blue-700 font-bold">{{selectedProd.machine_units}}</span> et 
					 Employés x <span class = "text-blue-700 font-bold">{{selectedProd.labor_units}}</span></p>
					 <p v-for = "material in selectedProd.raw_materials">- {{material.name}} x <span class = "text-blue-700 font-bold"> {{material.pivot.quantity}} </span></p>
					<h2 class = "font-bold text-lg">Prévisions: </h2>
					<p>- Chiffre d'Affaire Estimé : <span class = "font-bold text-indigo-500"> {{salesRevenues}} UM</span></p>
					<p>- Coût Total Estimé : <span class = "font-bold text-red-500"> {{totalCost}} UM</span></p>
					<p>- Profit Estimé : <span :class = "profit >= 0 ? 'text-green-500':'text-red-400'" class = "font-bold "> {{profit}} UM</span></p>
					<p>- Durée de production : <span  class = "text-yellow-500 font-bold "> {{prodDelay}} j</span></p>
					
					<h2 class = "text-sm font-bold">Remarques: </h2>					<p class = "text-xs font-bold">- Les prévisions sont calculés dans le cas ou toutes la quantité produite est vendue</p>
					<p class="text-xs font-bold">- Votre taux de rebut est de {{indicators["reject_rate"].value * 100}}%, pour le réduire, lancez une étude AMDEC.</p>
					<p>
					<button @click = "launch_prod_modal=false" class = "bg-gray-500 justify-end px-3 py-1 text-white rounded my-1" >Fermer</button></p>
				</div>
			</div>
			</template>	
		</Modal>
		<Modal v-if = "machine.show_transaction_modal">
			<template v-slot:content>
            		<div class = "w-full">
            			<p v-if = "machine.transaction == 'buy'">Vous allez acheter une machine au prix de {{machine.buy_price}}, voulez vous continuer ?</p>
            			<p v-if = "machine.transaction == 'sell'">Vous allez vendre une machine au prix de {{machine.sell_price}} DA, voulez vous continuer ?</p>
            			<div class = "w-full my-2 flex flex-wrap items-center px-10 space-x-4 ">
            				<button @click = "confirmMachineTransaction" class = "bg-green-500 rounded px-3 py-1 text-white">Confirmer</button>
            				<button @click = "machine.show_transaction_modal=false" class = "bg-gray-500 rounded px-3 py-1 text-white">Annuler</button>
            			</div>
            		</div>
            	</template>
		</Modal>
		<Modal v-if = "action.show_info">
			<template v-slot:content>
            		<div class = "w-full">
            			<p>{{action.phrase}}</p>
            			<p> <span class = "font-bold">Résultat : </span>{{action.result_phrase}}</p>
            			<div class = "w-full my-2 flex flex-wrap items-center px-10 space-x-4 ">
            				<button @click = "confirmAction" class = "bg-green-500 rounded px-3 py-1 text-white">Confirmer</button>
            				<button @click = "action.show_info=false" class = "bg-gray-500 rounded px-3 py-1 text-white">Annuler</button>
            			</div>
            		</div>
            	</template>
		</Modal>

	</div>
</div>
	</div>
</template>

<script>
import Modal from "../Modal"
export default{
	name: "ProdCenter",
	components:{Modal},
	props: ["products","indicators","user"],
	data(){
		return {
			launch_prod_modal: false,
			launch_data:{
				prod_id: 1,
				price: 0,
				quantity: 0
			},
			prod_factors: {
				machines: 0,
				labor: 0
			},
			machine:{
				show_transaction_modal: false,
				transaction:'',
				buy_price: 10000,
				sell_price: 8000 * this.indicators["machines_health"].value
			},
			can_produce_msg: "",
			can_produce: true,
			stock: {},
			show_success: false,
			show_error: false,
			message: "",
			action:{
				value: "",
				price: {
					'5s': 20000,
					'hse': 35000,
					'maintenance': 5000 * this.indicators["machines"]["value"]
				},
				phrase: "",
				result_phrase: "",
				show_info: false
			}
		}
	},
	watch:{
		'launch_data.quantity': function(new_val,old_val){
			this.prod_factors = {
				"machines": this.launch_data.quantity*this.selectedProd.machine_units,
				"labor": this.launch_data.quantity*this.selectedProd.labor_units
			}
			console.log(this.prod_factors)
			console.log(this.indicators)
			this.can_produce = false
			this.verifyProd()		
		}
	},
	computed:{
		selectedProd(){
			return this.products.find(item => item.id == this.launch_data.prod_id)
		},
		salesRevenues(){
			let coeff = 1 - this.indicators["reject_rate"].value
			return this.launch_data.price * this.launch_data.quantity * 100 * coeff
		},
		totalCost(){


			return this.launch_data.quantity*(this.selectedProd.machine_units * 25 + this.selectedProd.labor_units * 45)
		},
		profit(){
			return this.salesRevenues - this.totalCost
		},
		prodDelay(){
			let coeff = this.indicators["productivity_coeff"].value
			return this.launch_data.quantity / (coeff * 10 )
		}
	},
	methods:{
		launchProduction(){
			let data = {
				"product_id": this.selectedProd.id,
				"entreprise_id": this.user.id,
				"quantity": this.launch_data.quantity,
				"price": this.launch_data.price,
				"cost": this.totalCost,
				"delay": this.prodDelay * 60,
				"machines": this.prod_factors.machines,
				"labor": this.prod_factors.labor
			}
			axios.post("/api/production/launch",data).then(resp=>{
				this.show_success= true
				this.message = resp.data.message
				this.launch_prod_modal = false
				this.launch_data = {
						prod_id: 1,
						price: 0,
						quantity: 0
					}
				this.prod_factors =  {
						machines: 0,
						labor: 0
					}
				this.$emit("prodLaunched");
			}).catch(e=>{
				this.show_error = true
				this.message = "Oops ! une erreur est survenue, veuillez infomrer un organisateur"
				this.launch_prod_modal = false
			})
		},
		getStock(){
			axios.get("/api/entreprise/stock",{params:{
				entreprise_id: this.user.id
			}
			}).then((resp)=>{
				console.log(resp)
				this.stock = resp.data
				this.verifyProd()
			})
		},
		verifyProd(){
			let resp =  true
			let free_machines = this.indicators["machines"].value - this.indicators["busy_machines"].value
			if(this.prod_factors.machines <=  free_machines && this.prod_factors.labor <= this.indicators["nb_workers_prod"].value){
				for(const material of this.selectedProd.raw_materials){
					let stock_material = this.stock.find((item)=>{
						return item.id == material.pivot.raw_material_id
					})
					console.log(stock_material)
					if(material.pivot.quantity < stock_material.quantity){
						continue
					}
					else{
						resp = false
						this.can_produce_msg = "Pas assez de matière " + material.name + "vous ne pouvez pas lancer la production !"
						break;
					}
				}
			}
			else{
				resp = false
				this.can_produce_msg = "Pas assez de machines ou d'employés, vous ne pouvez pas lancer la production !"
			}
			this.can_produce = resp
		},
		setMachineTransaction(type){
			this.machine.transaction = type
			this.machine.show_transaction_modal = true
		},
		confirmMachineTransaction(type){
			if(this.machine.transaction == "buy"){
				axios.post("/api/entreprise/machine/buy",{
					entreprise_id: this.user.id,
					price: this.machine.buy_price 
				}).then((resp)=>{
					this.machine.show_transaction_modal = false
				})
			}
			else if(this.machine.transaction == "sell"){
				axios.post("/api/entreprise/machine/sell",{
					entreprise_id: this.user.id,
					price: this.machine.sell_price 
				}).then((resp)=>{
					this.machine.show_transaction_modal = false
				})
			}
		},
		showActionInfo(){
			switch(this.action.value){
				case '5s':
					this.action.phrase = "Vous allez lancer une amélioration en appliquant les 5S, celà vous coutera " + this.action.price['5s'] + " DA"
					this.action.result_phrase = "Vous pourrez produire plus rapidement !"
					break;
				case 'hse':
					this.action.phrase = "Vous allez lancer une amélioration en suivant la norme ISO 45001 (HSE), celà vous coutera " + this.action.price['hse'] + " DA"
					this.action.result_phrase = "Vous pourrez produire plus rapidement !"
					break;
				case 'maintenance':
					this.action.phrase = "Vous allez lancer une maintenance générale, celà vous coutera " + this.action.price['maintenance'] +" DA"
					this.action.result_phrase = "Vous pouvez vendre vos machines avec un prix plus élevé."
					break;
			}
			this.action.show_info = true

		},
		confirmAction(){
			let price = this.action.price[this.action.value]
			axios.post("/api/entreprise/production/apply-action",{
				'type':this.action.value,
				'price':price,
				'entreprise_id':this.user.id
			}).then(resp=>{
				this.action.show_info = true
			})
		}



	},
	mounted(){
		this.getStock()
	}
}
</script>