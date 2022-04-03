<template>
    <div
        v-if="dette"
        class="bg-white flex flex-col p-4 gap-2 shadow-md rounded-lg w-56"
    >
        <div class="flex items-center text-nav text-opacity-60 font-semibold">
            <img
                src="/assets/icons/dettes.png"
                alt="dispo icon"
                class="h-6 w-6 opacity-80 mr-2"
            />
            <p>Dettes</p>
        </div>

        <div class="flex items-center gap-4 justify-between">
            <p class="font-bold text-vN pl-4">
                {{ Math.round(dettes).toLocaleString() }}
            </p>
            <p class="text-vert font-bold">-449</p>
        </div>
        <v-chart ref="chart" class="chart" :option="option2" autoresize />
    </div>
    <div
        v-else
        class="bg-white flex flex-col gap-2 p-4 shadow-md rounded-lg w-56"
    >
        <div class="flex items-center text-nav text-opacity-60 font-semibold">
            <img
                src="/assets/icons/disponibility.png"
                alt="dispo icon"
                class="h-6 w-6 opacity-50 mr-2"
            />
            <p>Disponibilités</p>
        </div>
        <div class="flex items-center gap-4 justify-between">
            <p class="font-bold text-vN pl-4">
                {{ Math.round(caisse).toLocaleString() }}
            </p>
            <p class="text-jaune font-bold">+2749</p>
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
            show_menu: false,
            caisse: 0,
            dettes: 0,
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
                        data: [0.1, 0.2, 0.3, 0.2, 0.4, 0.6, 0.5, 0.7],
                        type: "line",
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
                        data: [0.7, 0.5, 0.6, 0.4, 0.2, 0.3, 0.2, 0.1],
                        type: "line",
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
    mounted() {
        this.getSimulationData();
        if (this.user.type == "entreprise") {
            window.Echo.channel("entreprise_" + this.user.id).listen(
                "NavbarDataChanged",
                (e) => {
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
