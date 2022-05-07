<template>
    <div>
        <!-- <div
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
        </div> -->
        <Modal
            v-if="hire_modal"
            class="align-center openmodal"
            custom_css="w-1/3"
        >
            <template v-slot:content>
                <div class="flex flex-col text-vN px-5 gap-4">
                    <h1 class="text-center text-vert text-2xl">
                        Recrutement des employées
                    </h1>
                    <div>
                        <h1
                            class="text-md font-heading font-medium text-lg text-nav mb-2"
                        >
                            Entrez le nombre des employées à recruter :
                        </h1>
                        <input
                            id="workers"
                            type="number"
                            name="workers"
                            v-model="nb_workers_to_hire"
                            class="rounded-sm py-3 w-1/2"
                            min="1"
                        />
                    </div>
                    <div>
                        <h1 class="pt-3 opacity-80">
                            le salaire mensuel d'un seul employé est fixé à :
                            <span class="text-yellow-600"
                                >{{ salary_lv1 }} DA</span
                            >
                        </h1>
                        <h1 class="opacity-80">
                            le salaire mensule pour le nombre d'employés choisis
                            est fixé à :
                            <span class="text-vert">
                                {{ salary_lv1 * nb_workers_to_hire }} DA</span
                            >
                        </h1>
                    </div>

                    <div
                        class="w-full flex items-center gap-4 justify-end mt-5"
                    >
                        <button
                            class="font-medium font-heading border-0 px-3 py-1 text-vN hover:text-vert bg-opacity-30"
                            :class="hire_sent ? 'opacity-50' : ''"
                            :disabled="hire_sent"
                            @click="hireWorker"
                        >
                            Valider
                        </button>
                        <button
                            class="font-medium font-heading px-3 py-1 text-vN opacity-80 hover:opacity-100"
                            @click="hire_modal = false"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>
        <Modal
            v-if="workshop_modal"
            class="align-center openmodal"
            custom_css="w-1/3"
        >
            <template v-slot:content>
                <div class="flex flex-col text-vN px-5 gap-4">
                    <h1 class="text-center text-vert text-2xl">
                        Formation des employées
                    </h1>
                    <div>
                        <h1
                            class="text-md font-heading font-medium text-lg text-nav mb-2"
                        >
                            Entrez le nombre des employées à former :
                        </h1>
                        <input
                            v-model="nb_workers_to_train"
                            class="w-2/3"
                            type="number"
                            min="1"
                            :max="
                                indicators['nb_workers_lv1']['value'] -
                                indicators['nb_workers_lv1_busy']['value']
                            "
                        />
                    </div>
                    <div>
                        <h1 class="pt-3 opacity-80">
                            le prix de formation d'un seul employé est fixé à :
                            <span class="text-yellow-600"
                                >{{ workshop_price }} DA / personne</span
                            >
                        </h1>
                        <h1 class="opacity-80">
                            le prix total est fixé à :
                            <span class="text-vert">
                                {{ workshop_price * nb_workers_to_train }}
                                DA</span
                            >
                        </h1>
                    </div>

                    <div
                        class="w-full flex items-center gap-4 justify-end mt-5"
                    >
                        <button
                            class="font-medium font-heading border-0 px-3 py-1 text-vN hover:text-vert bg-opacity-30"
                            :class="workshop_sent ? 'opacity-50' : ''"
                            :disabled="workshop_sent"
                            @click="launchWorkshop"
                        >
                            Lancer la formation
                        </button>
                        <button
                            class="font-medium font-heading px-3 py-1 text-vN opacity-80 hover:opacity-100"
                            @click="
                                nb_workers_to_train = 1;
                                workshop_modal = false;
                            "
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>

        <Modal
            v-if="prime_modal"
            class="align-center openmodal"
            custom_css="w-1/3"
        >
            <template v-slot:content>
                <div class="flex flex-col text-vN px-5 gap-4">
                    <h1 class="text-center text-vert text-2xl">
                        Prime pour les employées
                    </h1>
                    <div>
                        <h1
                            class="text-md font-heading font-medium text-lg text-nav mb-2"
                        >
                            Entrez le montant de la prime :
                        </h1>
                        <input
                            id="bonus"
                            type="number"
                            name="bonus"
                            v-model="bonus"
                            :min="0"
                            :max="bonus_max"
                            :step="
                                bonus_max - bonus > 10000
                                    ? 10000
                                    : bonus_max - bonus > 1000
                                    ? 1000
                                    : bonus_max - bonus > 100
                                    ? 100
                                    : bonus_max - bonus > 10
                                    ? 10
                                    : 1
                            "
                            class="w-full rounded-sm"
                        />
                    </div>
                    <div>
                        <h1 class="pt-3 opacity-80">
                            Le montant total est :
                            <span class="text-yellow-600"
                                >{{
                                    bonus *
                                    (indicators["nb_workers_lv1"]["value"] +
                                        indicators["nb_workers_lv2"]["value"])
                                }}
                                DA</span
                            >
                        </h1>
                        <h1 class="opacity-80">
                            L'humeur de vos employés augmentera de :
                            <span class="text-vert">
                                {{ mood_increase * 100 }}%
                            </span>
                        </h1>
                    </div>

                    <div
                        class="w-full flex items-center gap-4 justify-end mt-5"
                    >
                        <button
                            class="font-medium font-heading border-0 px-3 py-1 text-vN hover:text-vert bg-opacity-30"
                            :class="
                                prime_sent
                                    ? 'opacity-50'
                                    : '' + bonus == 0
                                    ? 'text-gray-200 hover:text-gray-200'
                                    : ''
                            "
                            :disabled="prime_sent || bonus == 0"
                            @click="primeWorkers"
                        >
                            Valider
                        </button>
                        <button
                            class="font-medium font-heading px-3 py-1 text-vN opacity-80 hover:opacity-100"
                            @click="prime_modal = false"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>
        <!-- v-if="fire_modal" -->
        <Modal
            v-if="fire_modal"
            class="align-center openmodal"
            custom_css="w-1/3"
        >
            <template v-slot:content>
                <div class="flex flex-col text-vN px-5 gap-4">
                    <h1 class="text-center text-vert text-2xl">
                        Virer des employés
                    </h1>
                    <div>
                        <h1 class="pt-5 pb-3">
                            Nombre d'employé simple à virer :
                        </h1>
                        <input
                            type="number"
                            v-model="nb_workers_lv1_to_fire"
                            :min="0"
                            :max="
                                indicators['nb_workers_lv1'].value -
                                indicators['nb_workers_lv1_busy'].value
                            "
                            class="rounded-sm w-3/4"
                        />
                    </div>
                    <div>
                        <h1 class="pt-5 pb-3">
                            Nombre d'employé experts à virer :
                        </h1>
                        <input
                            type="number"
                            v-model="nb_workers_lv2_to_fire"
                            :min="0"
                            :max="
                                indicators['nb_workers_lv2'].value -
                                indicators['nb_workers_lv2_busy'].value
                            "
                            class="w-3/4 rounded-sm"
                        />
                    </div>

                    <div
                        class="flex flex-row items-center mt-6 px-4 py-2 gap-3 border rounded-md border-yellow-500"
                    >
                        <img
                            src="/assets/icons/warning.png"
                            class="h-10 w-10"
                            alt="fgghgf"
                        />
                        <h1 class="opacity-80 w-80">
                            Les employés licenciés doivent être payés une avance
                            de 3 mois valant:
                            <span class="text-yellow-600"
                                >{{
                                    3 *
                                    (salary_lv1 * nb_workers_lv1_to_fire +
                                        salary_lv2 * nb_workers_lv2_to_fire)
                                }}
                                DA</span
                            >
                        </h1>
                    </div>

                    <div
                        class="w-full flex items-center gap-4 justify-end mt-5"
                    >
                        <button
                            class="font-medium font-heading border-0 px-3 py-1 text-vN hover:text-vert bg-opacity-30"
                            :class="
                                nb_workers_lv2_to_fire == 0 &&
                                nb_workers_lv1_to_fire == 0
                                    ? ' text-gray-200 hover:text-gray-200'
                                    : ' text-vN hover:text-vert' && fire_sent
                                    ? 'opacity-50'
                                    : ''
                            "
                            :disabled="
                                fire_sent ||
                                (nb_workers_lv2_to_fire == 0 &&
                                    nb_workers_lv1_to_fire == 0)
                            "
                            @click="fireWorkers"
                        >
                            Valider
                        </button>
                        <button
                            class="font-medium font-heading px-3 py-1 text-vN opacity-80 hover:opacity-100"
                            @click="fire_modal = false"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>

        <!-- Adding some details -->
        <div v-if="indicators_loaded" class="flex justify-center">
            <!-- les 4 cards  -->
            <div class="flex flex-col gap-5 justify-center w-max">
                <div
                    class="flex flex-row items-center border-2 shadow-lg rounded-2xl justify-left"
                >
                    <img
                        src="/assets/icons/employees.svg"
                        alt=""
                        class="w-14 p-2 h-14"
                    />
                    <div class="flex flex-col">
                        <p>Simple: {{ indicators["nb_workers_lv1"].value }}</p>
                        <p>
                            Occupé :
                            {{ indicators["nb_workers_lv1_busy"].value }}
                        </p>
                    </div>
                </div>

                <div
                    class="flex flex-row items-center border-2 shadow-lg rounded-2xl justify-left"
                >
                    <img
                        src="/assets/icons/employees.svg"
                        alt=""
                        class="w-14 p-2 h-14"
                    />
                    <div class="flex flex-col">
                        <p>Expert: {{ indicators["nb_workers_lv2"].value }}</p>
                        <p>
                            Occupé :
                            {{ indicators["nb_workers_lv1_busy"].value }}
                        </p>
                    </div>
                </div>
                <div
                    class="flex flex-row items-center border-2 shadow-lg rounded-2xl justify-left pr-3"
                >
                    <img
                        src="/assets/icons/employees.svg"
                        alt=""
                        class="w-14 p-2 h-14"
                    />
                    <p>
                        Recherche: {{ indicators["nb_workers_to_hire"].value }}
                    </p>
                </div>
                <div
                    class="flex flex-row items-center border-2 shadow-lg rounded-2xl justify-left"
                >
                    <img
                        src="/assets/icons/humeur.svg"
                        alt=""
                        class="w-16 h-16 p-1"
                    />
                    <p>
                        Humeur:
                        {{
                            Math.round(indicators["workers_mood"].value * 100)
                        }}%
                    </p>
                </div>
            </div>

            <!-- la gauge  -->
            <div
                class="rounded-lg text-center content-center flex justify-center w-6/12"
            >
                <speedo-meter
                    :data="[
                        {
                            value: Math.round(
                                indicators['workers_mood'].value * 100
                            ),
                        },
                    ]"
                ></speedo-meter>
            </div>
            <div class="flex flex-col justify-center gap-6 w-1/5">
                <button
                    @click="hire_modal = true"
                    :disabled="!indicators_loaded || !data_loaded"
                    class="rounded-3xl font-semibold text-white py-2"
                    :class="
                        !indicators_loaded || !data_loaded
                            ? 'bg-gray-200'
                            : 'bg-vN'
                    "
                >
                    Recruter des employés
                </button>
                <button
                    @click="workshop_modal = true"
                    :disabled="
                        !indicators_loaded ||
                        !data_loaded ||
                        total_nb_employees == 0
                    "
                    class="rounded-3xl font-semibold text-white py-2"
                    :class="
                        !indicators_loaded ||
                        !data_loaded ||
                        total_nb_employees == 0
                            ? 'bg-gray-200'
                            : 'bg-vN'
                    "
                >
                    Former des employés
                </button>
                <button
                    @click="prime_modal = true"
                    :disabled="
                        !indicators_loaded ||
                        !data_loaded ||
                        total_nb_employees == 0
                    "
                    class="rounded-3xl font-semibold text-white py-2 px-3"
                    :class="
                        !indicators_loaded ||
                        !data_loaded ||
                        total_nb_employees == 0
                            ? 'bg-gray-200'
                            : 'bg-vN'
                    "
                >
                    Ajouter une prime aux employés
                </button>
                <button
                    @click="fire_modal = true"
                    :disabled="
                        !indicators_loaded ||
                        !data_loaded ||
                        total_nb_employees == 0
                    "
                    class="rounded-3xl font-semibold text-white py-2"
                    :class="
                        !indicators_loaded ||
                        !data_loaded ||
                        total_nb_employees == 0
                            ? 'bg-gray-200'
                            : 'bg-vN'
                    "
                >
                    Virer des employés
                </button>
            </div>
        </div>
    </div>
