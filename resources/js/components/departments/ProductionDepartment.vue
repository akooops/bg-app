<template>
    <div class="w-full">
        <div class="w-full">
            <nav class="mb-10 text-sm flex justify-start gap-8">
                <button
                    @click="page_index = 'prod_stats'"
                    :class="
                        page_index == 'prod_stats'
                            ? 'border-b-2 border-vert text-vert font-medium'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg"
                >
                    Statistiques
                </button>

                <!-- active -->
                <button
                    @click="page_index = 'production_list'"
                    :class="
                        page_index == 'production_list'
                            ? 'border-b-2 border-vert text-vert font-medium'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg"
                >
                    Productions
                </button>

                <button
                    @click="page_index = 'decision_center'"
                    :class="
                        page_index == 'decision_center'
                            ? 'border-b-2 border-vert text-vert font-medium'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg"
                >
                    Centre de décision
                </button>
            </nav>
        </div>

        <!-- stat cards  -->

        <div v-if="show_stat_cards" class="flex w-full justify-center gap-7">
            <Indicator :indicators="indicators"></Indicator>

            <div
                class="relative flex w-1/4 gap-3 justify-evenly items-center rounded-xl px-3 bg-white shadow-sm"
            >
                <img
                    class="h-16 w-16"
                    src="/assets/icons/machine.svg"
                    alt="machine icon"
                />
                <h1 class="text-vN text-lg font-medium">Nombre de Machine</h1>
                <button @click="showMachines = !showMachines">
                    <img
                        class="h-5 w-5"
                        src="/assets/icons/chevron-down.svg"
                        alt="arrow down icon"
                    />
                </button>
                <div
                    v-if="showMachines"
                    class="flex items-center gap-2 absolute z-999 -bottom-11 right-0 bg-white border-opacity-5 border-vN shadow-md p-2 rounded-lg"
                >
                    {{ indicators["machines"].value }}
                </div>
            </div>

            <div
                class="relative flex w-1/4 gap-3 justify-evenly items-center rounded-xl px-3 bg-white shadow-sm"
            >
                <img
                    class="h-16 w-16"
                    src="/assets/icons/employees.svg"
                    alt="employees icon"
                />
                <h1 class="text-vN text-lg font-medium">Nombre d'employé</h1>
                <button @click="showEmployees = !showEmployees">
                    <img
                        class="h-5 w-5"
                        src="/assets/icons/chevron-down.svg"
                        alt="arrow down icon"
                    />
                </button>
                <div
                    v-if="showEmployees"
                    class="flex items-center gap-2 absolute z-999 -bottom-11 right-0 bg-white border-opacity-5 border-vN shadow-md p-2 rounded-lg"
                >
                    {{ indicators["nb_workers_prod"].value }}
                </div>
            </div>
        </div>
        <div v-if="page_index == 'prod_stats'">
            <div
                v-if="show_market_demand"
                class="grid grid-rows-2 grid-cols-2 justify-between gap-8 mt-8"
            >
                <div
                    v-for="(prod, i) in prod_data"
                    :key="i"
                    class="rounded mt-2 flex-1"
                >
                    <div class="flex flex-col gap-5">
                        <h2 class="font-medium text-lg">
                            Demande Prévisionelle - {{ products[i].name }} :
                        </h2>
                        <div class="flex gap-4">
                            <div
                                class="flex flex-col items-center px-2 py-1 text-white bg-vert rounded-md"
                            >
                                <h3 class="font-medium text-sm">
                                    Demandes restantes
                                </h3>
                                <p class="font-bold">
                                    {{ products[i].left_demand }}
                                </p>
                            </div>
                            <button
                                @click="showProductDescription(i)"
                                class="bg-white border-vert border-2 text-vert px-4 py-1 rounded-md"
                            >
                                Description
                            </button>
                        </div>
                        <LineGraph
                            :x-data="prod.prices"
                            :y-data="prod.demand"
                        ></LineGraph>
                    </div>
                </div>
                <Modal v-if="show_product_info" :description="true">
                    <template v-slot:content>
                        <div class="w-full flex flex-col gap-8 p-3">
                            <div class="flex justify-between item-center">
                                <h1 class="text-lg text-vert font-bold">
                                    Description - {{ product_info.name }}
                                </h1>
                                <img
                                    src="/assets/icons/close.svg"
                                    class="w-6 h-6 cursor-pointer"
                                    alt="close icon"
                                    @click="show_product_info = false"
                                />
                            </div>
                            <p class="text-vN font-normal">
                                {{ product_info.description }}
                            </p>
                            <div>
                                <p class="font-medium mb-3">
                                    Pour produire un lot de 100 unités de ce
                                    produit vous avez besoin de :
                                </p>
                                <table class="w-2/3 border-colapse">
                                    <thead
                                        class="bg-gray-100 font-semibold text-vN"
                                    >
                                        <tr>
                                            <th
                                                class="border w-1/2 p-2 border-l-0"
                                            >
                                                Matieres premiere
                                            </th>
                                            <th
                                                class="border w-1/2 p-2 border-r-0"
                                            >
                                                Quantités
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr
                                            v-for="(
                                                mat, i
                                            ) in product_info.raw_materials"
                                            :key="i"
                                            class="bg-gray-100 font-normal text-vN"
                                        >
                                            <td
                                                class="flex justify-center icon-material py-1 border border-l-0"
                                            >
                                                <img
                                                    src="/assets/icons/khobz.png"
                                                    alt="khobz"
                                                /><span>{{ mat.name }}</span>
                                            </td>
                                            <td
                                                class="text-center border table-cell border-r-0"
                                            >
                                                {{ mat.pivot.quantity }}
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </template>
                </Modal>
            </div>
        </div>
        <div v-if="page_index == 'production_list'" class="w-full mt-10">
            <div class="flex items-center justify-between mb-7">
                <h1 class="text-lg font-semibold text-vN">Vos Produits</h1>
                <button
                    class="group rounded-full tip hover:bg-gray-200 p-1"
                    @click="getProductions"
                    title="Actualiser"
                >
                    <svg
                        class="group-hover:text-vert text-vN stroke-current"
                        fill="none"
                        width="27"
                        height="23"
                        viewBox="0 0 27 23"
                    >
                        <path
                            d="M25.9998 2.13428V8.95245H19.1816"
                            stroke-width="1.6"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                        />
                        <path
                            d="M1 20.3157V13.4976H7.81817"
                            stroke-width="1.6"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                        />
                        <path
                            d="M3.85227 7.81549C4.4286 6.18684 5.4081 4.73072 6.69939 3.58301C7.99067 2.4353 9.55166 1.63341 11.2367 1.25215C12.9217 0.870893 14.6758 0.922699 16.3354 1.40274C17.995 1.88277 19.5059 2.77539 20.7273 3.99731L26 8.95185M1 13.4973L6.27272 18.4518C7.49402 19.6738 9.00496 20.5664 10.6645 21.0464C12.3241 21.5265 14.0783 21.5783 15.7633 21.197C17.4483 20.8157 19.0093 20.0138 20.3006 18.8661C21.5919 17.7184 22.5714 16.2623 23.1477 14.6337"
                            stroke-width="1.6"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                        />
                    </svg>
                </button>
            </div>

            <table class="w-full">
                <thead
                    class="sticky top-0 border-b bg-white font-semibold text-vN"
                >
                    <tr>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('id')"
                        >
                            Numéro
                        </th>
                        <th class="p-3 text-sm table-cell">Matiere</th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('quantity')"
                        >
                            Qt. Produite
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('sold')"
                        >
                            Qt. Vendue
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('stock')"
                        >
                            Stock
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('price')"
                        >
                            Prix
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('cost')"
                        >
                            Coût
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('CA')"
                        >
                            Chiffre d'Affaire
                        </th>
                        <th class="p-3 text-md table-cell">Status</th>
                        <th class="p-3 text-md table-cell">Action</th>
                    </tr>
                </thead>
                <tbody v-if="productions.length > 0">
                    <tr
                        v-for="(prod, key) in productions"
                        v-bind:key="key"
                        class="bg-white flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b text-vN font-light text-sm h-14"
                    >
                        <td
                            class="p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.id }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.product }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.quantity }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.sold }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.quantity - prod.sold }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.price }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.cost }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center lg:table-cell relative lg:static"
                        >
                            {{ prod.sold * prod.price }} UM
                        </td>
                        <td
                            :class="
                                prod.status_code == 'pending'
                                    ? 'text-jaune'
                                    : 'text-vert'
                            "
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.status }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            <button
                                @click="sell(prod)"
                                class="p-1 px-2 rounded-full"
                                v-bind:class="{
                                    'bg-opacity-50 hover:bg-opacity-100 bg-vert text-vN':
                                        prod.status_code == 'completed' &&
                                        prod.sold < prod.quantity,
                                }"
                                :disabled="
                                    !(
                                        prod.status_code == 'completed' &&
                                        prod.sold < prod.quantity
                                    )
                                "
                            >
                                {{
                                    prod.sold >= prod.quantity
                                        ? ""
                                        : prod.status_code == "pending"
                                        ? "En attente"
                                        : "Vendre"
                                }}
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <Modal v-if="show_selling_info">
                <template v-slot:content>
                    <div class="w-full">
                        <p>
                            Vous allez vendre
                            <span class="font-bold text-green-500">{{
                                sell_info.sold_quant
                            }}</span>
                            unités au prix de
                            <span class="font-bold text-green-300">
                                {{ sell_info.price }}</span
                            >
                            UM et vous aurez
                            <span class="font-bold text-yellow-500">
                                {{ sell_info.stock_quant }}
                            </span>
                            unités en stock.
                        </p>
                        <p class="font-bold text-red-500">
                            Coût de distribution total : {{ distCost }} UM
                        </p>
                        <div
                            class="w-full my-2 flex flex-wrap items-center px-10 space-x-4"
                        >
                            <button
                                @click="confirmSell"
                                class="bg-green-500 rounded px-3 py-1 text-white"
                            >
                                Confirmer
                            </button>
                            <button
                                @click="show_selling_info = false"
                                class="bg-gray-500 rounded px-3 py-1 text-white"
                            >
                                Annuler
                            </button>
                        </div>
                    </div>
                </template>
            </Modal>
        </div>
        <div v-if="page_index == 'decision_center'">
            <ProdCenter
                @prodLaunched="updateProdData"
                :user="user"
                :products="products"
                :indicators="indicators"
                :caisse="caisse"
            ></ProdCenter>
        </div>
    </div>
