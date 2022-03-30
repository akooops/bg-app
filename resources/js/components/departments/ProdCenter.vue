<template>
    <div class="w-full">
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
        <div class="flex w-full flex-wrap">
            <div
                class="
                    w-1/3
                    mr-3
                    my-2
                    max-w-sm
                    overflow-hidden
                    rounded
                    border
                    bg-white
                    shadow
                "
            >
                <div class="relative">
                    <div class="flex h-24 justify-center items-center">
                        <i class="fa fa-rocket text-green-300 text-6xl"></i>
                    </div>
                </div>
                <div class="p-3 text-center">
                    <h3 class="text-lg font-extrabold mb-4 truncate-2nd">
                        Lancer une Production
                    </h3>
                    <p>
                        En lançant une production, vous produirez une quantité
                        d'un produit que vous pourrez par la suite vendre.
                    </p>
                    <p>
                        <span class="font-bold text-sm">Astuce : </span
                        >Planifiez bien votre production en amont pour eviter
                        les coûts de stock !
                    </p>
                    <button
                        @click="
                            getStock();
                            launch_prod_modal = true;
                        "
                        class="
                            bg-blue-500
                            text-white
                            w-56
                            my-2
                            px-3
                            py-1
                            rounded
                            text-center
                        "
                    >
                        Lancer
                    </button>
                </div>
            </div>
            <div
                class="
                    w-1/3
                    mr-3
                    my-2
                    max-w-sm
                    overflow-hidden
                    rounded
                    border
                    bg-white
                    shadow
                "
            >
                <div class="relative">
                    <div class="flex h-24 justify-center items-center">
                        <i class="fa fa-cogs text-green-300 text-6xl"></i>
                    </div>
                </div>
                <div class="p-3 text-center">
                    <h3 class="text-lg font-extrabold mb-4 truncate-2nd">
                        Machines
                    </h3>
                    <p>
                        En achetant de nouvelles machines ou en réparant des
                        anciennes machines vous pourrez produire plus de
                        quantité.
                    </p>
                    <p>
                        <span class="font-bold text-sm">Astuce : </span
                        >Attention à ne pas sur-estimer vos besoins en machines
                    </p>
                    <button
                        @click="getMachineInfo('buy')"
                        class="
                            bg-blue-500
                            text-white
                            w-56
                            my-2
                            px-3
                            py-1
                            rounded
                            text-center
                        "
                    >
                        Acheter
                    </button>
                    <button
                        @click="getMachineInfo('sell')"
                        class="
                            bg-blue-500
                            text-white
                            w-56
                            my-2
                            px-3
                            py-1
                            rounded
                            text-center
                        "
                    >
                        Vendre
                    </button>
                </div>
            </div>
            <div
                class="
                    w-1/3
                    mr-3
                    my-2
                    max-w-sm
                    overflow-hidden
                    rounded
                    border
                    bg-white
                    shadow
                "
            >
                <div class="relative">
                    <div class="flex h-24 justify-center items-center">
                        <i class="fa fa-industry text-green-300 text-6xl"></i>
                    </div>
                </div>
                <div class="p-3 text-center">
                    <h3 class="text-lg font-extrabold mb-4 truncate-2nd">
                        Ateliers
                    </h3>
                    <p>
                        Dans cette section vous pouvez lancer des actions pour
                        améliorer l'état de vos usines et votre productivité.
                    </p>
                    <select v-model="action.value">
                        <option value="5s">Appliquer les 5S</option>
                        <option value="audit">
                            Effectuer un audit qualité
                        </option>
                        <option value="maintenance_lv1">
                            Réparer les machines de niveau 1
                        </option>
                        <option value="maintenance_lv2">
                            Réparer les machines de niveau 2
                        </option>
                        <option value="maintenance_lv3">
                            Réparer les machines de niveau 3
                        </option>
                    </select>
                    <button
                        class="
                            bg-blue-500
                            text-white
                            w-56
                            my-2
                            px-3
                            py-1
                            rounded
                            text-center
                        "
                        @click="showActionInfo"
                    >
                        Appliquer
                    </button>
                </div>
                <Modal v-if="launch_prod_modal">
                    <template v-slot:content>
                        <div class="w-full flex flex-wrap p-2">
                            <div class="w-1/2">
                                <h1><strong>Lancer une Production</strong></h1>
                                <p class="my-1 mx-4">Produit :</p>
                                <select
                                    class="mx-4 w-1/3"
                                    v-model="launch_data.prod_id"
                                >
                                    <option
                                        :value="prod.id"
                                        v-for="(prod, key) in products"
                                        :key="key"
                                    >
                                        {{ prod.name }}
                                    </option>
                                </select>
                                <p class="my-1 mx-4">
                                    Quantité (en lot de 100 pièces):
                                </p>
                                <input
                                    v-model="launch_data.quantity"
                                    class="mx-4 w-2/3"
                                    type="number"
                                    min="1"
                                />
                                <p class="my-1 mx-4">Prix (Unitaire):</p>
                                <input
                                    class="mx-4 w-2/3"
                                    v-model="launch_data.price"
                                    type="number"
                                    :min="selectedProd.price_min"
                                    :max="selectedProd.price_max"
                                />
                                <p class="my-1 mx-4">Niveau de machine:</p>
                                <input
                                    class="mx-4 w-2/3"
                                    v-model="launch_data.machine_lvl"
                                    type="number"
                                    min="1"
                                    max="3"
                                />
                                <div class="h-auto">
                                    <button
                                        :diabled="can_produce == false"
                                        v-if="can_produce == true"
                                        @click="launchProduction()"
                                        class="
                                            bg-blue-400
                                            mx-4
                                            my-2
                                            py-1
                                            px-4
                                            text-white
                                        "
                                    >
                                        Lancer !
                                    </button>
                                    <p
                                        class="text-red-500"
                                        v-if="can_produce == false"
                                    >
                                        {{ can_produce_msg }}
                                    </p>
                                </div>
                            </div>
                            <div class="w-1/2">
                                <h1 class="font-bold text-xl">
                                    Informations Importantes
                                </h1>
                                <h2 class="font-bold text-lg">Nécessite:</h2>
                                <p>Pour un lot:</p>
                                <p>
                                    - Machines x
                                    <span class="text-blue-700 font-bold">{{
                                        selectedProd.machine_units
                                    }}</span>
                                    et Employés x
                                    <span class="text-blue-700 font-bold">{{
                                        selectedProd.labor_units
                                    }}</span>
                                </p>
                                <p
                                    v-for="(
                                        material, key
                                    ) in selectedProd.raw_materials"
                                    :key="key"
                                >
                                    - {{ material.name }} x
                                    <span class="text-blue-700 font-bold">
                                        {{ material.pivot.quantity }}
                                    </span>
                                    KG
                                </p>
                                <h2 class="font-bold text-lg">Prévisions:</h2>
                                <p>
                                    - Chiffre d'Affaire Estimé :
                                    <span class="font-bold text-indigo-500">
                                        {{ salesRevenues }} UM</span
                                    >
                                </p>
                                <p>
                                    - Coût Total Estimé :
                                    <span class="font-bold text-red-500">
                                        {{ totalCost }} UM</span
                                    >
                                </p>
                                <p>
                                    - Profit Estimé :
                                    <span
                                        :class="
                                            profit >= 0
                                                ? 'text-green-500'
                                                : 'text-red-400'
                                        "
                                        class="font-bold"
                                    >
                                        {{ profit }} UM</span
                                    >
                                </p>
                                <p>
                                    - Durée de production :
                                    <span class="text-yellow-500 font-bold">
                                        {{
                                            Math.round(
                                                prodDelay * Math.pow(10, 2)
                                            ) / Math.pow(10, 2)
                                        }}
                                        j</span
                                    >
                                </p>

                                <h2 class="text-sm font-bold">Remarques:</h2>
                                <p class="text-xs font-bold">
                                    - Les prévisions sont calculées dans le cas
                                    ou toute la quantité produite est vendue.
                                </p>
                                <p class="text-xs font-bold">
                                    - Votre taux de rebut est de
                                    {{
                                        indicators["reject_rate"].value * 100
                                    }}%, pour le réduire, lancez une étude
                                    AMDEC.
                                </p>
                                <p>
                                    <button
                                        @click="
                                            launch_prod_modal = false;
                                            launch_data.price =
                                                (selectedProd.price_min +
                                                    selectedProd.price_max) /
                                                2;
                                            launch_data.quantity = 1;
                                            launch_data.machine_lvl = 1;
                                        "
                                        class="
                                            bg-gray-500
                                            justify-end
                                            px-3
                                            py-1
                                            text-white
                                            rounded
                                            my-1
                                        "
                                    >
                                        Fermer
                                    </button>
                                </p>
                            </div>
                        </div>
                    </template>
                </Modal>
                <Modal v-if="machine.show_transaction_modal">
                    <template v-slot:content>
                        <div class="w-full">
                            <p v-if="machine.transaction == 'buy'">
                                Vous allez acheter
                                <input
                                    v-model="machine.transaction_nb"
                                    class="w-28"
                                    min="1"
                                    type="number"
                                />
                                machine(s) de niveau
                                <input
                                    v-model="machine.transaction_lv"
                                    class="w-28"
                                    min="1"
                                    max="3"
                                    type="number"
                                />
                                au prix de
                                {{
                                    (machine.transaction_lv == 1
                                        ? machine.buy_price_lv1
                                        : machine.transaction_lv == 2
                                        ? machine.buy_price_lv2
                                        : machine.buy_price_lv3) *
                                    machine.transaction_nb
                                }}
                                DA, voulez vous continuer ?
                            </p>
                            <p v-if="machine.transaction == 'sell'">
                                Vous allez vendre
                                <input
                                    v-model="machine.transaction_nb"
                                    class="w-28"
                                    :min="
                                        indicators['nb_machines_lv1']['value'] -
                                            indicators['nb_machines_lv1_busy'][
                                                'value'
                                            ] >
                                        0
                                            ? 1
                                            : 0
                                    "
                                    :max="
                                        machine.transaction_lv == 1
                                            ? indicators['nb_machines_lv1'][
                                                  'value'
                                              ] -
                                              indicators[
                                                  'nb_machines_lv1_busy'
                                              ]['value']
                                            : machine.transaction_lv == 2
                                            ? indicators['nb_machines_lv2'][
                                                  'value'
                                              ] -
                                              indicators[
                                                  'nb_machines_lv2_busy'
                                              ]['value']
                                            : indicators['nb_machines_lv3'][
                                                  'value'
                                              ] -
                                              indicators[
                                                  'nb_machines_lv3_busy'
                                              ]['value']
                                    "
                                    type="number"
                                />
                                machine(s) de niveau
                                <input
                                    v-model="machine.transaction_lv"
                                    class="w-28"
                                    min="1"
                                    max="3"
                                    type="number"
                                />
                                au prix de
                                {{
                                    (machine.transaction_lv == 1
                                        ? machine.sell_price_lv1
                                        : machine.transaction_lv == 2
                                        ? machine.sell_price_lv2
                                        : machine.sell_price_lv3) *
                                    machine.transaction_nb
                                }}
                                DA, voulez vous continuer ?
                            </p>
                            <div
                                class="
                                    w-full
                                    my-2
                                    flex flex-wrap
                                    items-center
                                    px-10
                                    space-x-4
                                "
                            >
                                <button
                                    @click="confirmMachineTransaction"
                                    class="
                                        bg-green-500
                                        rounded
                                        px-3
                                        py-1
                                        text-white
                                    "
                                >
                                    Confirmer
                                </button>
                                <button
                                    @click="
                                        machine.transaction_nb =
                                            machine.transaction == 'buy'
                                                ? 1
                                                : machine.transaction_nb;
                                        machine.transaction_lv = 1;
                                        machine.show_transaction_modal = false;
                                    "
                                    class="
                                        bg-gray-500
                                        rounded
                                        px-3
                                        py-1
                                        text-white
                                    "
                                >
                                    Annuler
                                </button>
                            </div>
                        </div>
                    </template>
                </Modal>
                <Modal v-if="action.show_info">
                    <template v-slot:content>
                        <div class="w-full">
                            <p>{{ action.phrase }}</p>
                            <p>
                                <span class="font-bold">Résultat : </span
                                >{{ action.result_phrase }}
                            </p>
                            <div
                                class="
                                    w-full
                                    my-2
                                    flex flex-wrap
                                    items-center
                                    px-10
                                    space-x-4
                                "
                            >
                                <button
                                    @click="confirmAction"
                                    class="
                                        bg-green-500
                                        rounded
                                        px-3
                                        py-1
                                        text-white
                                    "
                                >
                                    Confirmer
                                </button>
                                <button
                                    @click="action.show_info = false"
                                    class="
                                        bg-gray-500
                                        rounded
                                        px-3
                                        py-1
                                        text-white
                                    "
                                >
                                    Annuler
                                </button>
                            </div>
                        </div>
                    </template>
                </Modal>
            </div>
        </div>
    </div>