</template>

<script type="text/javascript">
import SpeedoMeter from "./ui/SpeedoMeter.vue";
import StatCard from "./ui/StatCard.vue";
import Modal from "../Modal";
export default {
    props: ["user"],
    components: {
        SpeedoMeter,
        StatCard,
        Modal,
    },
    name: "HumanRessource",
    data() {
        return {
            indicators: [],

            nb_workers_to_hire: 1,
            nb_workers_to_train: 1,
            nb_workers_lv1_to_fire: 0,
            nb_workers_lv2_to_fire: 0,

            message: "",
            error_message: "",

            hire_modal: false,
            workshop_modal: false,
            prime_modal: false,
            fire_modal: false,

            bonus: 0,

            prime_sent: false,
            workshop_sent: false,
            hire_sent: false,
            fire_sent: false,

            show_success: false,
            show_error: false,

            indicators_loaded: false,
            data_loaded: false,

            caisse: 0,
            salary_lv1: 0,
            salary_lv2: 0,
            workshop_price: 0,
            bonus_coeff: 0,
        };
    },
    computed: {
        total_nb_employees() {
            return (
                this.indicators["nb_workers_lv1"].value +
                this.indicators["nb_workers_lv2"].value
            );
        },
        mood_increase() {
            if (this.indicators["workers_mood"]["value"] >= 1) {
                return 0;
            }
            let result =
                (this.bonus_coeff * this.total_bonus) /
                (this.salary_lv1 * this.indicators["nb_workers_lv1"]["value"] +
                    this.salary_lv2 *
                        this.indicators["nb_workers_lv2"]["value"]);
            return parseFloat(result).toFixed(2);
        },
        total_bonus() {
            return (
                this.bonus *
                (this.indicators["nb_workers_lv1"]["value"] +
                    this.indicators["nb_workers_lv2"]["value"])
            );
        },
        bonus_max() {
            return (
                ((1 - this.indicators["workers_mood"].value) *
                    (this.indicators["nb_workers_lv1"].value * this.salary_lv1 +
                        this.indicators["nb_workers_lv2"].value *
                            this.salary_lv2)) /
                (this.bonus_coeff *
                    (this.indicators["nb_workers_lv1"].value +
                        this.indicators["nb_workers_lv2"].value))
            );
        },
    },
    methods: {
        launchWorkshop() {
            this.workshop_sent = true;
            axios
                .post("/api/entreprise/hr/launch-workshop", {
                    entreprise_id: this.user.id,
                    nb_workers_to_train: this.nb_workers_to_train,
                })
                .then((resp) => {
                    if (resp.data.success) {
                        this.show_success = true;
                        this.show_error = false;
                        // this.$toasted.success("Formation lancée", {
                        //     keepOnHover: true,
                        //     icon: {
                        //         name: "✔",
                        //     },
                        //     position: "bottom-right",
                        //     className: "toast-success",
                        //     duration: 1000,
                        // });
                    } else {
                        // this.$toasted.error("Pas autant d'employés", {
                        //     keepOnHover: true,
                        //     icon: {
                        //         name: "❌",
                        //     },
                        //     position: "bottom-right",
                        //     className: "toast-error",
                        //     duration: 1000,
                        // });
                        this.show_success = false;
                        this.show_error = true;
                    }

                    this.message = resp.data.message;

                    this.workshop_modal = false;
                    this.workshop_sent = false;
                    this.nb_workers_to_train = 1;
                });
        },
        primeWorkers() {
            this.prime_sent = true;
            this.prime_modal = false;
            axios
                .post("/api/entreprise/hr/prime-workers", {
                    entreprise_id: this.user.id,
                    bonus: this.bonus,
                    mood_increase: this.mood_increase,
                })
                .then((resp) => {
                    if (resp.data.success) {
                        // this.$toasted.success("Primes attribuées", {
                        //     keepOnHover: true,
                        //     icon: {
                        //         name: "✔",
                        //     },
                        //     position: "bottom-right",
                        //     className: "toast-success",
                        //     duration: 1000,
                        // });
                        this.show_success = true;
                        this.show_error = false;
                    } else {
                        // this.$toasted.error("Primes non attribuées", {
                        //     keepOnHover: true,
                        //     icon: {
                        //         name: "❌",
                        //     },
                        //     position: "bottom-right",
                        //     className: "toast-error",
                        //     duration: 1000,
                        // });
                        this.show_success = false;
                        this.show_error = true;
                    }

                    this.message = resp.data.message;

                    this.prime_sent = false;
                    this.bonus = 0;
                });
        },
        hireWorker() {
            this.hire_sent = true;
            this.hire_modal = false;
            axios
                .post("/api/entreprise/hr/hire", {
                    workers: this.nb_workers_to_hire,
                    entreprise_id: this.user.id,
                })
                .then((resp) => {
                    if (resp.data.success) {
                        // this.$toasted.success("Debut des recrutements", {
                        //     keepOnHover: true,
                        //     icon: {
                        //         name: "✔",
                        //     },
                        //     position: "bottom-right",
                        //     className: "toast-success",
                        //     duration: 1000,
                        // });
                        this.show_success = true;
                        this.show_error = false;
                    } else {
                        // this.$toasted.error("Employés non recrutés", {
                        //     keepOnHover: true,
                        //     icon: {
                        //         name: "❌",
                        //     },
                        //     position: "bottom-right",
                        //     className: "toast-error",
                        //     duration: 1000,
                        // });
                        this.show_success = false;
                        this.show_error = true;
                    }

                    this.message = resp.data.message;

                    this.hire_sent = false;
                    this.nb_workers_to_hire = 1;
                });
        },
        fireWorkers() {
            this.fire_sent = true;
            this.fire_modal = false;
            axios
                .post("/api/entreprise/hr/fire", {
                    nb_workers_lv1_to_fire: this.nb_workers_lv1_to_fire,
                    nb_workers_lv2_to_fire: this.nb_workers_lv2_to_fire,
                    entreprise_id: this.user.id,
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

                    this.fire_sent = false;
                    this.nb_workers_lv1_to_fire = 0;
                    this.nb_workers_lv2_to_fire = 0;
                });
        },
        getIndiators() {
            axios
                .get("/api/entreprise/hr/indicators", {
                    params: { entreprise_id: this.user.id },
                })
                .then((resp) => {
                    this.indicators = resp.data;
                    this.indicators_loaded = true;
                });
        },
        getHrData() {
            axios.get("/api/entreprise/hr/get-data", {}).then((resp) => {
                this.workshop_price = resp.data.workshop_price;
                this.salary_lv1 = resp.data.salary_lv1;
                this.salary_lv2 = resp.data.salary_lv2;
                this.bonus_coeff = resp.data.bonus_coeff;

                this.data_loaded = true;
            });
        },
    },
    watch: {
        bonus: function () {
            if (this.bonus > this.bonus_max) {
                this.bonus = this.bonus_max;
            } else if (this.bonus < 0) {
                this.bonus = 0;
            }
        },
        nb_workers_to_train: function (n) {
            if (n > this.indicators["nb_workers_lv1"].value) {
                this.nb_workers_to_train =
                    this.indicators["nb_workers_lv1"].value;
            } else if (n < 0) {
                this.nb_workers_to_train = 0;
            }
        },
        nb_workers_lv1_to_fire: function (n) {
            if (
                n >
                this.indicators["nb_workers_lv1"].value -
                    this.indicators["nb_workers_lv1_busy"].value
            ) {
                this.nb_workers_lv1_to_fire =
                    this.indicators["nb_workers_lv1"].value -
                    this.indicators["nb_workers_lv1_busy"].value;
            } else if (n < 0) {
                this.nb_workers_lv1_to_fire = 0;
            }
        },
        nb_workers_lv2_to_fire: function (n) {
            if (
                n >
                this.indicators["nb_workers_lv2"].value -
                    this.indicators["nb_workers_lv2_busy"].value
            ) {
                this.nb_workers_lv2_to_fire =
                    this.indicators["nb_workers_lv2"].value -
                    this.indicators["nb_workers_lv2_busy"].value;
            } else if (n < 0) {
                this.nb_workers_lv2_to_fire = 0;
            }
        },
    },
    created() {
        this.getIndiators();
        this.getHrData();

        axios
            .get("/api/navbar", {
                params: {
                    entreprise_id: this.user.id,
                    type: this.user.type,
                },
            })
            .then((resp) => {
                this.caisse = resp.data["caisse"];
            });
    },
    mounted() {
        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NewNotification",
            (e) => {
                if (e.notification.type == "WorkersUpdate") {
                    this.getIndiators();
                    this.$forceUpdate();
                }

                if (e.notification.type == "AdminNotif") {
                    this.getIndiators();
                    this.getHrData();
                    this.$forceUpdate();
                }
            }
        );

        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NavbarDataChanged",
            (e) => {
                this.caisse = e.caisse;
            }
        );
    },
};
</script>

<style></style>
