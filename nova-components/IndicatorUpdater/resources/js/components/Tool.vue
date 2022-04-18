<template>
    <div>
        <heading class="mb-6">Indicators</heading>

        <div class="flex grid grid-cols-2 gap-6 content-center">
            <div class="bg-90 bg-white p-6 w-1/2" style="min-height: 300px">

                <div class="py-5">
                    <p class="text-left">Choisissez l'indicateur a modifier</p>
                    <select
                        v-model="data.selected_indicator"
                        class="w-full form-control form-input form-input-bordered pl-2"
                    >
                        <option
                            v-for="indicator in indicators"
                            :key="indicator.code"
                            :value="indicator.id"
                        >
                            {{ indicator.name }}
                        </option>
                    </select>
                </div>

                <div class="py-5">
                    <p class="text-left">Choisissez l'entreprise</p>

                    <div class="flex flex-row flex-wrap">
                        <div v-for="(entreprise, key) in entreprises" :key="key" class="form-check form-check-inline">
                            <input
                                :id="entreprise.id" :value="entreprise" v-model="selected_entreprises" type="checkbox"
                            >
                            <label class="ml-10" for="entreprise.id"> {{ entreprise.name }} </label>
                        </div>
                    </div>

                    <p> {{selected_entreprises}} </p>
                </div>

                <div class="flex mt-5 mb-5">
                    <input
                        type="checkbox"
                        v-model="data.all_entreprises"
                        class="
                            focus:ring-gray-500
                            h-4
                            w-4
                            text-gray-600
                            border-gray-150
                            rounded
                        "
                    />
                    <label class="ml-3"
                        >Changer l'indicateur pour toutes les
                        entreprises?</label
                    >
                </div>

                <select
                    v-model="data.selected_entreprise"
                    class="w-full form-control form-input form-input-bordered pl-2"
                >
                    <option
                        v-for="entreprise in entreprises"
                        :key="entreprise.id"
                        :value="entreprise.id"
                    >
                        {{ entreprise.name }}
                    </option>
                </select>
                <div class="flex mt-4 mb-1">
                    <input
                        type="checkbox"
                        @change="replaceChanged"
                        :checked="data.replace"
                        class="
                            focus:ring-gray-500
                            h-4
                            w-4
                            text-gray-600
                            border-gray-150
                            rounded
                        "
                    />
                    <label class="ml-3"
                        >Mettre la valeur a la place ? (décochez si vous voulez
                        incrementer)</label
                    >
                </div>
                <p class="mt-4 mb-1">
                    Entrez la valeur à mettre pour cet indicateur
                </p>
                <input
                    v-model="data.value"
                    type="text"
                    name="value"
                    class="w-full form-control form-input form-input-bordered pl-2"
                />
                <p class="mt-4 mb-1">
                    Entrez la valeur à ajouter/diminuer pour cet indicateur
                </p>
                <input
                    v-model="data.increment"
                    type="text"
                    name="increment"
                    class="w-full form-control form-input form-input-bordered pl-2"
                />
                <div class="flex mt-4 mb-1">
                    <input
                        type="checkbox"
                        @change="rateChanged"
                        :checked="data.has_rate"
                        class="
                            focus:ring-gray-500
                            h-4
                            w-4
                            text-gray-600
                            border-gray-150
                            rounded
                        "
                    />
                    <label class="ml-3">Diminuer avec un pourcentage ?</label>
                </div>
                <p class="mt-4 mb-1">Entrez le pourcentage:</p>
                <p class="mb-1" style="text-color: red">
                    Warning: le pourcentage est utilisé dans le cas d'update de
                    toutes les entreprises, il est calculé avec la formule
                    (100-x)*0.01
                </p>
                <input
                    v-model="data.rate"
                    type="text"
                    name="value"
                    class="w-full form-control form-input form-input-bordered pl-2"
                />
                <div class="flex mt-4 mb-1">
                    <input
                        type="checkbox"
                        @change="checkboxChanged"
                        :checked="data.has_notification"
                        class="
                            focus:ring-gray-500
                            h-4
                            w-4
                            text-gray-600
                            border-gray-150
                            rounded
                        "
                    />
                    <label class="ml-3">Envoyer une notification ?</label>
                </div>
                <p class="mt-4 mb-1">Type de la notification</p>
                <select
                    v-model="data.notification_type"
                    class="w-full form-control form-input form-input-bordered pl-2"
                >
                    <option value="warning">Warning</option>
                    <option value="normal">Normal</option>
                </select>
                <p class="mt-4 mb-1">Titre de la notification</p>
                <input
                    type="text"
                    v-model="data.title"
                    class="w-full form-control form-input form-input-bordered pl-2"
                />
                <p class="mt-4 mb-1">Description de la notification</p>
                <input
                    type="text"
                    v-model="data.description"
                    class="
                        w-full
                        form-control form-input form-input-bordered
                        pl-2
                        mb-3
                    "
                />
                <button
                    @click="update"
                    class="btn btn-default btn-primary mr-4"
                >
                    Send
                </button>
            </div>

            <div class="bg-90 bg-white p-6 w-1/2" style="min-height: 300px">
                <p class="text-left">Choisissez l'indicateur à afficher</p>
                <select
                    v-model="selected_indicator"
                    @change="getEntrepriseIndicators"
                    class="w-full form-control form-input form-input-bordered pl-2"
                >
                    <option
                        v-for="indicator in indicators_2"
                        :key="indicator.code"
                        :value="indicator.id"
                        >{{ indicator.name }}</option
                    >
                </select>
                <table v-if="loaded" class="mt-4 w-full">
                    <thead>
                        <tr>
                            <th
                                class="w-1/3 p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300  "
                            >
                                Entreprise
                            </th>
                            <th
                                class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 "
                            >
                                Valeur
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="datum in data_2" v-bind:key="datum.id">
                            <th
                                class="p-3 font-bold text-gray-600 border border-gray-300  "
                            >
                                {{ datum.name }}
                            </th>
                            <th
                                class="p-3 font-bold  text-gray-600 border border-gray-300 "
                            >
                                {{ datum.value }}
                            </th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    metaInfo() {
        return {
            title: "IndicatorUpdater"
        };
    },
    data() {
        return {
            indicators: [],
            entreprises: [],
            data: {
                has_notification: false,
                notification_type: "",
                title: "",
                description: "",
                selected_indicator: null,
                selected_entreprises: [],
                increment: null,
                all_entreprises: false,
                value: null,
                replace: false,
                has_rate: false,
                rate: null
            },

            loaded: false,
            selected_indicator: null,
            indicators_2: [],
            data_2: [],
        };
    },
    methods: {
        async getIndicators() {
            const { data } = await Nova.request().get(
                "/nova-vendor/indicator-updater/indicators"
            );
            this.indicators = data["indicators"];
            this.entreprises = data["entreprises"];
        },
        checkboxChanged() {
            this.data.has_notification = !this.data.has_notification;
        },
        allChanged() {
            this.data.all_entreprises = !this.data.all_entreprises;
        },
        replaceChanged() {
            this.data.replace = !this.data.replace;
        },
        rateChanged() {
            this.data.has_rate = !this.data.has_rate;
        },
        update() {
            Nova.request()
                .post(
                    "/nova-vendor/indicator-updater/update-indicator",
                    this.data
                )
                .then(({ data }) => {});
        },

        async getIndicators_2() {
            const { data } = await Nova.request().get(
                "/nova-vendor/indicator-updater/get-indicators"
            );
            this.indicators_2 = data;
        },
        getEntrepriseIndicators() {
            Nova.request()
                .post("/nova-vendor/indicator-updater/entreprise-indicators", {
                    indicator_id: this.selected_indicator,
                })
                .then(({ data }) => {
                    this.data_2 = data;
                    this.loaded = true;
                });
        },
    },
    async mounted() {
        await this.getIndicators();
        await this.getIndicators_2();
    }
};
</script>

<style>
/* Scoped Styles */
</style>
