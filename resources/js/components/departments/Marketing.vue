<template>
    <div>
        <Modal v-if="ad_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Nouvelle compagne</h3>
                <p v-if="message != ''" class="text-green-500">{{ message }}</p>
                <p v-if="error_message != ''" class="text-red-600">
                    {{ error_message }}
                </p>
                <div class="relative h-10 input-component mb-3">
                    <label
                        for="amount"
                        class="left-2 transition-all bg-white px-1"
                    >
                        Budget journalier en DA
                    </label>
                    <input
                        id="amount"
                        type="number"
                        name="amount"
                        :min="0"
                        v-model="new_ad.amount"
                        class="h-full w-full rounded-sm"
                    />
                </div>
                <div class="mt-10 mb-3">
                    <label class="left-2 transition-all bg-white px-1"
                        >Type de campagne:
                    </label>
                    <select
                        v-model="new_ad.type"
                        class="h-full w-full rounded-sm"
                    >
                        <option value="social">Réseaux sociaux</option>
                        <option value="media">
                            Média(Publicité télé et radio)
                        </option>
                        <option value="events">Sponsoriser un événement</option>
                    </select>
                </div>
                <div class="flex pb-6 justify-center">
                    <label
                        for="days"
                        class="left-2 transition-all bg-white px-1"
                    >
                        Entrez la durée en jours
                    </label>
                    <input
                        id="days"
                        type="number"
                        name="days"
                        :min="0"
                        v-model="new_ad.days"
                        class="h-full w-full rounded-sm"
                    />
                </div>
                <p>
                    Le résultat prévisionnel journalier:
                    <span class="text-green-600"
                        >{{ predictedFollowers }} abonnés/jour</span
                    >
                </p>
                <p>
                    Le résultat prévisionnel total:
                    <span class="text-green-600"
                        >{{ totalPredictedFollowers }} abonnés</span
                    >
                </p>
                <p>
                    Le montant total de cette campagne s'élève à
                    <span class="text-yellow-500">{{ total_amount }} DA</span>
                </p>
                <div class="flex">
                    <button
                        class="text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"
                        :class="
                            sent
                                ? 'bg-gray-800'
                                : 'bg-green-400 hover:bg-green-800 '
                        "
                        @click="createAd"
                        :disabled="sent"
                    >
                        Créer
                    </button>
                    <button
                        class="
                            bg-gray-200
                            active:bg-gray-600
                            hover:bg-gray-400
                            text-back
                            px-3
                            py-2
                            rounded
                            w-1/2
                            mt-4
                        "
                        @click="closeModal"
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>
        <div class="flex">
            <StatCard
                class="mr-3"
                v-for="(key, id) in Object.keys(indicators)"
                v-bind:key="id"
                :title="indicators[key].name"
                color="text-green-500"
                :icon="icons[id]"
                :value="[indicators[key].value]"
            ></StatCard>
        </div>
        <div v-if="mounted">
            <div class="py-12">
                <div
                    class="
                        max-w-7xl
                        mx-auto
                        sm:px-6
                        lg:px-8
                        bg-white
                        overflow-hidden
                        sm:rounded-lg
                        p-6
                        bg-white
                    "
                >
                    <div v-if="ads.length == 0" class="text-center">
                        <p>
                            Il semble que vous n'aviez pas encore créer votre
                            première campagne publicitaire
                        </p>
                        <button
                            class="
                                bg-green-400
                                hover:bg-green-800
                                text-white
                                px-3
                                py-2
                                rounded
                                w-1/2
                                mt-4
                                mr-2
                            "
                            @click="openModal"
                        >
                            Créer ma première compagne publicitaire
                        </button>
                    </div>
                    <div v-else>
                        <div class="flex">
                            <p class="mt-2">
                                Vous avez lancé
                                <span class="font-bold">{{ ads.length }}</span>
                                campagne(s) publicitaire(s)
                            </p>
                            <div class="text-right mb-2 flex-1">
                                <button
                                    class="
                                        bg-green-400
                                        hover:bg-green-800
                                        text-white
                                        px-3
                                        py-2
                                        rounded
                                        text-right
                                    "
                                    @click="openModal"
                                >
                                    Créer une nouvelle compagne publicitaire
                                </button>
                            </div>
                        </div>
                        <table class="border-collapse w-full">
                            <thead>
                                <tr>
                                    <th
                                        class="
                                            p-3
                                            font-bold
                                            uppercase
                                            bg-gray-200
                                            text-gray-600
                                            border border-gray-300
                                            hidden
                                            lg:table-cell
                                        "
                                    >
                                        Type de campagne
                                    </th>
                                    <th
                                        class="
                                            p-3
                                            font-bold
                                            uppercase
                                            bg-gray-200
                                            text-gray-600
                                            border border-gray-300
                                            hidden
                                            lg:table-cell
                                        "
                                    >
                                        Montant
                                    </th>
                                    <th
                                        class="
                                            p-3
                                            font-bold
                                            uppercase
                                            bg-gray-200
                                            text-gray-600
                                            border border-gray-300
                                            hidden
                                            lg:table-cell
                                        "
                                    >
                                        Jour de création
                                    </th>
                                    <th
                                        class="
                                            p-3
                                            font-bold
                                            uppercase
                                            bg-gray-200
                                            text-gray-600
                                            border border-gray-300
                                            hidden
                                            lg:table-cell
                                        "
                                    >
                                        Durée en jours
                                    </th>
                                    <th
                                        class="
                                            p-3
                                            font-bold
                                            uppercase
                                            bg-gray-200
                                            text-gray-600
                                            border border-gray-300
                                            hidden
                                            lg:table-cell
                                        "
                                    >
                                        Statut
                                    </th>
                                    <th
                                        class="
                                            p-3
                                            font-bold
                                            uppercase
                                            bg-gray-200
                                            text-gray-600
                                            border border-gray-300
                                            hidden
                                            lg:table-cell
                                        "
                                    >
                                        Résultat prévisionnel/Réel
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="ad in ads"
                                    v-bind:key="ad.ad_id"
                                    class="
                                        bg-white
                                        lg:hover:bg-gray-100
                                        flex
                                        lg:table-row
                                        flex-row
                                        lg:flex-row
                                        flex-wrap
                                        lg:flex-no-wrap
                                        mb-10
                                        lg:mb-0
                                    "
                                >
                                    <td
                                        class="
                                            w-full
                                            lg:w-auto
                                            p-3
                                            text-gray-800 text-center
                                            border border-b
                                            block
                                            lg:table-cell
                                            relative
                                            lg:static
                                        "
                                    >
                                        {{ ad.ad_type }}
                                    </td>
                                    <td
                                        class="
                                            w-full
                                            lg:w-auto
                                            p-3
                                            text-gray-800 text-center
                                            border border-b
                                            block
                                            lg:table-cell
                                            relative
                                            lg:static
                                        "
                                    >
                                        {{ ad.amount }}
                                    </td>
                                    <td
                                        class="
                                            w-full
                                            lg:w-auto
                                            p-3
                                            text-gray-800 text-center
                                            border border-b
                                            block
                                            lg:table-cell
                                            relative
                                            lg:static
                                        "
                                    >
                                        {{ ad.creation_date }}
                                    </td>
                                    <td
                                        class="
                                            w-full
                                            lg:w-auto
                                            p-3
                                            text-gray-800 text-center
                                            border border-b
                                            block
                                            lg:table-cell
                                            relative
                                            lg:static
                                        "
                                    >
                                        {{ ad.days }}
                                    </td>
                                    <td
                                        class="
                                            w-full
                                            lg:w-auto
                                            p-3
                                            font-bold
                                            text-center
                                            border border-b
                                            block
                                            lg:table-cell
                                            relative
                                            lg:static
                                        "
                                        :class="
                                            ad.status == 'Terminé'
                                                ? 'text-green-600'
                                                : 'text-yellow-500'
                                        "
                                    >
                                        {{ ad.status }}
                                    </td>

                                    <td
                                        class="
                                            w-full
                                            lg:w-auto
                                            p-3
                                            text-gray-800
                                            font-bold
                                            text-center
                                            border border-b
                                            block
                                            lg:table-cell
                                            relative
                                            lg:static
                                        "
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
                days: null,
                amount: null,
                type: null,
            },
            icons: ["fa-users", "fa-hashtag", "fa-tv", "fa-calendar-week"],
            sent: false,
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
            this.errr_messsage = "";
            this.ad_modal = false;
        },
        notValidated() {
            return (
                this.new_ad.days == null ||
                this.new_ad.amount == null ||
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
                        setTimeout(function () {
                            this.modal = false;
                            location.reload();
                        }, 5000);
                    });
            } else {
                this.error_message = "Veuillez remplire tous les champs";
            }
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

<style>
</style>
