 <template>
	<div class = "w-full">
		<div class = "w-full">
			<button v-if = "show_decision_center==false" @click = "show_decision_center = true" class = "bg-green-500 p-3 rounded-sm text-white">Ouvrir le centre de décision</button>
			<button v-if = "show_decision_center" @click = "show_decision_center=false"  class = "bg-green-500 p-3 rounded-sm text-white">Revenir aux statistiques</button>
		</div>
		<div v-if = "show_decision_center == false">
		<div v-if = "show_stat_cards" class = "flex flex-wrap w-full justify-between py-3">
			<StatCard title = "Chiffre d'Affaire" color = "text-green-500"  icon = "fa-money" :value = "indicators['ca'].value"></StatCard>
			<StatCard title = "Machines" color = "text-gray-600" icon = "fa-cogs" :value = "indicators['machines'].value"></StatCard>
			<StatCard title = "Nb. Employés" color = "text-indigo-600"  icon = "fa-users" :value = "indicators['nb_workers_prod'].value"></StatCard>
		</div>
		<h1  class = "text-lg font-extrabold "> Analyse de la Demande</h1>
		<div v-if = "show_market_demand" class = "flex flex-wrap bg-white justify-center items-center my-3">
		<div v-for = "(prod,i) in prod_data" class = "w-1/2 rounded  mt-2">
			<h2 class = "font-extrabold text-lg px-2">Demande Prévisionelle - {{products[i].name}} </h2>
			<LineGraph
			:x-data = "prod.prices"
			:y-data = "prod.demand"
			></LineGraph>
		</div>
		</div>
	</div>
	<div v-if = "show_decision_center" >
		<ProdCenter :products = "products" :indicators="indicators"></ProdCenter>
	</div>
	</div>

</template>

<script type="text/javascript">

import LineGraph from "./ui/LineGraph";
import StatCard from "./ui/StatCard";
import ProdCenter from "./ProdCenter"
export default {
	name: "ProductionDepartment",
	components:{
		LineGraph,
		StatCard,
		ProdCenter
	},
	props: ["products","user"],
	data(){
		return {
			market_demand: [],
			id_list: [1,2,3,4],
			prod_data: [],
			show_market_demand: false,
			show_stat_cards: false,
			products: [],
			indicators: {},
			show_decision_center: false
		}
	},
	methods:{
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
				let resp = await axios.get("/api/demand/prev",{params:{
					product_id: i
				}})
				this.prod_data.push(resp.data)
			}
			this.show_market_demand = true
		}
	},
	mounted(){
		this.getProdNumbers()
		this.getMarketDemands()
	}

}


</script>