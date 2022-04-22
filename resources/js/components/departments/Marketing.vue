<template>
    <div>
        <div
            v-if="show_success"
            class="my-2 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative"
            role="alert"
        >
            <strong class="font-bold">{{ message }}</strong>

            <span
                @click="show_success = false"
                class="absolute top-0 bottom-0 right-0 px-4 py-3"
            >
                <svg
                    class="fill-current h-6 w-6 text-green-500"
                    role="button"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                >
                    <title>Close</title>
                    <path
                        d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10    11.819l-2.651 3.029a1.2 1.2 0 1   1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1     1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697    1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"
                    />
                </svg>
            </span>
        </div>

        <div
            v-if="show_error"
            class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative"
            role="alert"
        >
            <strong class="font-bold">{{ message }}</strong>

            <span
                @click="show_error = false"
                class="absolute top-0 bottom-0 right-0 px-4 py-3"
            >
                <svg
                    class="fill-current h-6 w-6 text-red-500"
                    role="button"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                >
                    <title>Close</title>
                    <path
                        d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10    11.819l-2.651 3.029a1.2 1.2 0 1   1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1     1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697    1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"
                    />
                </svg>
            </span>
        </div>

        <Modal v-if="ad_modal">
            <template v-slot:content>
                <div class="flex flex-col gap-4 px-6">
                    <p class="text-xl text-vert font-semibold">
                        Nouvelle compagne
                    </p>
                    <p v-if="error_message != ''" class="text-red-600">
                        {{ error_message }}
                    </p>
                    <div class="flex items-start gap-44">
                        <div class="flex flex-col items-start gap-4">
                            <div class="flex flex-col items-start gap-4">
                                <label for="amount">
                                    Budget journalier en DA
                                </label>
                                <input
                                    id="amount"
                                    type="number"
                                    name="amount"
                                    :min="0"
                                    :step="1000"
                                    v-model="new_ad.amount"
                                    class="text-bleu font-normal w-full rounded-sm ring-1 ring-tableBorder border-0 focus-within:ring-vert"
                                />
                            </div>
                            <div class="flex flex-col items-start gap-4">
                                <label class="">Type de campagne: </label>
                                <select
                                    v-model="new_ad.type"
                                    class="text-bleu font-normal w-11/12 rounded-sm ring-1 ring-tableBorder border-0 focus-within:ring-vert"
                                >
                                    <option value="social">
                                        Réseaux sociaux
                                    </option>
                                    <option value="media">
                                        Média (Publicité télé et radio)
                                    </option>
                                    <option value="events">
                                        Sponsoriser un évènement
                                    </option>
                                </select>
                            </div>
                            <div class="flex flex-col items-start gap-4">
                                <label for="days"> Durée (sem) </label>
                                <input
                                    id="days"
                                    type="number"
                                    name="days"
                                    :min="0"
                                    v-model="new_ad.days"
                                    class="text-vert font-normal w-1/3 rounded-sm ring-1 ring-tableBorder border-0 focus-within:ring-vert"
                                />
                            </div>
                        </div>
                        <div class="flex flex-col gap-4">
                            <div class="flex flex-col items-start gap-4">
                                <p>
                                    Résultat prévisionnel hebdomadaire (abonnés/sem)
                                </p>

                                <p
                                    class="border w-full h-10 flex items-center pl-4 text-jaune border-tableBorder"
                                >
                                    {{ predictedFollowers }}
                                </p>
                            </div>
                            <div class="flex flex-col items-start gap-4">
                                <p>Résultat prévisionnel total (abonnés)</p>

                                <p
                                    class="border w-full h-10 flex items-center pl-4 text-jaune border-tableBorder"
                                >
                                    {{ totalPredictedFollowers }}
                                </p>
                            </div>
                            <div class="flex flex-col items-start gap-4">
                                <p>Montant total (DA)</p>

                                <p
                                    class="border w-full h-10 flex items-center pl-4 text-jaune border-tableBorder"
                                >
                                    {{ total_amount }}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="flex items-center gap-4 self-end mt-4">
                        <button
                            class="text-vN font-normal px-3 py-2 rounded"
                            :class="can_create ? 'hover:text-vert' : 'bg-gray-800'"
                            :disabled="!can_create"
                            @click="
                                createAd();
                                closeModal();
                            "
                        >
                            Confirmer
                        </button>
                        <button
                            class="hover:text-black text-vN text-opacity-80 px-3 py-2 rounded"
                            @click="closeModal"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>
        <div class="flex gap-10">
                <StatCard
                    v-for="(key, id) in Object.keys(indicators).filter(x => x != 'ca')" v-bind:key="id"
                    :title="indicators[key].name"
                    color="text-green-500"
                    :icon="'/assets/icons/' + key + '.svg'"
                    :value="[Math.round(indicators[key].value * 100) / 100]"
                ></StatCard>
        </div>
        <div v-if="ads_loaded">
            <div class="py-12">
                <div class="w-full">
                    <div
                        v-if="ads.length == 0"
                        class="text-center flex flex-col items-center gap-4"
                    >
                        <p>
                            Il semble que vous n'ayez pas encore créé votre
                            première campagne publicitaire
                        </p>
                        <button
                            class="bg-gradient-to-t from-lightVert to-lighterVert hover:opacity-80 text-vN px-4 py-2 shadow-lg rounded-full text-center mx-auto"
                            @click="openModal"
                        >
                            Créer ma première campagne publicitaire
                        </button>
                    </div>
                    <div v-else class="flex flex-col gap-10">
                        <p class="font-medium text-vN text-xl">
                            Vous avez lancé
                            {{ ads.length }}
                            campagne(s) publicitaire(s)
                        </p>

                        <p class="text-red-800" v-if="ads.length > 0">
                            Risque de scandale médiatique actuel: {{ scandal_risk }}%
                        </p>

                        <button
                            class="bg-gradient-to-t from-lightVert to-lighterVert hover:opacity-80 text-vN px-4 py-2 shadow-lg rounded-full text-center mx-auto"
                            @click="openModal"
                        >
                            Créer une campagne publicitaire
                        </button>

                        <table class="w-full border-collapse">
                            <thead
                                class="sticky top-0 border-b border-t border-tableBorder bg-white font-medium text-vN"
                            >
                                <tr>
                                    <th
                                        class="p-5 text-sm select-none cursor-pointer hover:text-vert"
                                        @click="sort('ad_type')"
                                    >
                                        Type de campagne
                                    </th>
                                    <th
                                        class="p-5 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                        @click="sort('amount')"
                                    >
                                        Montant
                                    </th>
                                    <th
                                        class="p-5 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                        @click="sort('creation_date')"
                                    >
                                        Semaine de création
                                    </th>
                                    <th
                                        class="p-5 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                        @click="sort('days')"
                                    >
                                        Semaine de fin
                                    </th>
                                    <th
                                        class="p-5 text-sm table-cell select-none cursor-pointer hover:text-vert"
                                        @click="sort('status')"
                                    >
                                        Status
                                    </th>
                                    <th
                                        class="p-5 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                        @click="sort('predicted_result')"
                                    >
                                        Résultat Prévu
                                    </th>
                                    <th
                                        class="p-5 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                        @click="sort('result')"
                                    >
                                        Résultat Actuel
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="ad in ads"
                                    v-bind:key="ad.ad_id"
                                    class="bg-white flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-tableBorder text-vN font-light text-sm h-14"
                                >
                                    <td
                                        class="p-1 text-center block lg:table-cell relative lg:static"
                                    >
                                        {{ ad.ad_type }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                    >
                                        {{ ad.amount }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                    >
                                        {{ ad.creation_date }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                    >
                                        {{ ad.creation_date + ad.days }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                        :class="
                                            ad.status == 'Terminé'
                                                ? 'text-vert'
                                                : 'text-jaune'
                                        "
                                    >
                                        {{ ad.status }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                    >
                                        {{ ad.predicted_result }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                    >
                                        {{ ad.result }}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div v-else class="flex flex-col items-center mt-16">
             <img class="w-16 h-16 load" src="/assets/logo/bg_logo.svg" alt="">
        <div class="text-vN pt-2 font-semibold">Chargement... </div>
        </div>
    </div>
</template>

<script>
import Modal from "../Modal.vue";
import StatCard from "./ui/StatCard.vue";
export default {
    props: ["entreprise", "ad_coef"],
    components: { Modal, StatCard },
    name: "Marketing",
    data() {
        return {
            ads: [],
            ads_loaded: false,

            ad_modal: false,

            message: "",
            error_message: "",

            indicators: [],

            type_coef: {
                social: 1.2,
                media: 0.8,
                events: 1,
            },

            new_ad: {
                days: 0,
                amount: 0,
                type: "social",
            },

            icons: ["fa-users", "fa-hashtag", "fa-tv", "fa-calendar-week"],

            reverse: false,

            caisse: 0,

            show_success: false,
            show_error: false,
        };
    },
    computed: {
        predictedFollowers: function () {
            if (!this.can_create) {
                return 0;
            }

            return parseInt(
                this.ad_coef * this.type_coef[this.new_ad.type] * this.new_ad.amount * 0.5
            );
        },
        totalPredictedFollowers() {
            if (!this.can_create) {
                return 0;
            }
            return parseInt(
                this.ad_coef *
                    this.type_coef[this.new_ad.type] *
                    this.new_ad.amount *
                    this.new_ad.days *
                    0.5
            );
        },
        total_amount() {
            if (!this.can_create) {
                return 0;
            }
            return this.new_ad.amount * this.new_ad.days;
        },
        can_create() {
            this.error_message = "";

            if (this.caisse < this.new_ad.amount * this.new_ad.days) {
                this.error_message = "Vos disponibilités ne vous permettent pas de lancer la campagne";
                return false;
            }

            if(this.new_ad.amount <= 0) {
                this.error_message = "La somme versée doit être positive";
                return false;
            }

            if(this.new_ad.days <= 0) {
                this.error_message = "La durée doit être positive";
                return false;
            }

            if(!['social', 'media', 'events'].includes(this.new_ad.type)) {
                this.error_message = "Le type spécifié est erroné";
                return false;
            }

            return true;
        },

        scandal_risk() {
            if (this.indicators.length == 0) {
                return 0;
            }

            let pending_ads = this.ads.filter(ad => ad.status == "En cours");

            let sum = 0;

            pending_ads.map(x => sum += x.amount * x.days);

            let x = this.indicators["ca"].value > 0 ? sum / this.indicators["ca"].value : 0;

            if (x > 0.1) {
                return Math.min( Math.round(Math.sqrt(x / 77) * 100) / 100 , 1) * 100;
            }
            else {
                return 0
            }
        }
    },
    methods: {
        getAds() {
            axios
                .get("/api/marketing/get", {
                    params: { entreprise_id: this.entreprise.id },
                })
                .then((response) => {
                    this.ads = response.data;
                    this.ads_loaded = true;
                })
                .catch(function (error) {});
        },
        getIndicators() {
            // Numbers to show in cards
            axios
                .get("/api/entreprise/marketing/indicators", {
                    params: {
                        entreprise_id: this.entreprise.id,
                    },
                })
                .then((resp) => {
                    this.indicators = resp.data;
                    //this.show_stat_cards = true
                });
        },
        openModal() {
            this.ad_modal = true;
        },
        closeModal() {
            this.error_message = "";
            this.new_ad.days = 0;
            this.new_ad.amount = 0;
            this.new_ad.type = "social";
            this.ad_modal = false;
        },
        createAd() {
            if (this.can_create) {
                this.new_ad.entreprise_id = this.entreprise.id;
                this.new_ad.result = this.totalPredictedFollowers;
                this.new_ad.total_amount = this.total_amount;

                axios
                    .post("/api/marketing/create", this.new_ad)
                    .then((resp) => {
                        if (resp.data.success) {
                            this.show_success = true;
                            this.show_error = false;
                        } else {
                            this.show_success = false;
                            this.show_error = true;
                        }

                        this.message = resp.data.message;
                    });
            }
        },
        sort(key) {
            this.reverse = !this.reverse;
            this.ads.sort((a, b) => {
                if (a[key] < b[key]) {
                    return this.reverse ? -1 : 1;
                }
                if (a[key] > b[key]) {
                    return this.reverse ? 1 : -1;
                }
                return 0;
            });
        },
    },
    created() {
        axios
            .get("/api/navbar", {
                params: {
                    entreprise_id: this.entreprise.id,
                    type: this.entreprise.type,
                },
            })
            .then((resp) => {
                this.caisse = resp.data["caisse"];
            });
    },
    mounted() {
        this.getAds();
        this.getIndicators();
        window.Echo.channel("entreprise_" + this.entreprise.id)
            .listen("NewNotification", (e) => {
                if (e.notification.type == "AdsUpdate") {
                    this.getAds();
                    this.getIndicators();
                    this.$forceUpdate();
                }

                if (e.notification.type == "AdminNotif") {
                    this.getAds();
                    this.getIndicators();
                    this.$forceUpdate();
                }
            })
            .listen("NavbarDataChanged", (e) => {
                this.caisse = e.caisse;
            });
    },
};
</script>

<style></style>
