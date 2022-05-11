<template>
    <div class="flex flex-col gap-8 text-vN">
        <!-- <div class="relative flex justify-between items-center">
            <div>
                <h2 class="text-2xl text-vN font-normal mb-4">
                    Hi {{ user.name }},
                </h2>
                <h1 class="text-3xl text-Vn font-bold">
                    Welcome to your profile
                </h1>
            </div>
        </div>
        <div class="w-full border-b border-[#807A7A33]"></div> -->
        <div class="w-full flex items-center">
            <div class="flex gap-4 justify-evenly w-full">
                <div
                    class="flex flex-col text-left p-4 rounded-xl flex-1 shadow-lg bg-[#B2D06B12]"
                >
                    <h1 class="text-lg font-semibold mb-2">Disponibilités</h1>
                    <h1 class="text-xl">{{ caisse }}</h1>
                </div>
                <div
                    class="flex flex-col text-left p-4 rounded-xl flex-1 shadow-lg bg-[#B2D06B12]"
                >
                    <h1 class="text-lg font-semibold mb-2">Dettes</h1>
                    <h1 class="text-xl">{{ dettes }}</h1>
                </div>

                <div
                    class="flex flex-col text-left p-4 rounded-xl flex-1 shadow-lg bg-[#B2D06B12]"
                >
                    <h1 class="text-lg font-semibold mb-2">Abonnés</h1>
                    <h1 v-if="mark != null" class="text-xl">
                        {{ Math.round(mark.nb_subscribers.value.toFixed(2)) }}
                    </h1>
                    <h1 v-else class="text-xl">0</h1>
                </div>
                <div
                    class="flex flex-col text-left p-4 rounded-xl flex-1 shadow-lg bg-[#FFBC3E17]"
                >
                    <h1 class="text-lg font-semibold mb-2">Présence RSS</h1>
                    <h1 v-if="mark != null" class="text-xl">
                        {{ Math.round(mark.social_presence.value.toFixed(2)) }}
                    </h1>
                    <h1 v-else class="text-xl">0</h1>
                </div>
                <div
                    class="flex flex-col text-left p-4 rounded-xl flex-1 shadow-lg bg-[#0B34341A]"
                >
                    <h1 class="text-lg font-semibold mb-2">Présence Média</h1>
                    <h1 v-if="mark != null" class="text-xl">
                        {{ Math.round(mark.media_presence.value.toFixed(2)) }}
                    </h1>
                    <h1 v-else class="text-xl">0</h1>
                </div>
                <div
                    class="flex flex-col text-left p-4 rounded-xl flex-1 shadow-lg bg-[#807A7A0F]"
                >
                    <h1 class="text-lg font-semibold mb-2">
                        Présence aux Évènements
                    </h1>
                    <h1 v-if="mark != null" class="text-xl">
                        {{ Math.round(mark.events_presence.value.toFixed(2)) }}
                    </h1>
                    <h1 v-else class="text-xl">0</h1>
                </div>
            </div>
        </div>

        <div class="flex h-max gap-2">
            <div class="w-2/3 bg-white shadow-lg h-auto">
                <h2 class="text-xl font-bold text-vN ml-4 py-3">Vos Ventes</h2>
                <VenteGraph
                    v-if="stats != null"
                    :xData="stats.dates.map(Number)"
                    :cookies="stats.ca_6.map(Number)"
                    :granola="stats.ca_9.map(Number)"
                    :sandwich="stats.ca_7.map(Number)"
                    :cereales="stats.ca_8.map(Number)"
                    :galettes="stats.ca_5.map(Number)"
                >
                </VenteGraph>
            </div>
            <div class="w-2/3 bg-white shadow-lg">
                <h2 class="ml-4 text-xl align-top font-bold text-vN py-3">
                    Vos Approvisionnement
                </h2>

                <BarChart
                    :yData="stock_quatity"
                    :xData="stock_name"
                    :width="20"
                    :height="350"
                    unit="KG"
                ></BarChart>
            </div>
        </div>

        <div class="flex flex-row rounded-lg h-max gap-4">
            <div
                class="w-3/5 bg-white shadow-lg justify-end flex flex-col h-full"
            >
                <h2 class="ml-4 py-3 text-xl font-bold text-vN">
                    Vos Ressources
                </h2>
                <div class="w-full flex justify-around pt-6">
                    <div class="flex flex-col w-max gap-3">
                        <div class="flex flex-row items-center gap-4">
                            <div class="w-4 h-4 rounded-full bg-vN"></div>
                            <h1>Machines Occupés</h1>
                        </div>
                        <div class="flex flex-row items-center gap-4">
                            <div class="w-4 h-4 rounded-full bg-jaune"></div>
                            <h1>Machines Libres</h1>
                        </div>
                    </div>
                    <div class="flex flex-col w-max justify-center gap-3">
                        <p class="text-center">{{ machine_used }}</p>
                        <p class="text-center">{{ free_machines }}</p>
                    </div>
                    <div class="flex flex-col w-max gap-3">
                        <p
                            class="text-center rounded-full px-2"
                            style="background: rgba(230, 242, 254, 1)"
                        >
                            {{
                                Math.round(
                                    (machine_used / total_machines) * 100
                                )
                            }}%
                        </p>
                        <p
                            class="text-center rounded-full px-2"
                            style="background: rgba(230, 242, 254, 1)"
                        >
                            {{
                                Math.round(
                                    (free_machines / total_machines) * 100
                                )
                            }}%
                        </p>
                    </div>
                </div>

                <CircleChart
                    :legend="[
                        machine[0].name.replace('Machines -', ''),
                        machine[1].name.replace('Machines -', ''),
                        machine[2].name.replace('Machines -', ''),
                    ]"
                    orient="vertical"
                    left="10%"
                    bottom="center"
                    :serie="machine"
                    :simple="false"
                    class="vv"
                ></CircleChart>
                <CircleChart
                    :legend="[
                        employee[0].name.replace('Employés - ', ''),
                        employee[1].name.replace('Employés - ', ''),
                    ]"
                    orient="vertical"
                    left="10%"
                    bottom="center"
                    :serie="employee"
                    :simple="false"
                    class="vv"
                ></CircleChart>
                <div class="w-full flex justify-around mt-6 mb-6">
                    <div class="flex flex-col w-max gap-3">
                        <div class="flex flex-row items-center gap-4">
                            <div class="w-4 h-4 rounded-full bg-vN"></div>
                            <h1>Employés Occupés</h1>
                        </div>
                        <div class="flex flex-row items-center gap-4">
                            <div class="w-4 h-4 rounded-full bg-jaune"></div>
                            <h1>Employés libres</h1>
                        </div>
                    </div>
                    <div class="flex flex-col w-max justify-center gap-3">
                        <p class="text-center">{{ employee_used }}</p>
                        <p class="text-center">{{ free_employee }}</p>
                    </div>
                    <div class="flex flex-col w-max gap-3">
                        <p
                            class="text-center rounded-full px-2"
                            style="background: rgba(230, 242, 254, 1)"
                        >
                            {{
                                isNaN(
                                    Math.round(
                                        (employee_used / total_employee) * 100
                                    )
                                )
                                    ? 0
                                    : Math.round(
                                          (employee_used / total_employee) * 100
                                      )
                            }}%
                        </p>
                        <p
                            class="text-center rounded-full px-2"
                            style="background: rgba(230, 242, 254, 1)"
                        >
                            {{
                                isNaN(
                                    Math.round(
                                        (free_employee / total_employee) * 100
                                    )
                                )
                                    ? 0
                                    : Math.round(
                                          (free_employee / total_employee) * 100
                                      )
                            }}%
                        </p>
                    </div>
                </div>

                <div v-if="page_index == 'employees'">
                    <div>
                        <CircleChart
                            :legend="[
                                employee[0].name.replace('Employés - ', ''),
                                employee[1].name.replace('Employés - ', ''),
                            ]"
                            orient="vertical"
                            left="10%"
                            bottom="center"
                            :serie="employee"
                            :simple="false"
                            class="vv"
                        ></CircleChart>
                    </div>

                    <div class="flex flex-row w-5/6 mx-auto mt-2">
                        <div class="rounded-l-full bg-vN h-2"></div>
                        <div class="rounded-r-full bg-jaune h-2"></div>
                    </div>
                </div>
            </div>

            <div
                class="w-full bg-white shadow-lg py-4 pl-8 flex flex-col gap-4"
            >
                <h2 class="text-xl font-bold text-vN">Suivi de production</h2>
                <HBarChart
                    v-if="prod != null && products_stock != null"
                    :produit_vendu="[
                        prod.find((e) => e.name == 'Galettes').value -
                            products_stock.find((e) => e.product == 'Galettes')
                                .quantity,
                        prod.find((e) => e.name == 'Sandwich glacé').value -
                            products_stock.find(
                                (e) => e.product == 'Sandwich glacé'
                            ).quantity,
                        prod.find((e) => e.name == 'Cookies').value -
                            products_stock.find((e) => e.product == 'Cookies')
                                .quantity,
                        prod.find((e) => e.name == 'Céréales').value -
                            products_stock.find((e) => e.product == 'Céréales')
                                .quantity,
                        prod.find((e) => e.name == 'Granola').value -
                            products_stock.find((e) => e.product == 'Granola')
                                .quantity,
                    ]"
                    :produit_en_stock="[
                        products_stock.find((e) => e.product == 'Galettes')
                            .quantity,
                        products_stock.find(
                            (e) => e.product == 'Sandwich glacé'
                        ).quantity,
                        products_stock.find((e) => e.product == 'Cookies')
                            .quantity,
                        products_stock.find((e) => e.product == 'Céréales')
                            .quantity,
                        products_stock.find((e) => e.product == 'Granola')
                            .quantity,
                    ]"
                ></HBarChart>
            </div>
        </div>
    </div>
