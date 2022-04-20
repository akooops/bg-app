<template>
    <div>
        <heading class="mb-6">Indicators</heading>

        <div class="flex">
            <div class="bg-90 bg-white p-6 w-1/2 mr-2">

                <div class="mb-6">
                    <p class="text-left mb-2">Indicateur à modifier:</p>
                    <select
                        v-model="selected_indicator"
                        class="w-1/3 form-control form-input form-input-bordered pl-2"
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

                <div class="mb-8">
                    <p class="text-left mb-2">Entreprise:</p>

                    <div class="ml-8 mb-2">
                        <button @click="checkAllEntrep" class="ml-4">
                            Select all
                        </button>
                        <button @click="uncheckAllEntrep" class="ml-4">
                            Unselect all
                        </button>
                    </div>

                    <div class="flex">
                        <div v-for="(entreprise, key) in entreprises" :key="key" class="ml-4">
                            <input
                                :id="entreprise.id" :value="entreprise.id" v-model="selected_entreprises" type="checkbox">
                            <label class="" for="entreprise.id"> {{ entreprise.name }} </label>
                        </div>
                    </div>
                </div>

                <div class="flex mb-6">
                    <div class="mr-8">
                        <p class="text-left mb-2 mr-4">Opération:</p>
                        <select
                            v-model="selected_operation"
                            class="form-control form-input form-input-bordered pl-2"
                        >
                            <option
                                v-for="(op, key) in operations"
                                :key="key"
                                :value="op['key']"
                            >
                                {{ op.name }}
                            </option>
                        </select>
                    </div>

                    <div class="mr-8">
                        <p class="text-left mb-2 mr-4">Valeur:</p>
                        <input
                            type="number"
                            v-model.number="operation_value"
                            :disabled="selected_operation=='reset'"
                            class="form-control form-input form-input-bordered pl-2">
                    </div>
                </div>

                <button @click="update" class="btn btn-default btn-primary mr-4">
                    Send
                </button>

                <!-- <div class="flex py-6">
                    <input
                        type="checkbox"
                        v-model="data.all_entreprises"
                        class="
                            focus:ring-gray-100
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
                </div> -->

                <!-- <select
                    v-model="data.selected_entreprise"
                    class="w-full form-control form-input form-input-bordered py-6"
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
                </button> -->
            </div>

            <div class="bg-90 bg-white p-6 w-1/2">
                <div class="">
                    <p class="text-left mb-2">Indicateur à afficher</p>
                    <select
                        v-model="selected_indicator_2"
                        @change="getEntrepriseIndicators"
                        class="w-1/3 form-control form-input form-input-bordered pl-2"
                    >
                        <option
                            v-for="indicator in indicators_2"
                            :key="indicator.code"
                            :value="indicator.id"
                            >{{ indicator.name }}</option
                        >
                    </select>
                </div>

                <table v-if="indicator_2_loaded" class="mt-4 w-full">
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
                        <tr v-for="datum in data" v-bind:key="datum.id">
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
            selected_indicator: null,

            entreprises: [],
            selected_entreprises: [],

            operations: [
                {'key': 'replace', 'name': 'Remplacer'},
                {'key': 'add', 'name': 'Ajouter'},
                {'key': 'mult', 'name': 'Multiplier'},
                {'key': 'reset', 'name': 'Réinitialiser'},
            ],
            selected_operation: 'replace',
            operation_value: 0,

            indicator_2_loaded: false,
            selected_indicator_2: null,
            indicators_2: [],
            data: [],
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

        update() {
            let req = {
                entreprise_ids: this.selected_entreprises,
                selected_indicator: this.selected_indicator,
                selected_operation: this.selected_operation,
                value: this.operation_value,
            };

            Nova.request()
                .post(
                    "/nova-vendor/indicator-updater/update-indicator",
                    req
                )
                .then(({ resp }) => {
                });
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
                    indicator_id: this.selected_indicator_2,
                })
                .then(({ data }) => {
                    this.data = data;
                    this.indicator_2_loaded = true;
                });
        },

        checkAllEntrep() {
            this.selected_entreprises = this.entreprises.map(x => x.id);
        },

        uncheckAllEntrep() {
            this.selected_entreprises = [];
        }

    },

    watch: {

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
