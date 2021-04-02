<template>
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
				<button
				class = "bg-blue-500 text-white w-56 my-2 px-3 py-1 rounded text-center"> Acheter une machine </button>
				<button
				class = "bg-blue-500 text-white w-56 my-2 px-3 py-1 rounded text-center"> Afficher l'état machines </button>
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
				<select>
					<option>Appliquer les 5S</option>
					<option>Effectuer un audit HSI</option>
					<option>Autre action</option>
				</select>
				<button
				class = "bg-blue-500 text-white w-56 my-2 px-3 py-1 rounded text-center"> Appliquer</button>
				
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
				<div class = "h-auto flex items-center">
				<button class = "bg-blue-400 mx-4 my-2 py-1 px-4 text-white">Lancer ! </button></div>
				</div>
				<div class = "w-1/2">
					<h1 class = "font-bold text-xl">Informations Importantes</h1>
					<h2 class = "font-bold text-lg">Nécessite: </h2>
					<p>- Machines x <span class = "text-blue-700 font-bold">{{selectedProd.machine_units}}</span> et 
					 Employés x <span class = "text-blue-700 font-bold">{{selectedProd.labor_units}}</span></p>
					 <p v-for = "material in selectedProd.raw_materials">- {{material.name}} x <span class = "text-blue-700 font-bold"> {{material.pivot.quantity}} </span></p>
					<h2 class = "font-bold text-lg">Prévisions: </h2>
					<p>- Chiffre d'Affaire Estimé: <span class = "font-bold text-indigo-500"> {{salesRevenues}} UM</span></p>
					<p>- Coût Total Estimé: <span class = "font-bold text-red-500"> {{totalCost}} UM</span></p>
					<p>- Profit Estimé: <span :class = "profit >= 0 ? 'text-green-500':'text-red-400'" class = "font-bold "> {{profit}} UM</span></p>
					<p></p>
					<h2 class = "text-sm font-bold">Remarques: </h2>					<p class = "text-xs font-bold">- Les prévisions sont calculés dans le cas ou toutes la quantité produite est vendue</p>
					<p class="text-xs font-bold">- Votre taux de rebut est de {{indicators["reject_rate"].value * 100}}%, pour le réduire, lancez une étude AMDEC.</p>
				</div>
			</div>
			</template>	
		</Modal>
	</div>

	</div>
</template>

<script>
import Modal from "../Modal"
export default{
	name: "ProdCenter",
	components:{Modal},
	props: ["products","indicators"],
	data(){
		return {
			launch_prod_modal: false,
			launch_data:{
				prod_id: 1,
				price: 10,
				quantity: 1
			},
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
		}
	},
	methods:{

	},
	mounted(){

	}
}
</script>