</template>

<script type="text/javascript">
import LineGraph from "./ui/LineGraph";
import StatCard from "./ui/StatCard";
import ProdCenter from "./ProdCenter";
import Modal from "../Modal";
import Indicator from "./ui/Indicator";
import "echarts";
import VChart from "vue-echarts";
export default {
    name: "ProductionDepartment",
    components: {
        LineGraph,
        StatCard,
        ProdCenter,
        Modal,
        Indicator,
        VChart,
    },
    props: ["user"],
    data() {
        return {
            reverse: false,
            products: [],
            market_demand: [],
            id_list: [1, 2, 3, 4],
            prod_data: [],
            show_market_demand: false,
            show_stat_cards: false,
            products: [],
            indicators: {},
            productions: [],
            page_index: "prod_stats",
            sell_info: {
                sold_quant: 0,
                stock_quant: 0,
                price: 0,
            },
            show_selling_info: false,
            show_product_info: false,
            product_info: null,
            average_prices: [],
            caisse: 0,
            showMachines: false,
            showEmployees: false,
        };
    },
    computed: {
        distCost() {
            // Distribution cost
            return (
                this.sell_info.sold_quant *
                this.indicators["dist_unit_cost"].value
            );
        },
    },
    methods: {
        showProductDescription(i) {
            let product = this.products[i];
            this.product_info = product;
            this.getAvgPrice(this.products[i]);
            this.show_product_info = true;
        },
        getProdNumbers() {
            // Numbers to show in cards
            axios
                .get("/api/entreprise/production/indicators", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.indicators = resp.data;
                    this.show_stat_cards = true;
                });
        },
        async getMarketDemands() {
            for (var i = 1; i < 5; i++) {
                let resp = await axios.get("/api/demand/prev", {
                    params: {
                        product_id: i,
                    },
                });
                this.prod_data.push(resp.data);
            }
            this.show_market_demand = true;
        },
        getProductByName(name) {
            return this.products.find((p) => p.name == name);
        },
        getProductions() {
            axios
                .get("/api/production/all", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.productions = resp.data.reverse();
                })
                .then(() => {
                    this.productions.forEach((prod) => {
                        prod.stock = prod.quantity - prod.sold;
                        prod.CA = prod.sold * prod.price;
                    });
                });
        },
        getAvgPrice(product) {
            axios
                .get("/api/production/avg-price", {
                    params: { product_id: product.id },
                })
                .then((resp) => {
                    this.product_info["avg_price"] = resp.data;
                });
        },
        sell(prod) {
            // console.log('Prod')
            // console.log(prod);
            let data = {
                entreprise_id: this.user.id,
                id: prod.id,
                product_id: this.getProductByName(prod.product).id,
                quantity: prod.quantity - prod.sold,
                price: prod.price,
            };
            // console.log(data);
            this.sell_info.production = data;
            axios
                .get("/api/demand/real", {
                    params: data,
                })
                .then((resp) => {
                    this.sell_info.sold_quant = resp.data.demand;
                    this.sell_info.stock_quant = resp.data.stock;
                    this.sell_info.price = data.price;
                });

            this.show_selling_info = true;
        },
        confirmSell() {
            let data = {
                entreprise_id: this.user.id,
                product_id: this.sell_info.production.product_id,
                production_id: this.sell_info.production.id,
                dist_cost: this.distCost,
                sold: this.sell_info.sold_quant,
                stock: this.sell_info.stock_quant,
                price: this.sell_info.price,
            };
            console.log(data);
            axios.post("/api/production/sell", data).then((resp) => {
                console.log(resp.data.message);
                this.show_selling_info = false;
            });
        },
        getProducts() {
            axios.get("/api/products").then((resp) => {
                this.products = resp.data;
            });
        },

        updateProdData() {
            this.getProdNumbers();
            this.getProductions();
            this.getProducts();
        },
        sort(key) {
            this.reverse = !this.reverse;
            this.productions.sort((a, b) => {
                if (a[key] < b[key]) {
                    return this.reverse ? -1 : 1;
                }
                if (a[key] > b[key]) {
                    return this.reverse ? 1 : -1;
                }
                console.log(this.productions);
                return 0;
            });
        },
    },
    beforeMount() {
        this.getProducts();
    },
    mounted() {
        // console.log("Test");
        this.updateProdData();
        this.getMarketDemands();
        this.getProducts();
        //add stock to productions

        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NewNotification",
            (e) => {
                if (e.notification.type == "ProductionSold") {
                    this.updateProdData();
                    this.getProducts();
                    this.$forceUpdate();
                }
                if (e.notification.type == "ProductionDone") {
                    this.updateProdData();
                    this.$forceUpdate();
                }
                if (e.notification.type == "ProductionLaunched") {
                    this.updateProdData();
                    this.$forceUpdate();
                }
                if (e.notification.type == "MachineBought") {
                    this.getProdNumbers();
                    this.$forceUpdate();
                }
                if (e.notification.type == "MachineSold") {
                    this.getProdNumbers();
                    this.$forceUpdate();
                }
                if (e.notification.type == "Information") {
                    this.getProdNumbers();
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
