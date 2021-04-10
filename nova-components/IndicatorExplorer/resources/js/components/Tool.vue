<template>
    <div>
        <heading class="mb-6">Indicator Explorer</heading>
        <card
            class="bg-90 flex flex-col  bg-white p-6"
            style="min-height: 300px"
        >
            <p class="text-left">Choisissez l'indicateur à afficher</p>
            <select v-model="selected_indicator" @change="getEntrepriseIndicators" class="w-full form-control form-input form-input-bordered pl-2"> 
                <option  v-for="indicator in indicators" :key="indicator.code" :value="indicator.id">{{indicator.name}}</option>
            </select>
            <table v-if="loaded" class="mt-4">
               <thead>
                <tr>
                    <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300  ">Entreprise</th>
                    <th class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 ">Valeur</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="datum in data" v-bind:key="datum.id">
                    <th class="p-3 font-bold text-gray-600 border border-gray-300  "> {{datum.name}}</th>
                    <th class="p-3 font-bold  text-gray-600 border border-gray-300 ">{{datum.value}}</th>
                </tr>
                </tbody>
            </table>
        </card>
    </div>
</template>

<script>
export default {
    metaInfo() {
        return {
          title: 'IndicatorExplorer',
         
        }
    },
    data(){
        return{
            loaded:false,
            selected_indicator:null,
            indicators:[],
            data:[],
        }
    },
    methods:{
       async getIndicators(){
           const { data } = await Nova.request().get(
        "/nova-vendor/indicator-explorer/get-indicators",
      );
      this.indicators=data
        },
        getEntrepriseIndicators(){
            Nova.request().post('/nova-vendor/indicator-explorer/entreprise-indicators', {indicator_id:this.selected_indicator}).then(({data}) => {
                this.data=data
                this.loaded = true
         })
        }
    },
    async mounted() {
        await this.getIndicators()
    },
}
</script>

<style>
/* Scoped Styles */
</style>
