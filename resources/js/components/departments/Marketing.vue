<template>
    <div>
        <Modal v-if="ad_modal">
            <template v-slot:content>
                <div class="flex flex-col gap-4 px-6">
                    <p class="text-xl text-vert font-semibold">
                        Nouvelle compagne
                    </p>
                    <!-- <p v-if="message != ''" class="text-green-500">
                        {{ message }}
                    </p> -->
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
                                        Média(Publicité télé et radio)
                                    </option>
                                    <option value="events">
                                        Sponsoriser un événement
                                    </option>
                                </select>
                            </div>
                            <div class="flex flex-col items-start gap-4">
                                <label for="days"> la durée en jours </label>
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
                                    Le résultat prévisionnel journalier
                                    (abonnés/jour)
                                </p>

                                <p
                                    class="border w-full h-10 flex items-center pl-4 text-jaune border-tableBorder"
                                >
                                    {{ predictedFollowers }}
                                </p>
                            </div>
                            <div class="flex flex-col items-start gap-4">
                                <p>Le résultat prévisionnel total(abonnés)</p>

                                <p
                                    class="border w-full h-10 flex items-center pl-4 text-jaune border-tableBorder"
                                >
                                    {{ totalPredictedFollowers }}
                                </p>
                            </div>
                            <div class="flex flex-col items-start gap-4">
                                <p>Le montant total (UM)</p>

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
                            :class="sent ? 'bg-gray-800' : 'hover:text-vert'"
                            @click="createAd"
                            :disabled="sent"
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
                v-for="(key, id) in Object.keys(indicators)"
                v-bind:key="id"
                :title="indicators[key].name"
                color="text-green-500"
                :icon="'/assets/icons/' + key + '.svg'"
                :value="[indicators[key].value]"
            ></StatCard>
        </div>
        <div v-if="mounted">
            <div class="py-12">
                <div class="w-full">
                    <div
                        v-if="ads.length == 0"
                        class="text-center flex flex-col items-center gap-4"
                    >
                        <p>
                            Il semble que vous n'aviez pas encore créer votre
                            première campagne publicitaire
                        </p>
                        <button
                            class="bg-gradient-to-t from-lightVert to-lighterVert hover:opacity-80 text-vN px-4 py-2 shadow-lg rounded-full text-center mx-auto"
                            @click="openModal"
                        >
                            Créer ma première compagne publicitaire
                        </button>
                    </div>
                    <div v-else class="flex flex-col gap-10">
                        <p class="font-medium text-vN text-xl">
                            Vous avez lancé
                            {{ ads.length }}
                            campagne(s) publicitaire(s)
                        </p>
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
                                        Mantant
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
                                        Durée en semaine
                                    </th>
                                    <th
                                        class="p-5 text-sm table-cell select-none cursor-pointer hover:text-vert"
                                        @click="sort('status')"
                                    >
                                        Status
                                    </th>
                                    <th
                                        class="p-5 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                        @click="sort('result')"
                                    >
                                        Résultat Prévisionnel/ Réel
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
                                        {{ ad.days }}
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
                                        {{ ad.result }}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <button
                            class="bg-gradient-to-t from-lightVert to-lighterVert hover:opacity-80 text-vN px-4 py-2 shadow-lg rounded-full text-center mx-auto"
                            @click="openModal"
                        >
                            Créer une compagne publicitaire
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div v-else>Veuillez attendre svp ...</div>
    </div>
</template>

<script>
import Modal from "../Modal.vue";
import StatCard from "./ui/StatCard.vue";
export default {
    props: ["entreprise", "ad_coef", "caisse"],
    components: { Modal, StatCard },
    name: "Marketing",
    data() {
        return {
            ads: [],
            mounted: false,
            ad_modal: false,
            message: "",
            indicators: [],
            error_message: "",
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
            sent: false,
            reverse: false,
        };
    },
    computed: {
        predictedFollowers: function () {
            if (this.new_ad.amount == null || this.new_ad.type == null) {
                return 0;
            }
            return parseInt(
                this.ad_coef *
                    this.type_coef[this.new_ad.type] *
                    this.new_ad.amount *
                    0.5
            );
        },
        totalPredictedFollowers() {
            if (this.notValidated()) {
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
            if (this.notValidated()) {
                return 0;
            }
            return this.new_ad.amount * this.new_ad.days;
        },
    },
    methods: {
        getAds() {
            axios
                .get("/api/marketing/get", {
                    params: { entreprise_id: this.entreprise.id },
                })
                .then((response) => {
                    this.ads = response.data;
                    this.mounted = true;
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
            this.message = "";
            this.error_message = "";
            this.new_ad.days = 0;
            this.new_ad.amount = 0;
            this.new_ad.type = "social";
            this.ad_modal = false;
        },
        notValidated() {
            return (
                this.new_ad.days == 0 ||
                this.new_ad.amount == 0 ||
                this.new_ad.type == null
            );
        },
        createAd() {
            if (!this.notValidated()) {
                if (this.caisse < this.total_amount) {
                    this.error_message =
                        "Vos disponibilités ne vous permettent pas de lancer la campagne";
                    return "";
                }
                this.new_ad.entreprise_id = this.entreprise.id;
                this.new_ad.result = this.predictedFollowers;
                this.new_ad.total_amount = this.total_amount;
                axios
                    .post("/api/marketing/create", this.new_ad)
                    .then((resp) => {
                        this.message = resp.data;
                        this.sent = true;
                        this.closeModal();
                        this.getAds();
                        // setTimeout(function () {
                        //     // location.reload();
                        // }, 5000);
                    });
            } else {
                this.error_message = "Veuillez remplire tous les champs";
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
    mounted() {
        this.getAds();
        this.getIndicators();
        window.Echo.channel("entreprise_" + this.entreprise.id)
            .listen("NewNotification", (e) => {
                if (e.notification.type == "AdStatusChanged") {
                    // let index = this.ads.findIndex(
                    //     (ad) => ad.ad_id == e.notification.data.id
                    // );
                    // this.ads[index].result = e.notification.data.result;
                    // this.ads[index].status = e.notification.data.status;

                    this.getAds();
                    this.$forceUpdate();

                    //this.ads.unshift(e.notification.data)
                }
            })
            .listen("NavbarDataChanged", (e) => {
                this.caisse = e.caisse;
            });
    },
};
</script>

<style></style>
