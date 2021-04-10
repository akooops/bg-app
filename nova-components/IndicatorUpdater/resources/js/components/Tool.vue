<template>
    <div>
        <heading class="mb-6">Indicator Updater</heading>

        <card
            class="bg-90 flex flex-col  bg-white p-6"
            style="min-height: 300px"
        >
            <p class="text-left">Choisissez l'indicateur a modifier</p>
            <select v-model="data.selected_indicator" class="w-full form-control form-input form-input-bordered pl-2"> 
                <option  v-for="indicator in indicators" :key="indicator.code" :value="indicator.id">{{indicator.name}}</option>
            </select>
             <div class="flex mt-4  mb-1">
                <input type="checkbox" @change="allChanged" :checked="data.all_entreprises" class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"> 
                <label class="ml-3">Changer l'indicateur pour toutes les entreprises?</label>
            </div>
            <p class="text-left">Choisissez l'entreprise</p>
            <select v-model="data.selected_entreprise" class="w-full form-control form-input form-input-bordered pl-2"> 
                <option  v-for="entreprise in entreprises" :key="entreprise.id" :value="entreprise.id">{{entreprise.name}}</option>
            </select>
             <div class="flex mt-4  mb-1">
                <input type="checkbox" @change="replaceChanged" :checked="data.replace" class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"> 
                <label class="ml-3">Mettre la valeur a la place ? (décochez si vous voulez incrementer)</label>
            </div>
            <p class="mt-4  mb-1">Entrez la valeur à mettre pour cet indicateur</p>
            <input v-model="data.value" type="text" name="value" class="w-full form-control form-input form-input-bordered pl-2"/>
            <p class="mt-4  mb-1">Entrez la valeur à ajouter/diminuer pour cet indicateur</p>
            <input v-model="data.increment" type="text" name="increment" class="w-full form-control form-input form-input-bordered pl-2"/>
            <div class="flex mt-4  mb-1">
                <input type="checkbox" @change="checkboxChanged" :checked="data.has_notification" class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"> 
                <label class="ml-3">Envoyer une notification ?</label>
            </div>
             <p class="mt-4  mb-1">Type de la notification</p>
             <select v-model="data.notification_type" class="w-full form-control form-input form-input-bordered pl-2">
                <option  value="warning">Warning</option>
                <option  value="normal">Normal</option>
            </select>
            <p class="mt-4 mb-1">Titre de la notification</p>
            <input type="text" v-model="data.title" class="w-full form-control form-input form-input-bordered pl-2"/>
            <p class="mt-4  mb-1">Description de la notification</p>
            <input type="text" v-model="data.description" class="w-full form-control form-input form-input-bordered pl-2  mb-3"/>
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
            entreprises:[],
            data:{
                has_notification:false,
                notification_type:'',
                title:'',
                description:'',
                selected_indicator:null,
                selected_entreprise:null,
                increment:null,
                all_entreprises:false,
                value:null,
                replace:false,
            }
           
        }
    },
    methods:{
        async getIndicators(){
           const { data } = await Nova.request().get(
        "/nova-vendor/indicator-updater/indicators",
      );
      this.indicators = data['indicators']
      this.entreprises = data['entreprises']
        },
        checkboxChanged(){
            this.data.has_notification=!this.data.has_notification
        },
        allChanged(){
            this.data.all_entreprises=!this.data.all_entreprises
        },
        replaceChanged(){
            this.data.replace=!this.data.replace
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
