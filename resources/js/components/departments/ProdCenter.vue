<template>
    <div class="w-full">
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

        <div class="flex gap-6 mt-10">
            <div
                class="flex-grow bg-white rounded-xl gap-6 text-center flex flex-col py-7 shadow-lg px-2"
            >
                <img class="mx-auto h-16 w-16" src="/images/prod.png" alt="" />
                <div class="mx-auto text-center text-vN flex-1">
                    <h1 class="text-2xl font-medium mb-4">
                        Lancer une production
                    </h1>
                    <p class="text-sm text-nav text-opacity-80">
                        En lançant une production, vous produirez une quantité
                        d'un produit que vous pourrez par la suite vendre.<br />

                        <span class="text-jaune font-medium"> Astuce :</span>
                        Planifiez bien votre production en amont pour eviter les
                        coûts de stock !
                    </p>
                </div>

                <button  @click="launch_prod_modal = true"  class="rounded-xl bg-vert text-white mx-auto py-2 px-11 mb-8 text-lg font-medium"
                >
                    Lancer
                </button>
            </div>

            <div
                class="flex-grow border-2 rounded-xl gap-6 text-center flex flex-col py-7 shadow-lg px-2"
            >
                <img
                    class="mx-auto h-16 w-16"
                    src="/images/machine.png"
                    alt=""
                />
                <div class="mx-auto text-center text-vN flex-1">
                    <h1 class="text-2xl font-medium mb-4">Machine</h1>
                    <p class="text-sm text-nav text-opacity-80">
                        En achetant de nouvelles machines ou en réparant des
                        anciennes machines vous pourrez produire plus de
                        quantité.
                        <br />
                    </p>
                    <p class="text-sm text-nav text-opacity-80 mt-2">
                        <span class="text-jaune font-medium"> Astuce :</span>
                        Attention à ne pas sur-estimer vos besoins en machines
                    </p>
                </div>
                <div class="flex flex-col gap-3 mt-3">
                    <button
                        @click="setMachineTransaction('buy')"
                        class="rounded-xl bg-vert text-white mx-auto py-2 px-11 text-lg font-medium"
                    >
                        Acheter une machine
                    </button>
                    <button
                        @click="setMachineTransaction('sell')"
                        class="rounded-xl bg-vert text-white mx-auto py-2 px-11 text-lg font-medium"
                    >
                        Vendre une machine
                    </button>
                </div>
            </div>

            <div
                class="flex-grow bg-white rounded-xl gap-6 text-center flex flex-col py-7 shadow-lg px-2"
            >
                <img
                    class="mx-auto h-16 w-16"
                    src="/images/atelier.png"
                    alt=""
                />
                <div class="mx-auto text-center text-vN flex-1">
                    <h1 class="text-2xl font-medium mb-4">Atelier</h1>
                    <p class="text-sm text-nav text-opacity-80">
                        Dans cette section vous pouvez lancer des actions pour
                        améliorer l'état de vos usines et votre productivité.
                    </p>
                </div>

                <select
                    v-model="action.value"
                    aria-placeholder="Choisissez une action"
                    class="rounded-md focus:border-vert focus:ring-0 w-5/6 mx-auto border-vert"
                    style="border-width: 1px"
                >
                    <option value="5s">Appliquer les 5S</option>
                    <option value="audit">Effectuer un audit qualité</option>
                    <option value="maintenance">
                        Lancer une maintenance générale
                    </option>
                </select>
                <button
                    @click="showActionInfo"
                    class="rounded-xl bg-vert text-white mx-auto py-2 px-11 mb-8 text-lg font-medium"
                >
                    Lancer
                </button>
            </div>
        </div>
     <Modal v-if="launch_prod_modal">
         <template v-slot:content>
            
             <div class="flex flex-col w-1/2 p-6 mx-auto">
                 <h1 class="text-black text-2xl">Lancer une production</h1>
                <h1 class="text-vert text-lg mt-4">Produit :</h1>
                <select  v-model='launch_data.prod_id'>
                    <option :value="product.id" v-for='(product,key) in products' :key=key>
                        {{product.name}}
                    </option>
                </select>
                <h1 class="text-vert text-lg mt-2">Choix de la machine :</h1>
                <div class="flex flex-col m-3 gap-4 mx-auto">
                      <div  class="flex gap-3 items-center"><input v-model='launch_data.machine' type="radio" id="machine1" name="machine" class=" text-vert " /><label for="">Niveau 1</label></div>
                      <div class="flex gap-3 items-center"><input v-model='launch_data.machine' type="radio"  id="machine2" name="machine" class="text-vert" /><label for="">Niveau 2</label></div>
                      <div class="flex gap-3 items-center"><input v-model='launch_data.machine' type="radio"  id="machine3"  name="machine" class="text-vert " /><label for="">Niveau 3</label></div>
                </div>
                <h1 class="text-vert text-lg">Quantité( en lot de 100 pièces)</h1>
                <input type="number " v-model="launch_data.quantity" class="px-2  border rounded-md border-gray-200">
                <h1 class="text-vert text-lg mt-3">Prix (Unitaire)</h1>
                <input type="number " v-model="launch_data.price" class=" px-2 border rounded-md border-gray-200">
                 
                 <button class="bg-vN text-white mx-auto px-4 py-1 rounded-md mt-5">Lancer</button>



             </div>


             <div class="flex w-1/2 p-6">
                                  <h1 class="text-vert text-lg">Informations importantes</h1>

             </div>
         </template>



    </Modal>




        <!-- <Modal v-if="launch_prod_modal">
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
                        />
                        <p class="my-1 mx-4">Prix (Unitaire):</p>
                        <input
                            class="mx-4 w-2/3"
                            v-model="launch_data.price"
                            type="number"
                        />
                        <div class="h-auto">
                            <button
                                :diabled="can_produce == false"
                                v-if="can_produce == true"
                                @click="launchProduction"
                                class="bg-blue-400 mx-4 my-2 py-1 px-4 text-white"
                            >
                                Lancer !
                            </button>
                            <p class="text-red-500" v-if="can_produce == false">
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
                                {{ prodDelay }} j</span
                            >
                        </p>

                        <h2 class="text-sm font-bold">Remarques:</h2>
                        <p class="text-xs font-bold">
                            - Les prévisions sont calculées dans le cas ou toute
                            la quantité produite est vendue.
                        </p>
                        <p class="text-xs font-bold">
                            - Votre taux de rebut est de
                            {{ indicators["reject_rate"].value * 100 }}%, pour
                            le réduire, lancez une étude AMDEC.
                        </p>
                        <p>
                            <button
                                @click="launch_prod_modal = false"
                                class="bg-gray-500 justify-end px-3 py-1 text-white rounded my-1"
                            >
                                Fermer
                            </button>
                        </p>
                    </div>
                </div>
            </template>
        </Modal> -->
        <Modal v-if="machine.show_transaction_modal" class="pt-44">
            <template v-slot:content>
                <div class="flex flex-col items-center gap-5">
                    <h2
                        v-if="machine.transaction == 'buy'"
                        class="font-bold text-lg"
                    >
                        Acheter une Machine
                    </h2>
                    <h2
                        v-if="machine.transaction == 'sell'"
                        class="font-semibold text-lg"
                    >
                        Vendre une Machine
                    </h2>
                    <div class="w-full gap-4 flex-col flex">
                        <div class="flex flex-col items-start gap-2">
                            <p class="text-md font-medium text-nav">
                                Choix Du niveau de la machine
                            </p>
                            <select
                                class="rounded-sm focus:border-vert focus:ring-0 w-full border-vert"
                                style="border-width: 1px"
                            >
                                <option value="">1</option>
                                <option value="">2</option>
                                <option value="">3</option>
                            </select>
                        </div>
                        <div class="flex flex-col items-start gap-2">
                            <p class="text-md font-medium text-nav">
                                Nombre que vous souhaitez
                                {{
                                    machine.transaction == "buy"
                                        ? "acheter"
                                        : "vendre"
                                }}
                            </p>
                            <input
                                :value="quantity"
                                @input="quantity = $event.target.value"
                                min="0"
                                type="number"
                                class="rounded-sm focus:border-vert w-full focus:ring-0 border-vert"
                                style="border-width: 1px"
                            />
                        </div>
                        <div class="flex flex-col">
                            <p class="text-me font-medium text-nav">Prix</p>
                            <p
                                class="py-2 px-4 border-vert w-40 text-jaune"
                                style="border-width: 1px"
                            >
                                {{
                                    machine.transaction == "buy"
                                        ? machine.buy_price * quantity
                                        : machine.sell_price * quantity
                                }}
                            </p>
                        </div>
                    </div>
                    <div class="w-full flex items-center gap-4 justify-center">
                        <button
                            @click="confirmMachineTransaction"
                            class="bg-vert rounded-md px-3 border-vert py-1 text-white"
                            style="border-width: 1px"
                        >
                            Confirmer
                        </button>
                        <button
                            @click="machine.show_transaction_modal = false"
                            class="bg-white border-vert rounded-md px-3 py-1 text-vert"
                            style="border-width: 1px"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>
        <Modal v-if="action.show_info" class="pt-44">
            <template v-slot:content>
                <div class="flex flex-col gap-5">
                    <h1 class="text-lg text-jaune uppercase">
                        {{ action.value }}
                    </h1>
                    <p class="">
                        {{ action.phrase }}
                    </p>
                    <p class="">
                        {{ action.result_phrase }}
                    </p>
                    <div class="w-full flex items-center gap-4 justify-center">
                        <button
                            @click="confirmAction"
                            class="bg-vert rounded-md px-3 border-2 border-vert py-1 text-white"
                        >
                            Confirmer
                        </button>
                        <button
                            @click="action.show_info = false"
                            class="bg-white border-vert border-2 rounded-md px-3 py-1 text-vert"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>
    </div>
