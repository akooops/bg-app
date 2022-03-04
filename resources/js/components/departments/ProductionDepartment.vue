 <template>
	<div class = "w-full">
		<div class = "w-full">
			  <nav class="border-b text-sm flex justify-start">
    		<button @click = "page_index = 'prod_stats'" :class = "page_index == 'prod_stats'? 'border-b-2 border-indigo-600 text-indigo-600 font-semibold':'text-gray-700 hover:text-black'" class="inline-block px-4 py-2 focus:outline-none text-lg" href="#">Statistiques</button>

    <!-- active -->
    		<button @click = "page_index = 'production_list'" :class = "page_index == 'production_list'? 'border-b-2 border-indigo-600 text-indigo-600 font-semibold':'text-gray-700 hover:text-black'" class="inline-block px-4 py-2 focus:outline-none text-lg" href="#">Productions</button>

    		<button @click = "page_index = 'decision_center'" :class = "page_index == 'decision_center'? 'border-b-2 border-indigo-600 text-indigo-600 font-semibold':'text-gray-700 hover:text-black'" class="inline-block px-4 py-2 focus:outline-none text-lg" href="#">Centre de décision</button>

  		</nav>
		</div>
		<div v-if = "show_decision_center == false">
		<div v-if = "show_stat_cards" class = "flex flex-wrap w-full justify-between py-3">
			<StatCard title = "Chiffre d'Affaire" color = "text-green-500"  icon = "fa-coins" :value = "indicators['ca'].value"></StatCard>
			<StatCard title = "Machines" color = "text-gray-600" icon = "fa-cogs" :value = "indicators['machines'].value"
			:second-value = "indicators['busy_machines'].value +  ' occupées.'"

			></StatCard>
			<StatCard title = "Nb. Employés" color = "text-indigo-600"  icon = "fa-users" :value = "indicators['nb_workers_prod'].value"></StatCard>
		</div>
		<div v-if = "page_index == 'prod_stats'">
		<h1  class = "text-lg font-extrabold "> Analyse de la Demande</h1>

		<div v-if = "show_market_demand" class = "flex flex-wrap bg-white justify-center items-center my-3">
			<div v-for = "(prod,i) in prod_data" class = "w-1/2 rounded  mt-2">
				<h2 class = "font-extrabold text-lg px-2">Demande Prévisionelle - {{products[i].name}} :  </h2>
				<h3 class = "px-3 font-bold">{{products[i].left_demand}} demandes restante (mensuelle). </h3>
				<button @click = "showProductDescription(i)" class = "bg-green-400 mx-2 my-1 text-white px-3 py-1 rounded">Afficher la Déscription</button>
				<LineGraph
				:x-data = "prod.prices"
				:y-data = "prod.demand"
				></LineGraph>
			</div>
		   <Modal v-if = "show_product_info">
            	<template v-slot:content>
            		<div class = "w-full">
						<h1 class = "text-lg font-bold">Détails - {{product_info.name}}</h1>
						<p>{{product_info.description}}</p>
						<p class = "font-bold "> Pour produire un lot de 100 unités de ce produit vous avez besoin de : </p>
						<p>- Machines x <span class = "text-blue-700 font-bold">{{product_info.machine_units}}</span> et
					 Employés x <span class = "text-blue-700 font-bold">{{product_info.labor_units}}</span></p>
					 <p v-for = "material in product_info.raw_materials">- {{material.name}} x <span class = "text-blue-700 font-bold"> {{material.pivot.quantity}} </span> KG</p>
					 <p><span class = "font-bold">Prix Moyen </span> : {{product_info["avg_price"]}} DA (Moyenne basée sur les 10 dernières productions lancées dans le jeu.) </p>
						<button class = "bg-gray-300 px-3 py-1 rounded my-1" @click = "show_product_info =false">Fermer</button>
					</div>
            	</template>
            </Modal>
		</div>
		</div>
		<div v-if = "page_index == 'production_list'" class = "w-full">
			<div classs = "inline-flex w-full  items-center justify-between">
				<h1  class = "text-lg font-extrabold "> Vos Productions</h1>
				<button class = "bg-blue-500 px-4 py-1 my-2 text-white" @click = "getProductions">Actualiser</button>
			</div>
			<table v-if = "productions.length > 0"  class="border-collapse w-full">
                <thead>
                    <tr>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Numéro</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Produit</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Qt. Produite</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Qt. Vendue</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Stock</th>
                        <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Prix</th>
                         <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Coût</th>
                         <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Chiffre d'Affaire</th>
                         <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Status</th>
                          <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(prod,key) in productions" v-bind:key="key" class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0">
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{prod.id}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{prod.product}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{prod.quantity}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{prod.sold}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{prod.quantity - prod.sold}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{prod.price}}
                        </td>
                         <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{prod.cost}}
                        </td>
                        <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            {{prod.sold * prod.price}} UM
                        </td>
                        <td :class = "prod.status_code == 'pending' ? 'text-yellow-500':'text-green-500'" class="w-full lg:w-auto p-3 text-center border border-b block lg:table-cell relative lg:static">(
                            {{prod.status}}
                        </td>
                         <td class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static">
                            <button @click = "sell(prod)" v-if = "prod.status_code == 'completed' && prod.sold < prod.quantity"   class="bg-green-400 hover:bg-green-800  text-white py-2 px-4 rounded"  >Vendre</button>
                            <p v-if = "prod.status_code == 'pending'">Vous ne pouvez pas vendre encore.</p>
                            <p v-if = "prod.sold >= prod.quantity">Vous ne pouvez plus vendre.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
            <Modal v-if = "show_selling_info">
            	<template v-slot:content>
            		<div class = "w-full">
            			<p>Vous allez vendre <span class = "font-bold text-green-500">{{sell_info.sold_quant}}</span> unités au prix de  <span class = "font-bold text-green-300"> {{sell_info.price}}</span> UM et vous aurez  <span class = "font-bold text-yellow-500"> {{sell_info.stock_quant}} </span> unités en stock.</p>
            			<p class = "font-bold text-red-500">Coût de distribution total : {{distCost}} UM </p>
            			<div class = "w-full my-2 flex flex-wrap items-center px-10 space-x-4 ">
            				<button @click = "confirmSell" class = "bg-green-500 rounded px-3 py-1 text-white">Confirmer</button>
            				<button @click = "show_selling_info=false" class = "bg-gray-500 rounded px-3 py-1 text-white">Annuler</button>
            			</div>
            		</div>
            	</template>
            </Modal>

		</div>
	<div v-if = "page_index == 'decision_center'" >
		<ProdCenter @prodLaunched = "updateProdData" :user = "user" :products = "products" :indicators="indicators" :caisse="caisse"></ProdCenter>
	</div>
	</div>

	</div>

</template>

<script type="text/javascript">

import LineGraph from "./ui/LineGraph";
import StatCard from "./ui/StatCard";
import ProdCenter from "./ProdCenter"
import Modal from "../Modal";
export default {
	name: "ProductionDepartment",
	components:{
		LineGraph,
		StatCard,
		ProdCenter,
		Modal
	},
	props: ["user","caisse"],
	data(){
		return {
			products: [],
			market_demand: [],
			id_list: [1,2,3,4],
			prod_data: [],
			show_market_demand: false,
			show_stat_cards: false,
			products: [],
			indicators: {},
			productions:[],
			page_index: 'prod_stats',
			show_decision_center: false,
			sell_info:{
				sold_quant: 0,
				stock_quant:0,
				price: 0
			},
			show_selling_info: false,
			show_product_info: false,
			product_info: null,
			average_prices: []
		}
	},
	computed:{
		distCost(){
			// Distribution cost
			return this.sell_info.sold_quant * this.indicators["dist_unit_cost"].value
		}
	},
	methods:{
		showProductDescription(i){
			let product = this.products[i]
			this.product_info = product
			//this.show_product_info = true
			this.getAvgPrice(this.products[i])
		},
		getProdNumbers(){
			// Numbers to show in cards
			axios.get("/api/entreprise/production/indicators",{params:{
				entreprise_id: this.user.id
			}}).then((resp)=>{
				this.indicators = resp.data
				this.show_stat_cards = true
			});
		},
		async getMarketDemands(){

			for (var i = 1; i < 5; i++) {
				let resp = await axios.get("/api/demand/prev", {params: {
					product_id: i
				}})
				this.prod_data.push(resp.data)
			}
			this.show_market_demand = true
		},
		getProductByName(name){
			return this.products.find((p) => p.name == name);
		},
		getProductions(){
			axios.get("/api/production/all",{params:{
				entreprise_id: this.user.id
			}}).then(resp => {
				this.productions = resp.data.reverse()
			})
		},
		getAvgPrice(product){

				axios.get("/api/production/avg-price",{params: {product_id:product.id}}).then(resp=>{
					this.product_info["avg_price"] = resp.data
					this.show_product_info = true
				});

		},
		sell(prod){
			console.log(prod)
			let data = {
				entreprise_id: this.user.id,
				id: prod.id,
				product_id: this.getProductByName(prod.product).id,
				quantity: (prod.quantity - prod.sold),
				price: prod.price,
			}
			this.sell_info.production = data
			axios.get("/api/demand/real",{params:data}).then((resp)=>{
				this.sell_info.sold_quant = resp.data.demand
				this.sell_info.stock_quant = resp.data.stock
				this.sell_info.price = data.price
				this.show_selling_info = true
			})
		},
		confirmSell(){
			let data = {
				entreprise_id: this.user.id,
				product_id: this.sell_info.production.product_id,
				production_id: this.sell_info.production.id,
				dist_cost: this.distCost,
				sold: this.sell_info.sold_quant,
				stock: this.sell_info.stock_quant,
				price: this.sell_info.price
			}
			axios.post("/api/production/sell",data).then((resp)=>{
				this.show_selling_info = false
			})
		},
		getProducts(){
			axios.get("/api/products").then(resp=>{
				this.products = resp.data

			})
		},

		updateProdData(){
			this.getProdNumbers()
			this.getProductions()
		    this.getProducts()
		}
	},
	beforeMount(){
		this.getProducts()
	},
	mounted(){
        console.log('Test')
		this.updateProdData()
		this.getMarketDemands()
		this.getProducts()
		window.Echo.channel("entreprise_"+this.user.id)
    	.listen('NewNotification', (e) => {
        if(e.notification.type=='ProductionSold'){
        	this.updateProdData()
        	this.getProducts()
            this.$forceUpdate()

        }
        if(e.notification.type=='ProductionDone'){
        	this.updateProdData()
            this.$forceUpdate()
        }
        if(e.notification.type=='ProductionLaunched'){
        	this.updateProdData()
            this.$forceUpdate()
        }
        if(e.notification.type=='MachineBought'){
        	this.getProdNumbers()
            this.$forceUpdate()
        }
        if(e.notification.type=='MachineSold'){
        	this.getProdNumbers()
            this.$forceUpdate()
        }
        if(e.notification.type=='Information'){
        	this.getProdNumbers()
            this.$forceUpdate()
        }


    })
    	    window.Echo.channel("entreprise_"+this.user.id)
    .listen('NavbarDataChanged', (e) => {
        this.caisse = e.caisse
    })
	}

}


</script>