</template>

<script>
import VenteGraph from "./ui/VenteGraph";
import BarChart from "./ui/BarChart";
import PieChart from "./ui/PieChart";
import SpeedoMeter from "./ui/SpeedoMeter";
import StatCard from "./ui/StatCard";
import CircleChart from "./ui/CircleChart";
import HBarChart from "./ui/HBarChart";

export default {
    name: "Profile",
    props: ["user"],
    data() {
        return {
            gg: [],
            employee_used: "",
            total_employee: "",
            free_employee: "",
            employee: [],
            total_machines: "",
            free_machines: "",
            machine: null,
            machine_used: [],
            // machien_name:["machiene1","machine2","machine3"],
            machien_name: [],
            legend_employe: [],
            page_index: "machines",
            productions: [],
            caisse: 0,
            dettes: 0,
            mark: null,
            ads_loaded: false,
            indicators_loaded: false,
            indicators: [],
            prod: null,
            stock_name: [],
            stock_quatity: [],
            stats: null,

            products_stock: null,
            // selected_product: 5,
            product_selected: {
                name: "Galletes",
                description:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                left_demand: 0,
                quantity: 0,
                price_min: 0,
                price_min: 0,
            },
            market_share_prod: null,
            market_share_entrep: null,
            entreprise_names: [],
            product_names: [],
        };
    },
    components: {
        VenteGraph,
        StatCard,
        BarChart,
        PieChart,
        SpeedoMeter,
        CircleChart,
        HBarChart,
    },
    watch: {
        // selected_product: function (n, o) {
        //     this.market_share_prod = null;
        //     this.product_selected.name = this.products.filter(
        //         (p) => p.id == n
        //     )[0].name;
        //     this.product_selected.description = this.products.filter(
        //         (p) => p.id == n
        //     )[0].description;
        //     this.product_selected.quantity = this.products_stock.filter(
        //         (p) => p.id == n
        //     )[0].quantity;
        //     this.product_selected.left_demand = this.products.filter(
        //         (p) => p.id == n
        //     )[0].left_demand;
        //     this.product_selected.price_max = this.products.filter(
        //         (p) => p.id == n
        //     )[0].price_max;
        //     this.product_selected.price_min = this.products.filter(
        //         (p) => p.id == n
        //     )[0].price_min;
        //     this.$refs["product"].scrollIntoView();
        //     this.getMarketShareProd();
        // },
    },

    methods: {
        getstats() {
            axios
                .get("/api/entreprise/stats", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((response) => {
                    this.stats = response.data;
                })
                .catch(function (error) {});
        },

        getStock() {
            axios
                .get("/api/entreprise/stock", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((response) => {
                    response.data.forEach((e) => {
                        if (e.material == "Emballage (Carton / Alumnium)") {
                            this.stock_name.push("Emballage");
                        } else {
                            if (e.material == "Additifs Alimentaires") {
                                this.stock_name.push("A.alimentaires");
                            } else {
                                if (e.material == "Flocons d'Avoine") {
                                    this.stock_name.push("FA");
                                } else {
                                    this.stock_name.push(e.material);
                                }
                            }
                        }

                        this.stock_quatity.push(e.quantity);
                    });
                })
                .catch(function (error) {});
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
                    var gal_produced = 0;
                    var cer_produced = 0;
                    var gran_produced = 0;
                    var cook_produced = 0;
                    var san_produced = 0;
                    this.productions.forEach((element) => {
                        if (
                            element.product == "Galettes" &&
                            element.status_code == "completed"
                        ) {
                            gal_produced = gal_produced + element.quantity;
                        }
                        if (
                            element.product == "Sandwich glacé" &&
                            element.status_code == "completed"
                        ) {
                            san_produced = san_produced + element.quantity;
                        }
                        if (
                            element.product == "Granola" &&
                            element.status_code == "completed"
                        ) {
                            gran_produced = gran_produced + element.quantity;
                        }
                        if (
                            element.product == "Céréales" &&
                            element.status_code == "completed"
                        ) {
                            cer_produced = cer_produced + element.quantity;
                        }
                        if (
                            element.product == "Cookies" &&
                            element.status_code == "completed"
                        ) {
                            cook_produced = cook_produced + element.quantity;
                        }
                    });
                    return (this.prod = [
                        { name: "Galettes", value: gal_produced },
                        { name: "Sandwich glacé", value: san_produced },
                        { name: "Granola", value: gran_produced },
                        { name: "Céréales", value: cer_produced },
                        { name: "Cookies", value: cook_produced },
                    ]);
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
                })
                .catch(function (error) {});
        },

        changeTab(tab_name = null, confirm = false) {
            if (!confirm) {
                if (this.page_index == "command_creator") {
                    this.next_tab = tab_name;
                    this.show_change_tab_modal = true;
                } else {
                    this.page_index = tab_name;
                }
            } else {
                this.page_index = this.next_tab;
                this.show_change_tab_modal = false;
            }
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
                    this.gg = resp.data;
                    this.machine = [
                        {
                            name: resp.data["nb_machines_lv1"].name.replace(
                                "Machines -",
                                ""
                            ),
                            value: resp.data["nb_machines_lv1"].value,
                        },
                        {
                            name: resp.data["nb_machines_lv2"].name.replace(
                                "Machines -",
                                ""
                            ),
                            value: resp.data["nb_machines_lv2"].value,
                        },
                        {
                            name: resp.data["nb_machines_lv3"].name.replace(
                                "Machines -",
                                ""
                            ),
                            value: resp.data["nb_machines_lv3"].value,
                        },
                    ];

                    this.employee = [
                        {
                            name: resp.data["nb_workers_lv1"].name.replace(
                                "Employés - ",
                                ""
                            ),
                            value: resp.data["nb_workers_lv1"].value,
                        },
                        {
                            name: resp.data["nb_workers_lv2"].name.replace(
                                "Employés - ",
                                ""
                            ),
                            value: resp.data["nb_workers_lv2"].value,
                        },
                    ];

                    this.employee_used =
                        resp.data["nb_workers_lv1_busy"].value +
                        resp.data["nb_workers_lv2_busy"].value;
                    this.total_employee =
                        resp.data["nb_workers_lv1"].value +
                        resp.data["nb_workers_lv2"].value;
                    this.free_employee =
                        this.total_employee - this.employee_used;

                    this.machine_used =
                        resp.data["nb_machines_lv1_busy"].value +
                        resp.data["nb_machines_lv2_busy"].value +
                        resp.data["nb_machines_lv3_busy"].value;
                    this.total_machines =
                        resp.data["nb_machines_lv1"].value +
                        resp.data["nb_machines_lv2"].value +
                        resp.data["nb_machines_lv3"].value;
                    this.free_machines =
                        this.total_machines - this.machine_used;
                    // this.show_stat_cards = true;
                    // this.indicators_loaded = true;
                });
        },
        getSimulationData() {
            axios
                .get("/api/navbar", {
                    params: {
                        entreprise_id: this.user.id,
                        type: this.user.type,
                    },
                })
                .then((resp) => {
                    this.caisse = resp.data["caisse"];
                    this.dettes = resp.data["dettes"];
                });
        },
        getmarketing() {
            // Numbers to show in cards
            axios
                .get("/api/entreprise/marketing/indicators", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.mark = resp.data;
                    //this.show_stat_cards = true
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

        getFinIndicators() {
            axios
                .get("/api/indicator/finance", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.indicators = resp.data;
                });
        },
    },

    created() {
        this.getIndiators();
        this.getmarketing();
        this.getSimulationData();
        this.getProdNumbers();
        this.getProductions();
        this.getProductsStock();
        this.getStock();
        this.getstats();
    },

    mounted() {
        // this.entreprise_names = this.entreprises.map((e) => e.name);
        // this.product_names = this.products.map((p) => p.name);
        // this.product_selected.left_demand = this.products[0].left_demand;
        // this.product_selected.price_min = this.products[0].price_min;
        // this.product_selected.price_max = this.products[0].price_max;
        this.getProductsStock();
        // this.getMarketShares();
        // this.getMarketShareProd();
        this.getFinIndicators();

        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NavbarDataChanged",
            (e) => {
                this.caisse = e.caisse;
            }
        );
    },
};
</script>