</template>

<script type="text/javascript">
import Modal from "../Modal";
export default {
    name: "ProdCenter",
    components: { Modal },
    props: ["products", "indicators", "user", "caisse"],
    data() {
        return {
            launch_prod_modal: false,
            launch_data: {
                prod_id: 1,
                price: 0,
                quantity: 1,
                machine_lvl: 1,
            },
            prod_factors: {
                machines: 0,
                labor: 0,
            },
            machine: {
                show_transaction_modal: false,
                transaction: "",

                buy_price_lv1: 0,
                buy_price_lv2: 0,
                buy_price_lv3: 0,

                sell_price_lv1: 0,
                sell_price_lv2: 0,
                sell_price_lv3: 0,

                durability_lv1: 1,
                durability_lv2: 1,
                durability_lv3: 1,

                speed_lv1: 1,
                speed_lv2: 1,
                speed_lv3: 1,

                pollution_lv1: 1,
                pollution_lv2: 1,
                pollution_lv3: 1,

                transaction_nb: 1,
                transaction_lv: 1,
            },
            can_produce_msg: "",
            can_produce: false,
            stock: {},
            show_success: false,
            show_error: false,
            message: "",
            action: {
                value: "5s",
                price: {
                    "5s": 40000,
                    audit: 60000,
                    maintenance_lv1:
                        10000 *
                        (1 - this.indicators["machines_lv1_health"]["value"]) *
                        this.indicators["nb_machines_lv1"]["value"],
                    maintenance_lv2:
                        15000 *
                        (1 - this.indicators["machines_lv2_health"]["value"]) *
                        this.indicators["nb_machines_lv2"]["value"],
                    maintenance_lb3:
                        20000 *
                        (1 - this.indicators["machines_lv3_health"]["value"]) *
                        this.indicators["nb_machines_lv3"]["value"],
                },
                phrase: "",
                result_phrase: "",
                show_info: false,
            },
        };
    },
    watch: {
        "launch_data.prod_id": function () {
            this.launch_data.price =
                (this.selectedProd.price_min + this.selectedProd.price_max) / 2;
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.quantity": function () {
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.price": function () {
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.machine_lvl": function () {
            this.can_produce = false;
            this.verifyProd();
        },
        "machine.transaction_lv": function () {
            if (this.machine.transaction_lv == 1) {
                if (
                    this.indicators["nb_machines_lv1"]["value"] -
                        this.indicators["nb_machines_lv1_busy"]["value"] ==
                    0
                ) {
                    this.machine.transaction_nb = 0;
                } else if (
                    this.indicators["nb_machines_lv1"]["value"] -
                        this.indicators["nb_machines_lv1_busy"]["value"] <
                    this.machine.transaction_nb
                ) {
                    this.machine.transaction_nb =
                        this.indicators["nb_machines_lv1"]["value"] -
                        this.indicators["nb_machines_lv1_busy"]["value"];
                } else if (this.machine.transaction_nb == 0) {
                    this.machine.transaction_nb = 1;
                }
            } else if (this.machine.transaction_lv == 2) {
                if (
                    this.indicators["nb_machines_lv2"]["value"] -
                        this.indicators["nb_machines_lv2_busy"]["value"] ==
                    0
                ) {
                    this.machine.transaction_nb = 0;
                } else if (
                    this.indicators["nb_machines_lv2"]["value"] -
                        this.indicators["nb_machines_lv2_busy"]["value"] <
                    this.machine.transaction_nb
                ) {
                    this.machine.transaction_nb =
                        this.indicators["nb_machines_lv2"]["value"] -
                        this.indicators["nb_machines_lv2_busy"]["value"];
                } else if (this.machine.transaction_nb == 0) {
                    this.machine.transaction_nb = 1;
                }
            } else if (this.machine.transaction_lv == 3) {
                if (
                    this.indicators["nb_machines_lv3"]["value"] -
                        this.indicators["nb_machines_lv3_busy"]["value"] ==
                    0
                ) {
                    this.machine.transaction_nb = 0;
                } else if (
                    this.indicators["nb_machines_lv3"]["value"] -
                        this.indicators["nb_machines_lv3_busy"]["value"] <
                    this.machine.transaction_nb
                ) {
                    this.machine.transaction_nb =
                        this.indicators["nb_machines_lv3"]["value"] -
                        this.indicators["nb_machines_lv3_busy"]["value"];
                } else if (this.machine.transaction_nb == 0) {
                    this.machine.transaction_nb = 1;
                }
            }
        },
    },
    computed: {
        selectedProd() {
            return this.products.find(
                (item) => item.id == this.launch_data.prod_id
            );
        },
        salesRevenues() {
            let coeff = 1 - this.indicators["reject_rate"].value;
            return (
                this.launch_data.price * this.launch_data.quantity * 100 * coeff
            );
        },
        totalCost() {
            return (
                this.launch_data.quantity *
                    (this.selectedProd.machine_units * 500) +
                500
            );
        },
        profit() {
            return this.salesRevenues - this.totalCost;
        },
        prodDelay() {
            let coeff =
                (this.indicators["5s_day"].value < 30 ? 1.5 : 1) *
                (this.launch_data.machine_lvl == 1
                    ? this.machine.speed_lv1
                    : this.launch_data.machine_lvl == 2
                    ? this.machine.speed_lv2
                    : this.machine.speed_lv3);
            return this.launch_data.quantity / (coeff * 10);
        },
    },
    methods: {
        launchProduction() {
            let data = {
                product_id: this.selectedProd.id, // slected product id
                entreprise_id: this.user.id, // this users's id
                quantity: this.launch_data.quantity, // number of lots (100 units) to be produced
                price: this.launch_data.price, // price of selling
                cost: this.totalCost, // cost of production
                delay: this.prodDelay * 60, // time it takes to produce
                machines: this.prod_factors.machines, // number of necessary free machines to produce
                labor: this.prod_factors.labor, // number of necessary free workers to produce
                machines_lvl: this.launch_data.machine_lvl, // selected machine level
            };

            if (this.caisse < data.cost) {
                this.launch_prod_modal = false;
                this.show_error = true;
                this.message =
                    "Vos disponibilités ne suffisent pas pour lancer la production";
                return "";
            }
            axios
                .post("/api/production/launch", data)
                .then((resp) => {
                    if (resp.data.success) {
                        this.show_success = true;
                        this.show_error = false;
                    } else {
                        this.show_success = false;
                        this.show_error = true;
                    }
                    this.message = resp.data.message;
                    this.launch_prod_modal = false;

                    this.launch_data.prod_id = 1;
                    this.launch_data.price =
                        (this.selectedProd.price_min +
                            this.selectedProd.price_max) /
                        2;
                    this.launch_data.quantity = 1;
                    this.launch_data.machine_lvl = 1;

                    this.getStock();

                    this.$emit("prodLaunched");
                })
                .catch((e) => {
                    this.show_error = true;
                    this.message =
                        "Oops ! Une erreur est survenue, veuillez infomrer un organisateur";

                    this.launch_prod_modal = false;

                    this.launch_data.prod_id = 1;
                    this.launch_data.price =
                        (this.selectedProd.price_min +
                            this.selectedProd.price_max) /
                        2;
                    this.launch_data.quantity = 1;
                    this.launch_data.machine_lvl = 1;

                    this.getStock();
                });
        },
        getStock() {
            axios
                .get("/api/entreprise/stock", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.stock = resp.data;

                    this.launch_data.prod_id = 1;
                    this.launch_data.machine_lvl = 1;
                    this.launch_data.quantity = 1;
                    this.launch_data.price =
                        (this.selectedProd.price_min +
                            this.selectedProd.price_max) /
                        2;

                    this.verifyProd();
                });
        },
        verifyProd() {
            this.prod_factors = {
                machines:
                    this.launch_data.quantity * this.selectedProd.machine_units,
                labor:
                    this.launch_data.quantity * this.selectedProd.labor_units,
            };

            let resp = true;
            if (
                this.launch_data.price > this.selectedProd.price_max ||
                this.launch_data.price < this.selectedProd.price_min
            ) {
                resp = false;
                this.can_produce_msg =
                    "Le prix doit être entre " +
                    this.selectedProd.price_min +
                    " DA - " +
                    this.selectedProd.price_max +
                    " DA";
            } else {
                let free_machines = 0;
                let free_workers = 0;

                if (this.launch_data.machine_lvl == 1) {
                    free_machines =
                        this.indicators["nb_machines_lv1"].value -
                        this.indicators["nb_machines_lv1_busy"].value;
                    free_workers =
                        this.indicators["nb_workers_lv1"].value +
                        this.indicators["nb_workers_lv2"].value -
                        this.indicators["nb_workers_lv1_busy"].value -
                        this.indicators["nb_workers_lv2_busy"].value;
                } else if (this.launch_data.machine_lvl == 2) {
                    free_machines =
                        this.indicators["nb_machines_lv2"].value -
                        this.indicators["nb_machines_lv2_busy"].value;
                    free_workers =
                        this.indicators["nb_workers_lv1"].value +
                        this.indicators["nb_workers_lv2"].value -
                        this.indicators["nb_workers_lv1_busy"].value -
                        this.indicators["nb_workers_lv2_busy"].value;
                } else if (this.launch_data.machine_lvl == 3) {
                    free_machines =
                        this.indicators["nb_machines_lv3"].value -
                        this.indicators["nb_machines_lv3_busy"].value;
                    free_workers =
                        this.indicators["nb_workers_lv2"].value -
                        this.indicators["nb_workers_lv2_busy"].value;
                }

                if (
                    this.prod_factors.machines <= free_machines &&
                    this.prod_factors.labor <= free_workers
                ) {
                    for (const material of this.selectedProd.raw_materials) {
                        let stock_material = this.stock.find((item) => {
                            return item.id == material.pivot.raw_material_id;
                        });
                        if (stock_material == undefined) {
                            resp = false;
                            this.can_produce_msg =
                                "Pas assez de matière " +
                                material.name +
                                " vous ne pouvez pas lancer la production !";
                            break;
                        }
                        if (material.pivot.quantity < stock_material.quantity) {
                            continue;
                        } else {
                            resp = false;
                            this.can_produce_msg =
                                "Pas assez de matière " +
                                material.name +
                                " vous ne pouvez pas lancer la production !";
                            break;
                        }
                    }
                } else {
                    resp = false;
                    if (this.prod_factors.machines > free_machines) {
                        this.can_produce_msg =
                            "Pas assez de machines libres, vous ne pouvez pas lancer la production !";
                    } else {
                        this.can_produce_msg =
                            "Pas assez d'employés libres, vous ne pouvez pas lancer la production !";

                        if (this.launch_data.machine_lvl == 3) {
                            this.can_produce_msg =
                                "Pas assez d'employés qualifiés libres pour utiliser des machines de niveau 3 !";

                            if (free_workers == 0) {
                                this.can_produce_msg =
                                    "Vous n'avez pas d'employés qualifiés pour utiliser des machines de niveau 3 !";
                            }
                        }
                    }
                }
            }
            this.can_produce = resp;
        },
        getMachineInfo(type) {
            axios
                .post("/api/entreprise/machine/info", {
                    entreprise_id: this.user.id,
                })
                .then((resp) => {
                    this.machine.buy_price_lv1 = resp.data.buy_price_lv1;
                    this.machine.buy_price_lv2 = resp.data.buy_price_lv2;
                    this.machine.buy_price_lv3 = resp.data.buy_price_lv3;

                    this.machine.sell_price_lv1 = resp.data.sell_price_lv1;
                    this.machine.sell_price_lv2 = resp.data.sell_price_lv2;
                    this.machine.sell_price_lv3 = resp.data.sell_price_lv3;

                    this.machine.durability_lv1 = resp.data.durability_lv1;
                    this.machine.durability_lv2 = resp.data.durability_lv2;
                    this.machine.durability_lv3 = resp.data.durability_lv3;

                    this.machine.speed_lv1 = resp.data.speed_lv1;
                    this.machine.speed_lv2 = resp.data.speed_lv2;
                    this.machine.speed_lv3 = resp.data.speed_lv3;

                    this.machine.pollution_lv1 = resp.data.pollution_lv1;
                    this.machine.pollution_lv2 = resp.data.pollution_lv2;
                    this.machine.pollution_lv3 = resp.data.pollution_lv3;

                    if (type == "buy" || type == "sell") {
                        this.machine.transaction = type;
                        this.machine.show_transaction_modal = true;
                    }
                });
        },
        confirmMachineTransaction(type) {
            this.machine.show_transaction_modal = false;
            if (this.machine.transaction == "buy") {
                // if (
                //     this.machine.buy_price * this.machine.transaction_nb >
                //     this.caisse
                // ) {
                //     this.show_error = true;
                //     this.message =
                //         "Vos disponibilités ne suffisent pas pour acheter " +
                //         this.machine.transaction_nb +
                //         " machine(s)";
                //     this.machine.show_transaction_modal = false;
                //     return "";
                // }
                axios
                    .post("/api/entreprise/machine/buy", {
                        entreprise_id: this.user.id,
                        level: this.machine.transaction_lv,
                        number: this.machine.transaction_nb,
                    })
                    .then((resp) => {
                        this.machine.show_transaction_modal = false;
                        this.machine.transaction_nb = 1;
                        this.machine.transaction_lv = 1;

                        if (resp.data.success) {
                            this.show_success = true;
                            this.show_error = false;
                        } else {
                            this.show_success = false;
                            this.show_error = true;
                        }

                        this.message = resp.data.message;
                    });
            } else if (this.machine.transaction == "sell") {
                // let nb_machines = 0;
                // let nb_machines_busy = 0;

                // if (this.machine.transaction_lv == 1) {
                //     nb_machines = this.indicators["nb_machines_lv1"]["value"];
                //     nb_machines_busy = this.indicators["nb_machines_lv1_busy"]["value"];
                // }
                // else if (this.machine.transaction_lv == 2) {
                //     nb_machines = this.indicators["nb_machines_lv2"]["value"];
                //     nb_machines_busy = this.indicators["nb_machines_lv2_busy"]["value"];
                // }
                // else if (this.machine.transaction_lv == 3) {
                //     nb_machines = this.indicators["nb_machines_lv3"]["value"];
                //     nb_machines_busy = this.indicators["nb_machines_lv3_busy"]["value"];
                // }

                // if (this.machine.transaction_nb > nb_machines) {
                //     this.show_error = true;
                //     this.message = "Pas assez de machines!";
                //     this.machine.transaction_nb = 1;
                //     this.machine.transaction_lv = 1;
                //     this.machine.show_transaction_modal = false;
                //     return;
                // }
                // else if (this.machine.transaction_nb > nb_machines - nb_machines_busy) {
                //     this.show_error = true;
                //     this.message = "Vous ne pouvez pas vendre les machines en plein production";
                //     this.machine.transaction_nb = 1;
                //     this.machine.transaction_lv = 1;
                //     this.machine.show_transaction_modal = false;
                //     return;
                // }

                axios
                    .post("/api/entreprise/machine/sell", {
                        entreprise_id: this.user.id,
                        level: this.machine.transaction_lv,
                        number: this.machine.transaction_nb,
                    })
                    .then((resp) => {
                        this.machine.show_transaction_modal = false;
                        this.machine.transaction_nb = 1;
                        this.machine.transaction_lv = 1;

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
        showActionInfo() {
            switch (this.action.value) {
                case "5s":
                    this.action.phrase =
                        "Vous allez lancer une amélioration en appliquant les 5S, celà vous coutera " +
                        this.action.price["5s"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pourrez produire plus rapidement !";
                    break;
                case "audit":
                    this.action.phrase =
                        "Vous allez lancer un audit qualité en suivant la norme ISO 9001, celà vous coutera " +
                        this.action.price["audit"] +
                        " DA";
                    this.action.result_phrase =
                        "Votre taux de rebut sera plus faible.";
                    break;
                case "maintenance_lv1":
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 1, celà vous coutera " +
                        this.action.price["maintenance_lv1"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines de niveau 1 avec un prix plus élevé.";
                    break;
                case "maintenance_lv2":
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 2, celà vous coutera " +
                        this.action.price["maintenance_lv2"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines de niveau 2 avec un prix plus élevé.";
                    break;
                case "maintenance_lv3":
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 3, celà vous coutera " +
                        this.action.price["maintenance_lv3"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines de niveau 3 avec un prix plus élevé.";
                    break;
            }
            this.action.show_info = true;
        },
        confirmAction() {
            this.action.show_info = false;
            let price = this.action.price[this.action.value];
            // if (price > this.caisse) {
            //     this.show_error = true;
            //     this.message =
            //         "Vos disponibilités ne suffisent pas pour acheter des machines";
            //     this.action.show_info = false;
            //     return "";
            // }
            axios
                .post("/api/entreprise/action/apply", {
                    type: this.action.value,
                    price: price,
                    entreprise_id: this.user.id,
                })
                .then((resp) => {
                    this.action.show_info = false;

                    if (resp.data.success) {
                        this.show_success = true;
                        this.show_error = false;
                    } else {
                        this.show_success = false;
                        this.show_error = true;
                    }

                    this.message = resp.data.message;
                });
        },
    },
    created() {
        this.getMachineInfo();
        this.getStock();
    },
};
</script>
