<template>
	<div class = "flex w-full">
		<div class = "flex flex-col items-center justify-center py-auto w-1/2 h-screen rounded-md bg-green-600">
			<p class = "font-extrabold my-2 text-white text-3xl"> <i class = "fa fa-crown text-3xl mx-2 text-yellow-300"></i>Entreprise Plus Rentable </p>
			<vue-letter-avatar :name='listing[0].entreprise_name' size='40' :rounded='true' />
			<p class = "font-extrabold my-2 text-white text-6xl">{{listing[0].entreprise_name}}</p>
			<p class = "font-extrabold my-1 text-white text-4xl">Profit : {{listing[0].profit}} DA</p>
		</div>
		<div class = "flex flex-col mx-2 items-center justify-start w-1/2 h-screen ">
		  <div class = "w-full h-12 px-3 flex flex-nowrap items-center justify-between  my-2 rounded-md mx-4 " >
				<h2 class = "font-bold">Entreprise</h2>
				<h2 class = "text-lg font-extrabold">Profit</h2>
			</div>
			<div class = "w-full h-20 px-3 flex flex-nowrap items-center justify-between bg-gray-200 my-2 rounded-md mx-4 hover:bg-green-500 hover:text-white " v-for = "item in listing">
				<h2 class = "font-bold">{{item.entreprise_name}}</h2>
				<h2 class = "text-lg  font-extrabold">{{item.profit}} DA</h2>
			</div>
		</div>
	</div>
</template>

<script type="text/javascript">

	export default{
		name: "LeaderBoard",
		data(){
			return {
				listing: []
			}
		},
		methods:{
			getListing(){
				axios.get("/api/ranking").then((resp)=>{
					this.listing = resp.data
				});
			}
		},
		beforeMount(){
			this.getListing()
		}
	}
</script>