<template>
    <div
        v-if="dette"
        class="bg-white flex flex-col p-4 gap-2 shadow-md rounded-lg w-56"
    >
        <div
            class="flex items-center text-[#0B343499] text-opacity-60 font-semibold"
        >
            <img
                src="/assets/icons/dettes.png"
                alt="dispo icon"
                class="h-6 w-6 opacity-80 mr-2"
            />
            <p>Dettes</p>
        </div>

        <div class="flex flex-col w-max">
            <p class="font-bold text-vN  flex justify-start">
                {{ Math.round(dettes).toLocaleString().split(/\s/).join(',') }}  
            </p>
            <p class="text-vert font-bold flex justify-start">
                {{ Math.round(dettes_diff).toLocaleString().split(/\s/).join(',') }}  
            </p>
        </div>
        <v-chart ref="chart" class="chart" :option="option2" autoresize />
    </div>
    <div
        v-else
        class="bg-white flex flex-col gap-2 p-4 shadow-md rounded-lg w-56"
    >
        <div
            class="flex items-center text-[#0B343499] text-opacity-60 font-semibold"
        >
            <img
                src="/assets/icons/disponibility.png"
                alt="dispo icon"
                class="h-6 w-6 opacity-50 mr-2"
            />
            <p>Disponibilités</p>
        </div>
        <div class="flex flex-col w-max">
            <div class="font-bold text-vN flex justify-start">
                {{ Math.round(caisse).toLocaleString().split(/\s/).join(',') }}   
            </div>
            <div class="text-jaune font-bold flex justify-start">
                {{ Math.round(caisse_diff).toLocaleString().split(/\s/).join(',') }} 
            </div>
        </div>
        <v-chart ref="chart" class="chart" :option="option" autoresize />
    </div>
</template>

<script>
import "echarts";
import VChart from "vue-echarts";
export default {
    name: "Disponibility",
    components: {
        VChart,
    },
    props: ["user", "dette"],
    data() {
        return {
            caisse_diff: 0,
            dettes_diff: 0,
            show_menu: false,
            caisse: 0,
            dettes: 0,
            dettes_payed: 0,
            option: {
                xAxis: {
                    boundaryGap: false,
                    data: [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8],
                    show: false,
                },
                yAxis: {
                    boundaryGap: false,
                    show: false,
                },
                tooltip: {
                    show: false,
                },
                series: [
                    {
                        data: [0, 0, 0, 0, 0, 0, 0, 0],
                        type: "line",
                        smooth: true,

                        areaStyle: {},
                    },
                ],
                color: ["#FFBC3E"],
                grid: {
                    left: "0",
                    right: "0",
                    top: "0",
                    bottom: "0",
                },
            },
            option2: {
                xAxis: {
                    boundaryGap: false,
                    data: [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8],
                    show: false,
                },
                yAxis: {
                    boundaryGap: false,
                    show: false,
                },
                tooltip: {
                    show: false,
                },
                series: [
                    {
                        data: [0, 0, 0, 0, 0, 0, 0, 0],
                        type: "line",
                        smooth: true,
                        areaStyle: {},
                    },
                ],
                color: ["#B2D06B"],
                grid: {
                    left: "0",
                    right: "0",
                    top: "0",
                    bottom: "0",
                },
            },
        };
    },
    methods: {
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
    },
    computed: {},
    watch: {
        caisse_diff: function (n, o) {
            if (n > 0) {
                this.option.series[0].data = [
                    0.1, 0.2, 0.3, 0.2, 0.4, 0.6, 0.5, 0.7,
                ];
            } else {
                this.option.series[0].data = [
                    0.7, 0.5, 0.6, 0.4, 0.2, 0.3, 0.2, 0.1,
                ];
            }
        },
        dettes_diff: function (n, o) {
            if (n > 0) {
                this.option2.series[0].data = [
                    0.1, 0.2, 0.3, 0.2, 0.4, 0.6, 0.5, 0.7,
                ];
            } else {
                this.option2.series[0].data = [
                    0.7, 0.5, 0.6, 0.4, 0.2, 0.3, 0.2, 0.1,
                ];
            }
        },
    },
    mounted() {
        this.getSimulationData();
        // this.getStats();
        if (
            window.localStorage.getItem("caisse_diff") != null &&
            window.localStorage.getItem("caisse_diff") != 0
        ) {
            this.caisse_diff = JSON.parse(
                window.localStorage.getItem("caisse_diff")
            );
            if (this.caisse_diff < 0) {
                this.option.series[0].data = [
                    0.7, 0.5, 0.6, 0.4, 0.2, 0.3, 0.2, 0.1,
                ];
            } else {
                this.option.series[0].data = [
                    0.1, 0.2, 0.3, 0.2, 0.4, 0.6, 0.5, 0.7,
                ];
            }
        } else {
            window.localStorage.setItem("caisse_diff", 0);
            this.caisse_diff = 0;
        }
        if (
            window.localStorage.getItem("dettes_diff") != null &&
            window.localStorage.getItem("dettes_diff") != 0
        ) {
            this.dettes_diff = JSON.parse(
                window.localStorage.getItem("dettes_diff")
            );
        } else {
            window.localStorage.setItem("dettes_diff", 0);
            this.dettes_diff = 0;
        }

        if (this.user.type == "entreprise") {
            window.Echo.channel("entreprise_" + this.user.id).listen(
                "NewNotification",
                (e) => {
                    if (e.notification.type == "AdminNotif") {
                        this.getSimulationData();
                        this.$forceUpdate();
                    }

                    // if (e.notification.type == "StatsUpdate") {
                    //     this.getStats();
                    //     this.$forceUpdate();
                    // }
                }
            );

            window.Echo.channel("entreprise_" + this.user.id).listen(
                "NavbarDataChanged",
                (e) => {
                    if (window.localStorage.getItem("caisse_diff") != null) {
                        window.localStorage.setItem(
                            "caisse_diff",
                            parseFloat(e.caisse) -
                                parseFloat(this.caisse) +
                                parseFloat(this.caisse_diff)
                        );
                        this.caisse_diff +=
                            parseFloat(e.caisse) - parseFloat(this.caisse);
                    }
                    if (window.localStorage.getItem("dettes_diff") != null) {
                        window.localStorage.setItem(
                            "dettes_diff",
                            parseFloat(e.dettes) -
                                parseFloat(this.dettes) +
                                parseFloat(this.dettes_diff)
                        );
                        this.dettes_diff +=
                            parseFloat(e.dettes) - parseFloat(this.dettes);
                    }
                    this.caisse = e.caisse;
                    this.dettes = e.dettes;
                }
            );
        }
    },
};
</script>
<style>
.chart {
    height: 50px;
    width: 100%;
}
</style>
