<template>
    <div>
        <div class="w-full">
            <nav class="mb-10 text-lg flex justify-start gap-8">
                <button
                    @click="page_index = 'indicators'"
                    :class="
                        page_index == 'indicators'
                            ? 'border-b-2 border-vert text-vert font-medium'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg"
                >
                    Indicateurs
                </button>

                <button
                    @click="page_index = 'settings'"
                    :class="
                        page_index == 'settings'
                            ? 'border-b-2 border-vert text-vert font-medium'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg"
                >
                    Paramètres du jeu
                </button>
            </nav>
        </div>

        <div v-if="page_index == 'indicators'" class="flex">
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
                            {{ indicator.code }} |------| {{ indicator.name }}
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

                <button
                    v-if="selected_indicator != null && selected_entreprises.length > 0"
                    @click="show_confirmation_modal = true"
                    class="btn btn-default btn-primary mr-4"
                >
                    Send
                </button>
            </div>

            <Modal v-if="show_confirmation_modal" class="pt-44">
                <template v-slot:content>
                    <div class="flex flex-col gap-2">
                        <p>Confirmer l'action ?</p>
                        <div class="flex gap-5">
                            <button @click="update_indicator" v-if="!update_indicators_sent" class="bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white">
                                Confirmer
                            </button>
                            <button @click="show_confirmation_modal = false" class="bg-white border-vert border-2 rounded-md px-3 py-1 text-black">
                                Annuler
                            </button>
                        </div>
                    </div>
                </template>
            </Modal>

            <div class="bg-90 bg-white p-6 w-1/2">
                <div class="">
                    <p class="text-left mb-2">Indicateur à afficher</p>
                    <select
                        v-model="selected_indicator_2"
                        @change="getEntrepriseIndicators"
                        class="w-1/3 form-control form-input form-input-bordered pl-2"
                    >
                        <option
                            v-for="indicator in indicators"
                            :key="indicator.code"
                            :value="indicator.id"
                        >
                            {{ indicator.code }} |------| {{ indicator.name }}
                        </option>
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
                                class="p-3 font-bold text-gray-600 border border-gray-300 "
                            >
                                {{ datum.value }}
                            </th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div v-if="page_index == 'settings'" class="flex justify-center">
            <GameSettings>

            </GameSettings>
        </div>
    </div>
</template>

<script>
import Modal from "./Modal";
import GameSettings from "./GameSettings";
export default {
    metaInfo() {
        return {
            title: "IndicatorUpdater"
        };
    },
    components: { Modal, GameSettings },
    data() {
        return {
            page_index: 'indicators',

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
            data: [],

            show_confirmation_modal: false,
            update_indicators_sent: false,

            settings: [],
            selected_setting: null,
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

        update_indicator() {
            let req = {
                entreprise_ids: this.selected_entreprises,
                selected_indicator: this.selected_indicator,
                selected_operation: this.selected_operation,
                value: this.operation_value,
            };

            this.uncheckAllEntrep();
            this.selected_indicator = null;
            this.selected_operation = 'replace';
            this.operation_value = 0;

            this.show_confirmation_modal = false;
            this.update_indicators_sent = true;

            Nova.request()
                .post(
                    "/nova-vendor/indicator-updater/update-indicator",
                    req
                )
                .then(({ resp }) => {
                    this.update_indicators_sent = true;
                });
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
    }
};
</script>

<style>
/* Scoped Styles */
</style>