</template>

<script>
import Modal from "../Modal";
export default {
    name: "ProdCenter",
    components: { Modal },
    props: ["products", "indicators", "user", "caisse"],
    data() {
        return {
            quantity: 1,
            launch_prod_modal: false,
            launch_data: {
                prod_id: 1,
                price: 0,
                quantity: 0,
                machine: 1,
            },
            prod_factors: {
                machines: 0,
                labor: 0,
            },
            machine: {
                show_transaction_modal: false,
                transaction: "",
                buy_price: 40000,
                sell_price: 35000 * this.indicators["machines_health"].value,
            },
            can_produce_msg: "",
            can_produce: true,
            stock: {},
            show_success: false,
            show_error: false,
            message: "",
            action: {
                value: "",
                price: {
                    "5s": 40000,
                    audit: 60000,
                    maintenance: 15000 * this.indicators["machines"]["value"],
                },
                phrase: "",
                result_phrase: "",
                show_info: false,
            },
        };
    },
    watch: {
        "launch_data.quantity": function (new_val, old_val) {
            this.prod_factors = {
                machines:
                    this.launch_data.quantity * this.selectedProd.machine_units,
                labor:
                    this.launch_data.quantity * this.selectedProd.labor_units,
            };
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.price": function () {
            this.verifyProd();
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
            let coeff = this.indicators["productivity_coeff"].value;
            return this.launch_data.quantity / (coeff * 10);
        },
    },
    methods: {
        launchProduction() {
            let data = {
                product_id: this.selectedProd.id,
                entreprise_id: this.user.id,
                quantity: this.launch_data.quantity,
                price: this.launch_data.price,
                cost: this.totalCost,
                delay: this.prodDelay * 60,
                machines: this.prod_factors.machines,
                labor: this.prod_factors.labor,
            };
            if (this.caisse < data.cost) {
                this.show_error = true;
                this.message =
                    "Vos disponibilités ne suffisent pas pour lancer la production";
                return "";
            }
            axios
                .post("/api/production/launch", data)
                .then((resp) => {
                    this.show_success = true;
                    this.message = resp.data.message;
                    this.launch_prod_modal = false;
                    this.launch_data = {
                        prod_id: 1,
                        price: 0,
                        quantity: 0,
                    };
                    this.prod_factors = {
                        machines: 0,
                        labor: 0,
                    };
                    this.$emit("prodLaunched");
                })
                .catch((e) => {
                    this.show_error = true;
                    this.message =
                        "Oops ! une erreur est survenue, veuillez infomrer un organisateur";
                    this.launch_prod_modal = false;
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
                    this.verifyProd();
                });
        },
        verifyProd() {
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
                let free_machines =
                    this.indicators["machines"].value -
                    this.indicators["busy_machines"].value;
                if (
                    this.prod_factors.machines <= free_machines &&
                    this.prod_factors.labor <=
                        this.indicators["nb_workers_prod"].value
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
                    this.can_produce_msg =
                        "Pas assez de machines ou d'employés, vous ne pouvez pas lancer la production !";
                }
            }
            this.can_produce = resp;
        },
        setMachineTransaction(type) {
            this.machine.transaction = type;
            this.machine.show_transaction_modal = true;
        },
        confirmMachineTransaction(type) {
            if (this.machine.transaction == "buy") {
                if (this.machine.buy_price > this.caisse) {
                    this.show_error = true;
                    this.message =
                        "Vos disponibilités ne suffisent pas pour acheter des machines";
                    this.machine.show_transaction_modal = false;
                    return "";
                }
                axios
                    .post("/api/entreprise/machine/buy", {
                        entreprise_id: this.user.id,
                        price: this.machine.buy_price,
                    })
                    .then((resp) => {
                        this.machine.show_transaction_modal = false;
                    });
            } else if (this.machine.transaction == "sell") {
                axios
                    .post("/api/entreprise/machine/sell", {
                        entreprise_id: this.user.id,
                        price: this.machine.sell_price,
                    })
                    .then((resp) => {
                        this.machine.show_transaction_modal = false;
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
                case "maintenance":
                    this.action.phrase =
                        "Vous allez lancer une maintenance générale, celà vous coutera " +
                        this.action.price["maintenance"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines avec un prix plus élevé.";
                    break;
            }
            this.action.show_info = true;
        },
        confirmAction() {
            let price = this.action.price[this.action.value];
            if (price > this.caisse) {
                this.show_error = true;
                this.message =
                    "Vos disponibilités ne suffisent pas pour acheter des machines";
                this.action.show_info = false;
                return "";
            }
            axios
                .post("/api/entreprise/production/apply-action", {
                    type: this.action.value,
                    price: price,
                    entreprise_id: this.user.id,
                })
                .then((resp) => {
                    this.action.show_info = false;
                });
        },
    },
    mounted() {
        this.getStock();
        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NavbarDataChanged",
            (e) => {
                this.caisse = e.caisse;
            }
        );
    },
};
</script>
