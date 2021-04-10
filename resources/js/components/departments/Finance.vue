<template>
	<div class = "w-full">
		<div  class = "flex flex-wrap w-full justify-evenly py-3">
			<StatCard title = "Chiffre d'Affaire" color = "text-green-500"  icon = "fa-coins" :value = "indicators['ca'][4].value + ' DA'"></StatCard>
			<StatCard title = "Caisse" color = "text-green-600"  icon = "fa-piggy-bank" :value = "indicators['other'][0].value + ' DA'"></StatCard>
			<StatCard title = "Dettes" color = "text-green-600"  icon = "fa-landmark" :value = "indicators['other'][1].value + ' DA'"></StatCard>
		</div>
		<div class = "flex flex-wrap justify-between items-center w-full">
		<div  class = "flex flex-wrap  w-1/3 justify-between py-3">
			<h2 class = "font-bold">Part du Marché par Produit</h2>
			<BarChart v-if = "market_share_entrep != null" unit = "%" :x-data = "market_share_entrep.names" :y-data = "market_share_entrep.values.map(e=> e*100)" :width = "50"></BarChart>
		</div>
		<div  class = "flex flex-wrap items-center justify-center  w-1/2 justify-between py-3">
				<h2 class = "font-bold">Part du Marché Pour le produit</h2>
				<select v-model = "selected_product">
					<option :value = "product.id" v-for = "product in products">{{product.name}}</option>
				</select>
				<PieChart  v-if = "market_share_prod != null" :legend = "entreprise_names" :serie = "market_share_prod"></PieChart>			

		</div>
		<div  class = "flex flex-wrap items-center justify-center  w-1/2 justify-between py-3">
				<h2 class = "font-bold">Chiffres d'Affaire</h2>
				<PieChart  v-if = "market_share_prod != null" :legend = "entreprise_names" :serie = "indicators['ca'].slice(0,4)"></PieChart>			

		</div>
		<div  class = "flex flex-wrap items-center justify-center  w-1/2 justify-between py-3">
				<h2 class = "font-bold">Coûts</h2>
				<BarChart v-if = "indicators['costs'] != null" unit = "DA" :x-data = "indicators['costs'].map(i => i.name) " :y-data = "indicators['costs'].map(i => i.value)" :width = "30"></BarChart>		

		</div>
		<div  class = "flex flex-wrap items-center justify-center  w-1/2 justify-between py-3">
				<h2 class = "font-bold">Dettes</h2>
				<speedo-meter  :data="[{value:indicators['other'][2].value,name:indicators['other'][2].name}]" class=" "></speedo-meter>	

		</div>
		</div>
		</div>

</template>

<script>

import LineGraph from "./ui/LineGraph";
import BarChart from "./ui/BarChart";
import PieChart from "./ui/PieChart";
import SpeedoMeter from "./ui/SpeedoMeter";
import StatCard from "./ui/StatCard";
import ProdCenter from "./ProdCenter"
import Modal from "../Modal";
export default {
		name: "Finance",
		props: ["user","products","entreprises"],
		data(){
			return {
				indicators: [],
				selected_product: 1,
				market_share_prod: null,
				market_share_entrep: null,
				entreprise_names:[]
			}
		},
		components: {StatCard,LineGraph,BarChart,PieChart,SpeedoMeter},
		watch:{
			selected_product: function(n,o){
				this.market_share_prod = null
				this.getMarketShareProd()
			}
		},
		computed:{

		},
		methods:{
			getMarketShareProd(){
				axios.get("/api/indicator/market-share-prod",{params:{
					"product_id": this.selected_product
				}}).then(resp=>{
					this.market_share_prod = resp.data

				})
			},
			getMarketShares(){
				axios.get("/api/indicator/market-share",{params:{
					"entreprise_id": this.user.id
				}}).then(resp=>{
					this.market_share_entrep = resp.data
				})
			},
			getFinIndicators(){
				axios.get("/api/indicator/finance",{params:{
					"entreprise_id": this.user.id
				}}).then(resp=>{
					this.indicators = resp.data
				})				
			}
		},
		mounted(){
			this.entreprise_names = this.entreprises.map(e => e.name)
			this.getMarketShares()
			this.getMarketShareProd()
			this.getFinIndicators()
		}
	}
</script>