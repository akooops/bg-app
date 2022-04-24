<template>
    <div class="w-full">

        <div class="w-full">
            <nav class="mb-10 text-sm flex justify-start gap-8">
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
                    @click="page_index = 'stock_sell'"
                    :class="
                        page_index == 'stock_sell'
                            ? 'border-b-2 border-vert text-vert font-medium'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg"
                >
                    Stock / Vendre
                </button>

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
            </nav>
        </div>

        <div v-if="show_stat_cards" class="flex w-full justify-center gap-7">
            <Indicator
                v-if="indicators_loaded"
                :indicators="indicators"
            ></Indicator>

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
                    Niveau 1: {{ indicators["nb_machines_lv1"].value }} |
                    Occupés: {{ indicators["nb_machines_lv1_busy"].value }} |
                    Santé:
                    {{
                        (Math.round(
                            indicators["machines_lv1_health"].value *
                                Math.pow(10, 2)
                        ) *
                            100) /
                        Math.pow(10, 2)
                    }}%<br />
                    Niveau 2: {{ indicators["nb_machines_lv2"].value }} |
                    Occupés: {{ indicators["nb_machines_lv2_busy"].value }} |
                    Santé:
                    {{
                        (Math.round(
                            indicators["machines_lv2_health"].value *
                                Math.pow(10, 2)
                        ) *
                            100) /
                        Math.pow(10, 2)
                    }}%<br />
                    Niveau 3: {{ indicators["nb_machines_lv3"].value }} |
                    Occupés: {{ indicators["nb_machines_lv3_busy"].value }} |
                    Santé:
                    {{
                        (Math.round(
                            indicators["machines_lv3_health"].value *
                                Math.pow(10, 2)
                        ) *
                            100) /
                        Math.pow(10, 2)
                    }}%<br />
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
                <h1 class="text-vN text-lg font-medium">Nombre d'employés</h1>
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
                    Simples: {{ indicators["nb_workers_lv1"].value }} <br />
                    Experts: {{ indicators["nb_workers_lv2"].value }} <br />
                    Humeur:
                    {{ Math.round(indicators["workers_mood"].value * 100) }} %
                    <br />
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
                                    Pour produire un lot de 1000 unités de ce
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
                                                />
                                                <span>
                                                    {{ mat.name }}
                                                </span>
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

            <div v-else class="flex flex-col items-center mt-16">
                <img class="w-16 h-16 load" src="/assets/logo/bg_logo.svg" alt="">
                <div class="text-vN pt-2 font-semibold">Calcul des graphes... </div>
            </div>
        </div>

        <div v-if="page_index == 'production_list'" class="w-full mt-10">
            <div class="flex items-center justify-between mb-7">
                <h1 class="text-lg font-semibold text-vN">Vos Productions</h1>
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
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('product')"
                        >
                            Produit
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('quantity')"
                        >
                            Quantité
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('quantity')"
                        >
                            Semaine début
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('quantity')"
                        >
                            Semaine fin
                        </th>
                        <th
                            class="p-3 text-md table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('status_code')"
                        >
                            Statut
                        </th>
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
                            {{ prod.creation_date }}
                        </td>
                        <td
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.finish_date }}
                        </td>
                        <td
                            :class="
                                prod.status_code == 'pending' ? 'text-jaune' : 'text-black'
                            "
                            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                        >
                            {{ prod.status }}
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div v-if="page_index == 'stock_sell'">
            <StockProd
                v-if="indicators_loaded"
                :user="user"
                :stock="products_stock"
                :stock_loaded="products_stock_loaded"
            ></StockProd>

            <div v-else class="flex flex-col items-center mt-16">
                <img class="w-16 h-16 load" src="/assets/logo/bg_logo.svg" alt="">
                <div class="text-vN pt-2 font-semibold">Chargement... </div>
            </div>
        </div>

        <div v-if="page_index == 'decision_center'">
            <ProdCenter
                v-if="indicators_loaded"
                @prodLaunched="updateProdData"
                :user="user"
                :products="products"
                :indicators="indicators"
                :caisse="caisse"
            ></ProdCenter>

            <div v-else class="flex flex-col items-center mt-16">
                <img class="w-16 h-16 load" src="/assets/logo/bg_logo.svg" alt="">
                <div class="text-vN pt-2 font-semibold">Chargement... </div>
            </div>
        </div>
    </div>
</template>

<script type="text/javascript">
import LineGraph from "./ui/LineGraph";
import StatCard from "./ui/StatCard";
import ProdCenter from "./ProdCenter";
import StockProd from "./StockProd";
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
        StockProd,
        Modal,
        Indicator,
        VChart,
    },
    props: ["user"],
    data() {
        return {
            reverse: false,

            market_demand: [],

            id_list: [5, 6, 7, 8, 9],

            prod_data: [],

            show_market_demand: false,
            show_stat_cards: false,

            products: [],
            indicators: {},
            productions: [],

            products_stock: [],
            products_stock_loaded: false,

            page_index: "decision_center",

            sell_info: {
                sold_quant: 0,
                stock_quant: 0,
                price: 0,
                number: 0,
            },

            show_selling_info: false,
            show_product_info: false,
            product_info: null,
            average_prices: [],

            caisse: 0,

            showMachines: false,
            showEmployees: false,

            indicators_loaded: false,
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
                    this.indicators_loaded = true;
                });
        },

        async getMarketDemands() {
            for (var i = 5; i < 10; i++) {
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

        getProducts() {
            axios.get("/api/products").then((resp) => {
                this.products = resp.data;
            });
        },

        getProductsStock() {
            axios
                .get("/api/entreprise/products-stock", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((response) => {
                    this.products_stock = response.data;
                    this.products_stock_loaded = true;
                })
                .catch(function (error) {});
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
                // console.log(this.productions);
                return 0;
            });
        },
    },
    created() {
        this.updateProdData();
        this.getMarketDemands();

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

        this.getProductsStock();
    },
    mounted() {
        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NewNotification",
            (e) => {
                if (e.notification.type == "ProductionUpdate") {
                    this.updateProdData();
                    this.getProductsStock();
                    this.$forceUpdate();
                }

                if (e.notification.type == "ProdStockUpdate") {
                    this.updateProdData();
                    this.getProductsStock();
                    this.$forceUpdate();
                }

                if (e.notification.type == "ActionUpdate") {
                    this.updateProdData();
                    this.$forceUpdate();
                }

                if (e.notification.type == "MachinesUpdate") {
                    this.getProdNumbers();
                    this.$forceUpdate();
                }

                if (e.notification.type == "WorkersUpdate") {
                    this.getProdNumbers();
                    this.$forceUpdate();
                }

                if (e.notification.type == "AdminNotif") {
                    this.updateProdData();
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
