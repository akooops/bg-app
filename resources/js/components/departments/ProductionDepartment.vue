 <template>
	<div class = "w-full">
		<h1 class = "text-lg font-extrabold "> Analyse de la Demande</h1>
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

</template>

<script type="text/javascript">

import LineGraph from "./ui/LineGraph";





export default {
	name: "ProductionDepartment",
	components:{
		LineGraph
	},
	props: ["products"],
	data(){
		return {
			market_demand: [],
			id_list: [1,2,3,4],
			prod_data: [],
			show_market_demand: false,
			products: [],
			indicators: null
		}
	},
	methods:{
		getProdNumbers(){
			// Numbers to show in cards
			axios.get("/api/entreprise/production/indicators",{params:{
				entreprise_id: this.user.id
			}}).then((resp)=>{
				this.indicators = resp.data
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
		this.getMarketDemands()
	}

}


</script>