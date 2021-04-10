<template>
    <div>
        <heading class="mb-6">Indicator Updater</heading>

        <card
            class="bg-90 flex flex-col items-center justify-center bg-white"
            style="min-height: 300px"
        >
            <p>Choisissez l'indicateur a modifier</p>
            <select v-model="data.selected_indicator">
                <option  v-for="indicator in indicators" :key="indicator.code" :value="indicator.id">{{indicator.name}}</option>
            </select>
            <p>Entrez la valeur à mettre pour cet indicateur</p>
            <input v-model="data.value" type="text" name="value" class="w-full form-control form-input form-input-bordered pl-2"/>
            <div class="flex">
                <input type="checkbox" @change="checkboxChanged" :checked="data.has_notification" class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"> 
                <label class="ml-3">Envoyer une notification ?</label>
            </div>
             <p>Type de la notification</p>
             <select v-model="data.notification_type">
                <option  value="warning">Warning</option>
                <option  value="normal">Normal</option>
            </select>
            <p>Titre de la notification</p>
            <input type="text" v-model="data.title" class="w-full form-control form-input form-input-bordered pl-2"/>
            <p>Description de la notification</p>
            <input type="text" v-model="data.description" class="w-full form-control form-input form-input-bordered pl-2"/>
            <button @click="update" class="btn btn-default btn-primary mr-4">Send</button>
        </card>
    </div>
</template>

<script>
export default {
    metaInfo() {
        return {
          title: 'IndicatorUpdater',
        }
    },
    data(){
        return{
            indicators:[],
            data:{
                has_notification:false,
                notification_type:'',
                title:'',
                description:'',
                selected_indicator:null,
                value:null,
            }
           
        }
    },
    methods:{
        async getIndicators(){
           const { data } = await Nova.request().get(
        "/nova-vendor/indicator-updater/indicators",
      );
      this.indicators = data;
        },
        checkboxChanged(){
            this.has_notification=!this.has_notification
        },
        update(){
         Nova.request().post('/nova-vendor/indicator-updater/update-indicator', this.data).then(({data}) => {
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
