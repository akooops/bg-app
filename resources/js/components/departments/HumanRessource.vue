<template>
    <div>
        <div
            v-if="show_success"
            class="
                my-2
                bg-green-100
                border border-green-400
                text-green-700
                px-4
                py-3
                rounded
                relative
            "
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
            class="
                bg-red-100
                border border-red-400
                text-red-700
                px-4
                py-3
                rounded
                relative
            "
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

        <Modal v-if="workers_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Recrutement employés</h3>

                <div class="relative h-10 input-component mb-3">
                    <label
                        for="workers"
                        class="left-2 transition-all bg-white px-1"
                    >
                        Entrez le nombre d'employés à recruter
                    </label>
                    <input
                        id="workers"
                        type="number"
                        name="workers"
                        v-model="workers"
                        class="h-full w-full rounded-sm"
                        min="1"
                    />
                </div>

                <p class="mt-10">
                    Le salaire mensuel d'un seul employé est fixé a :
                    <span class="text-yellow-600 font-bold">{{ salary }}</span>
                </p>

                <p>
                    Le salaire pour le nombre d'employés choisis est fixé a :
                    <span class="text-green-700 font-bold">
                        {{ salary * workers }}
                    </span>
                </p>

                <div class="flex">
                    <button
                        class="text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"
                        :class="
                            hire_sent
                                ? 'bg-gray-800 '
                                : 'bg-green-400 hover:bg-green-800'
                        "
                        :disabled="hire_sent"
                        @click="hireWorker"
                    >
                        Recruter
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
                        @click="workers_modal = false"
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>
        <Modal v-if="workshop_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Formation employés</h3>

                <p>Sélectionnez le nombre d'employés à former:</p>

                <input
                    v-model="nb_workers_to_train"
                    class="mx-4 w-2/3"
                    type="number"
                    min="1"
                    :max="indicators['nb_workers_lv1']['value']"
                />

                <p class="mt-6">
                    Le prix de la formation est fixé a :
                    <span class="text-green-700 font-bold"
                        >{{ workshop_price }} / personne</span
                    >
                </p>

                <p class="mt-4">
                    Le prix total est fixé à:
                    <span class="text-green-700 font-bold"
                        >{{
                            workshop_price * nb_workers_to_train
                        }}
                    </span>
                </p>

                <div class="flex">
                    <button
                        class="text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"
                        :class="
                            workshop_sent
                                ? 'bg-gray-800 '
                                : 'bg-green-400 hover:bg-green-800'
                        "
                        :disabled="workshop_sent"
                        @click="launchWorkshop"
                    >
                        Lancer la formation
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
                        @click="closeWorkShopModal"
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>
        <Modal v-if="prime_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Prime pour les employés</h3>
                <p v-if="message != ''" class="text-green-500">{{ message }}</p>
                <p v-if="error_message != ''" class="text-red-600">
                    {{ error_message }}
                </p>
                <div class="relative h-10 input-component mb-3">
                    <label
                        for="prime"
                        class="left-2 transition-all bg-white px-1"
                    >
                        Entrez le montant de la prime
                    </label>
                    <input
                        id="prime"
                        type="number"
                        name="prime"
                        v-model="prime"
                        :min="0"
                        class="h-full w-full rounded-sm"
                    />
                </div>
                <p class="mt-10">
                    Le montant total est :
                    <span class="text-yellow-600 font-bold">{{
                        prime * indicators["nb_workers"]["value"]
                    }}</span>
                </p>
                <p class="mt-10">
                    L'humeur des employés augmentera avec :
                    <span class="text-green-600 font-bold"
                        >+{{ expected_mood }}</span
                    >
                </p>
                <div class="flex">
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
                        :class="
                            prime_sent
                                ? 'bg-gray-800 '
                                : 'bg-green-400 hover:bg-green-800'
                        "
                        :disabled="prime_sent"
                        @click="primeWorkers"
                    >
                        Valider
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
                        @click="closePrimeModal"
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>

        <!-- Adding some details -->
        <div class="flex">
            <StatCard
                class="mr-5 h-96"
                v-for="(key, id) in stat_indicators"
                v-bind:key="id"
                :title="indicators[key].name"
                color="text-green-500"
                :icon="icons[id]"
                :value="[indicators[key].value]"
            ></StatCard>
            <div class="w-96 shadow-md rounded-lg text-center mr-5">
                <speedo-meter
                    :data="[
                        { value: indicators['workers_mood'].value, name: '' },
                    ]"
                    class="h-64"
                ></speedo-meter>
                <p class="">Humeur des employés</p>
            </div>
            <div class="w-96 shadow-md rounded-lg text-center">
                <speedo-meter
                    :data="[
                        {
                            value: indicators['productivity_coeff'].value,
                            name: '',
                        },
                    ]"
                ></speedo-meter>
                <p class="">Productivité</p>
            </div>
        </div>
        <h3 class="mt-10 font-bold text-md">Actions:</h3>
        <div class="mt-6 flex">
            <button
                @click="openWorkersModal"
                class="
                    bg-green-400
                    hover:bg-green-800
                    text-white
                    px-3
                    py-2
                    rounded
                    mr-5
                "
            >
                Recruter des employés
            </button>
            <button
                @click="openWorkShopModal"
                class="
                    bg-green-400
                    hover:bg-green-800
                    text-white
                    px-3
                    py-2
                    rounded
                    mr-5
                "
            >
                Former les employés
            </button>
            <button
                @click="openPrimeModal"
                class="
                    bg-green-400
                    hover:bg-green-800
                    text-white
                    px-3
                    py-2
                    rounded
                    mr-5
                "
            >
                Ajouter une prime aux employés
            </button>
        </div>
    </div>
