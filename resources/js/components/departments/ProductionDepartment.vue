<template>
    <div class="w-full">
        <div class="w-full">
            <nav class="mb-10 text-sm flex justify-start gap-8">
                <button
                    @click="page_index = 'decision_center'"
                    :class="
                        page_index == 'decision_center'
                            ? 'border-b-2 border-vert text-vert'
                            : ' hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg font-heading font-medium text-vN"
                >
                    Centre de décision
                </button>

                <button
                    @click="page_index = 'production_list'"
                    :class="
                        page_index == 'production_list'
                            ? 'border-b-2 border-vert text-vert'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg font-heading font-medium text-vN"
                >
                    Productions
                </button>

                <button
                    @click="page_index = 'stock_sell'"
                    :class="
                        page_index == 'stock_sell'
                            ? 'border-b-2 border-vert text-vert'
                            : 'hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg font-heading font-medium text-vN"
                >
                    Stock / Vendre
                </button>

                <button
                    @click="page_index = 'prod_stats'"
                    :class="
                        page_index == 'prod_stats'
                            ? 'border-b-2 border-vert text-vert'
                            : 'hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg font-heading font-medium text-vN"
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
                <h1 class="text-vN text-lg font-medium font-heading">
                    Machines
                </h1>
                <div
                    v-if="showMachines && indicators_loaded"
                
                    class="flex flex-col dropDown gap-4 items-center bg-white absolute w-full px-4 py-2 shadow-2xl z-100 rounded-xl text-vN"
                    style="bottom: -350px; height: 350px"
                >
                    <div class="flex justify-between w-full">
                        <div class="flex flex-col items-center gap-3">
                            <button
                                @click="select_lvl('machines_lv1_health')"
                                class="px-2 py-1 rounded-md"
                                :class="
                                    selected_lvl == 'machines_lv1_health'
                                        ? 'bg-vN text-white'
                                        : 'bg-white text-vN'
                                "
                            >
                                Niveau 1
                            </button>
                            <p class="text-vert">
                                {{ indicators["nb_machines_lv1"].value }}
                            </p>
                            <p class="text-[#0B3434A6]">Occupés</p>
                            <p class="text-jaune">
                                {{ indicators["nb_machines_lv1_busy"].value }}
                            </p>
                        </div>
                        <div class="flex flex-col items-center gap-3">
                            <button
                                @click="select_lvl('machines_lv2_health')"
                                class="px-2 py-1 rounded-md"
                                :class="
                                    selected_lvl == 'machines_lv2_health'
                                        ? 'bg-vN text-white'
                                        : 'bg-white text-vN'
                                "
                            >
                                Niveau 2
                            </button>
                            <p class="text-vert">
                                {{ indicators["nb_machines_lv2"].value }}
                            </p>
                            <p class="text-[#0B3434A6]">Occupés</p>
                            <p class="text-jaune">
                                {{ indicators["nb_machines_lv2_busy"].value }}
                            </p>
                        </div>
                        <div class="flex flex-col items-center gap-3">
                            <button
                                @click="select_lvl('machines_lv3_health')"
                                class="px-2 py-1 rounded-md"
                                :class="
                                    selected_lvl == 'machines_lv3_health'
                                        ? 'bg-vN text-white'
                                        : 'bg-white text-vN'
                                "
                            >
                                Niveau 3
                            </button>
                            <p class="text-vert">
                                {{ indicators["nb_machines_lv3"].value }}
                            </p>
                            <p class="text-[#0B3434A6]">Occupés</p>
                            <p class="text-jaune">
                                {{ indicators["nb_machines_lv3_busy"].value }}
                            </p>
                        </div>
                    </div>
                    <IndicatorGauge
                        :data="[
                            {
                                value: Math.round(
                                    indicators[selected_lvl].value * 100
                                ),
                                name: lvl,
                            },
                        ]"
                    />
                </div>
                <button
                    v-if="indicators_loaded"
                    @click="showMachines = !showMachines"
                >
                    <img
                        src="/assets/icons/chevron-down.svg"
                        alt="chev"
                        class="h-4 w-4"
                        style="transition: 0.2s"
                        :class="showMachines == true ? 'rotate' : ''"
                    />
                </button>
            </div>

            <div
                class="relative flex w-1/4 gap-3 justify-evenly items-center rounded-xl px-3 bg-white shadow-sm"
            >
                <img
                    class="h-16 w-16"
                    src="/assets/icons/employees.svg"
                    alt="employees icon"
                />
                <h1 class="text-vN text-lg font-medium font-heading">
                    Employés
                </h1>
                <button
                    v-if="indicators_loaded"
                    @click="showEmployees = !showEmployees"
                >
                    <img
                        src="/assets/icons/chevron-down.svg"
                        alt="chev"
                        class="h-4 w-4"
                        style="transition: 0.2s"
                        :class="showEmployees == true ? 'rotate' : ''"
                    />
                </button>
                <div
                    v-if="showEmployees && indicators_loaded"
                    class="flex flex-col dropDown gap-4 items-center bg-white absolute w-full px-4 py-2 shadow-2xl z-100 rounded-xl text-vN "
                    style="bottom: -350px; height: 350px"
                >
                    <h1 class="font-heading font-medium">
                        Humeur des Employés
                    </h1>
                    <IndicatorGauge
                        :data="[
                            {
                                value: Math.round(
                                    indicators['workers_mood'].value * 100
                                ),
                                name: 'Humeur',
                            },
                        ]"
                    />
                    <div class="mt-[-100px] flex justify-around w-full">
                        <div class="flex flex-col items-center gap-3">
                            <p class="bg-white text-vN font-medium">Simples</p>
                            <p class="text-vert">
                                {{ indicators["nb_workers_lv1"].value }}
                            </p>
                            <p class="text-[#0B3434A6]">Occupés</p>
                            <p class="text-jaune">
                                {{ indicators["nb_workers_lv1_busy"].value }}
                            </p>
                        </div>
                        <div class="border-r h-[130px]"></div>
                        <div class="flex flex-col items-center gap-3">
                            <p class="bg-white text-vN font-medium">Experts</p>
                            <p class="text-vert">
                                {{ indicators["nb_workers_lv2"].value }}
                            </p>
                            <p class="text-[#0B3434A6]">Occupés</p>
                            <p class="text-jaune">
                                {{ indicators["nb_workers_lv2_busy"].value }}
                            </p>
                        </div>
                    </div>
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
                        <h2 class="font-medium text-xl font-heading">
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
                                <h1
                                    class="text-lg text-vert font-bold font-heading"
                                >
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
                                <p class="font-medium font-heading mb-3">
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
                <img
                    class="w-16 h-16 load"
                    src="/assets/logo/bg_logo.svg"
                    alt=""
                />
                <div class="text-vN pt-2 font-semibold">
                    Calcul des graphes...
                </div>
            </div>
        </div>

        <div
            v-if="page_index == 'production_list'"
            class="flex flex-col w-full mt-10"
        >
            <div class="flex items-center justify-between mb-7">
                <h1 class="text-xl font-semibold text-vN font-heading">
                    Vos Productions
                </h1>
            </div>
            <div
                class="w-full bg-white shadow-md rounded mt-5 overflow-y-scroll"
                style="max-height: 60vh"
            >
                <table class="w-full table-auto">
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
                                @click="sort('creation_date')"
                            >
                                Semaine début
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                @click="sort('finish_date')"
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
                                    prod.status_code == 'pending'
                                        ? 'text-jaune'
                                        : 'text-black'
                                "
                                class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                            >
                                {{ prod.status }}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div v-if="page_index == 'stock_sell'">
            <StockProd
                v-if="indicators_loaded"
                :user="user"
                :stock="products_stock"
                :stock_loaded="products_stock_loaded"
            ></StockProd>

            <div v-else class="flex flex-col items-center mt-16">
                <img
                    class="w-16 h-16 load"
                    src="/assets/logo/bg_logo.svg"
                    alt=""
                />
                <div class="text-vN pt-2 font-semibold">Chargement...</div>
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
                <img
                    class="w-16 h-16 load"
                    src="/assets/logo/bg_logo.svg"
                    alt=""
                />
                <div class="text-vN pt-2 font-semibold">Chargement...</div>
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
import IndicatorGauge from "./ui/IndicatorGauge";
export default {
    name: "ProductionDepartment",
    components: {
        LineGraph,
        StatCard,
        ProdCenter,
        StockProd,
        IndicatorGauge,
        Modal,
        Indicator,
        VChart,
    },
    props: ["user"],
    data() {
        return {
            reverse: false,
            selected_lvl: "machines_lv1_health",
            lvl_value: 0,
            products: [],

            market_demand: [],

            id_list: [1, 2, 3, 4],

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
        lvl() {
            if (this.selected_lvl == "machines_lv1_health") {
                return "Niveau 1";
            }
            if (this.selected_lvl == "machines_lv2_health") {
                return "Niveau 2";
            }
            if (this.selected_lvl == "machines_lv3_health") {
                return "Niveau 3";
            }
        },
    },
    methods: {
        select_lvl(lvl) {
            this.selected_lvl = lvl;
            switch (lvl) {
                case "Niveau 1":
                    this.lvl_value =
                        this.indicators["machines_lv1_health"].value;
                    break;
                case "Niveau 2":
                    this.lvl_value =
                        this.indicators["machines_lv2_health"].value;
                    break;
                case "Niveau 3":
                    this.lvl_value =
                        this.indicators["machines_lv3_health"].value;
                    break;
                default:
                    this.lvl_value =
                        this.indicators["machines_lv1_health"].value;
            }
        },
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
    watch: {
        indicators_loaded() {
            this.lvl_value = this.indicators["machines_lv1_health"].value;
        },
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
