<template>
    <div >
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
                    <span class="text-yellow-600 font-bold">{{
                        salary_lv1
                    }}</span>
                </p>

                <p>
                    Le salaire pour le nombre d'employés choisis est fixé a :
                    <span class="text-green-700 font-bold">
                        {{ salary_lv1 * workers }}
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
                    :max="
                        indicators['nb_workers_lv1']['value'] -
                        indicators['nb_workers_lv1_busy']['value']
                    "
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
                        >{{ workshop_price * nb_workers_to_train }}
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
                        @click="
                            nb_workers_to_train = 1;
                            workshop_modal = false;
                        "
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>
        <Modal v-if="prime_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Prime pour les employés</h3>
                <div class="relative h-10 input-component mb-3">
                    <label
                        for="bonus"
                        class="left-2 transition-all bg-white px-1"
                    >
                        Entrez le montant de la prime
                    </label>
                    <input
                        id="bonus"
                        type="number"
                        name="bonus"
                        v-model="bonus"
                        :min="0"
                        :max="bonus_max"
                        :step="bonus_max - bonus > 100 ? 100 : (bonus_max - bonus > 10 ? 10 : 1)"
                        class="h-full w-full rounded-sm"
                    />
                </div>
                <p class="mt-10">
                    Le montant total est :
                    <span class="text-yellow-600 font-bold">{{
                        bonus *
                        (indicators["nb_workers_lv1"]["value"] +
                            indicators["nb_workers_lv2"]["value"])
                    }}</span>
                </p>
                <p class="mt-10">
                    L'humeur des employés augmentera de:
                    <span class="text-green-600 font-bold">
                        {{ mood_increase }}
                    </span>
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
                        @click="prime_modal = false"
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>

        <Modal v-if="fire_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Virer des employés</h3>
                <div class="relative h-10 input-component mb-3">
                    <label
                        class="left-2 transition-all bg-white px-1"
                    >
                        Nombre d'employés simples à virer:
                    </label>
                    <input
                        type="number"
                        v-model="nb_workers_lv1_to_fire"
                        :min="0"
                        :max="indicators['nb_workers_lv1'].value - indicators['nb_workers_lv1_busy'].value"
                        class="h-full w-full rounded-sm"
                    />
                </div>
                <div class="relative h-10 input-component mb-3 mt-10">
                    <label
                        class="left-2 transition-all bg-white px-1"
                    >
                        Nombre d'employés experts à virer:
                    </label>
                    <input
                        type="number"
                        v-model="nb_workers_lv2_to_fire"
                        :min="0"
                        :max="indicators['nb_workers_lv2'].value - indicators['nb_workers_lv2_busy'].value"
                        class="h-full w-full rounded-sm"
                    />
                </div>
                <p class="mt-10">
                    Les employés licenciés doivent être payés une avance de 3 mois valant:
                    <span class="text-yellow-600 font-bold">{{
                        3 * (salary_lv1 * nb_workers_lv1_to_fire + salary_lv2 * nb_workers_lv2_to_fire)
                    }} DA</span>
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
                            fire_sent
                                ? 'bg-gray-800 '
                                : 'bg-green-400 hover:bg-green-800'
                        "
                        :disabled="fire_sent"
                        @click="fireWorkers"
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
                        @click="fire_modal = false;
                                nb_workers_lv1_to_fire = 0;
                                nb_workers_lv2_to_fire = 0;"
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>


        <!-- Adding some details -->
        <div v-if="indicators_loaded" class="flex flex-row ">
            <div class="flex flex-col gap-5 justify-center">
                <div class="flex flex-row items-center border-2 shadow-lg rounded-2xl px-2">
                    <img src="/assets/icons/employees.svg" alt="" class="w-16 h-16 ">
                    <div class="flex flex-col">
                        <p>
                    Simple:  {{indicators['nb_workers_lv1'].value}}</p>
                    <p> Occupé :   {{indicators['nb_workers_lv1_busy'].value}} </p>
                </div>
                    </div>

                <div class="flex flex-row items-center border-2 shadow-lg rounded-2xl px-2">
                    <img src="/assets/icons/employees.svg" alt="" class="w-16 h-16">
                    <div class="flex flex-col">
                          <p>
                    Expert: {{indicators['nb_workers_lv2'].value}}</p>
                   <p> Occupé : {{indicators['nb_workers_lv1_busy'].value}}
                     </p>
                    </div>

                </div>
                <div class="flex flex-row items-center border-2 shadow-lg rounded-2xl px-2">
                    <img src="/assets/icons/employees.svg" alt="" class="w-16 h-16">
                    <p>
                    Recherche: {{indicators['nb_workers_to_hire'].value}}

                     </p>
                </div>
                <div class="flex flex-row items-center border-2 shadow-lg rounded-2xl px-2">
                    <img src="/assets/icons/humeur.png" alt="" class="w-16 h-16 p-3">
                    <p>
                        Humeur: {{ Math.round(indicators['workers_mood'].value * 100) }}%
                    </p>
                </div>

            </div>


            <div class="rounded-lg text-center ">

                <speedo-meter
                    :data="[
                        {
                            value: Math.round(indicators['workers_mood'].value * 100),
                        },
                    ]"

                ></speedo-meter>

            </div>
            <div class="flex flex-col justify-center gap-6">
                <button @click="workers_modal=true" :disabled="!indicators_loaded" class="rounded-3xl font-semibold bg-vN text-white py-2 " >Recuruter des employés</button>
                <button @click="workshop_modal=true" :disabled="!indicators_loaded" class="rounded-3xl font-semibold bg-vN text-white py-2 " >Former des employées</button>
                <button @click="prime_modal = true" :disabled="!indicators_loaded" class="rounded-3xl  font-semibold bg-vN text-white py-2 px-3">Ajouter une prime au employées</button>
                <button  @click="fire_modal = true"  :disabled="!indicators_loaded" class="rounded-3xl font-semibold bg-vN text-white py-2 ">Virer des employées</button>

            </div>
        </div>

    </div>
</template>

<script type="text/javascript">
import SpeedoMeter from "./ui/SpeedoMeter.vue";
import StatCard from "./ui/StatCard.vue";
import Modal from "../Modal";
export default {
    props: [
        "user",
        "salary_lv1",
        "salary_lv2",
        "workshop_price",
        "bonus_coeff",
    ],
    components: {
        SpeedoMeter,
        StatCard,
        Modal,
    },
    name: "HumanRessource",
    data() {
        return {
            indicators: [],
            workers_modal: false,
            workers: 1,
            message: "",
            error_message: "",
            nb_workers_to_train: 1,
            workshop_modal: false,
            prime_modal: false,
            fire_modal: false,
            bonus: 0,
            nb_workers_lv1_to_fire: 0,
            nb_workers_lv2_to_fire: 0,
            prime_sent: false,
            workshop_sent: false,
            hire_sent: false,
            fire_sent: false,
            show_success: false,
            show_error: false,
            indicators_loaded: false,
            caisse: 0,
        };
    },
    computed: {
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
                    } else {
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
                        this.show_success = true;
                        this.show_error = false;
                    } else {
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
            this.workers_modal = false;
            axios
                .post("/api/entreprise/hr/hire", {
                    workers: this.workers,
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

                    this.hire_sent = false;
                    this.workers = 0;
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
    },
    created() {
        this.getIndiators();

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

<style>
</style>