</template>

<script>
import SpeedoMeter from "./ui/SpeedoMeter.vue";
import StatCard from "./ui/StatCard.vue";
import Modal from "../Modal";
export default {
    props: ["entreprise", "salary", "workshop_price", "caisse"],
    components: {
        SpeedoMeter,
        StatCard,
        Modal,
    },
    name: "HumanRessource",
    data() {
        return {
            indicators: [],
            mounted: false,
            stat_indicators: ["nb_workers_lv1"],
            icons: ["fa-users"],
            workers_modal: false,
            workers: 1,
            message: "",
            error_message: "",
            nb_workers_to_train: 0,
            workshop_modal: false,
            prime_modal: false,
            prime: null,
            prime_sent: false,
            workshop_sent: false,
            hire_sent: false,
            show_success: false,
            show_error: false,
        };
    },
    computed: {
        expected_mood() {
            let result = (this.prime * 0.01) / 100;
            if (this.indicators["workers_mood"].value + result > 1) {
                this.error_message =
                    "Vous allez perdre de l'argent car l'humeur des employés ne pourra pas dépasser 1";
                return 1 - this.indicators["workers_mood"].value;
            }
            this.error_message = "";
            return parseFloat(result).toFixed(2);
        },
    },
    methods: {
        openWorkersModal() {
            this.workers_modal = true;
        },
        openWorkShopModal() {
            this.workshop_modal = true;
        },
        closeWorkShopModal() {
            this.workshop_modal = false;
            this.message = "";
            this.error_message = "";
        },
        openPrimeModal() {
            this.prime_modal = true;
        },
        closePrimeModal() {
            this.prime_modal = false;
            this.message = "";
            this.error_message = "";
        },

        launchWorkshop() {
            this.message = "";
            this.error_message = "";
            if (
                this.workshop_price * this.indicators["nb_workers"]["value"] >
                this.caisse
            ) {
                this.error_message =
                    "Vos disponibilités ne vous permettent pas de lancer la formation";
                return "";
            } else if (this.indicators["productivity_coeff"].value + 0.25 > 1) {
                this.error_message =
                    "Vous allez perdre de l'argent car le coefficient de productivité a atteint son maximum";
                return "";
            }
            this.workshop_sent = true;
            axios
                .post("/api/entreprise/hr/launch-workshop", {
                    entreprise_id: this.entreprise.id,
                })
                .then((resp) => {
                    this.message = resp.data;
                    setTimeout(function () {
                        window.location.href =
                            "/entreprise/department/Ressources Humaines";
                    }, 4000);
                });
        },
        primeWorkers() {
            this.message = "";
            this.error_message = "";
            if (
                this.prime * this.indicators["nb_workers"]["value"] >
                this.caisse
            ) {
                this.error_message =
                    "Vos disponibilités ne vous permettent pas de donner cette prime";
                return "";
            }
            axios
                .post("/api/entreprise/hr/prime-workers", {
                    entreprise_id: this.entreprise.id,
                    prime: this.prime,
                    mood: this.expected_mood,
                })
                .then((resp) => {
                    this.message = resp.data;
                    this.prime_sent = true;
                    setTimeout(function () {
                        window.location.href =
                            "/entreprise/department/Ressources Humaines";
                    }, 3000);
                });
        },
        hireWorker() {
            this.hire_sent = true;
            axios
                .post("/api/entreprise/hr/hire", {
                    workers: this.workers,
                    entreprise_id: this.entreprise.id,
                })
                .then((resp) => {
                    if (resp.data.success) {
                        this.show_success = true;
                        this.show_error = false;
                    } else {
                        this.show_success = false;
                        this.show_error = true;
                    }

                    this.message = resp.data.message;

                    this.hire_sent = false;
                    this.workers_modal = false;
                });
        },
        getIndiators() {
            axios
                .get("/api/entreprise/hr/indicators", {
                    params: { entreprise_id: this.entreprise.id },
                })
                .then((resp) => {
                    this.indicators = resp.data;
                    this.mounted = true;
                });
        },
    },
    mounted() {
        this.getIndiators();

        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NewNotification",
            (e) => {
                if (e.notification.type == "EmployeesHired") {
                    this.getIndiators();
                    this.$forceUpdate();
                }
            }
        );

        window.Echo.channel("entreprise_" + this.entreprise.id).listen(
            "NavbarDataChanged",
            (e) => {
                this.caisse = e.caisse;
            }
        );
    },
};
</script>

<style>
</style>