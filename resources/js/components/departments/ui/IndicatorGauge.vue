<template>
    <v-chart ref="chart" class="chart-1" :option="option" />
</template>

<script>
import "echarts";
import VChart from "vue-echarts";

export default {
    name: "IndicatorGauge",
    components: {
        VChart,
    },
    props: ["selected_lvl", "value", "data"],

    data() {
        return {
            option: {
                series: [
                    {
                        type: "gauge",
                        startAngle: 180,
                        endAngle: 0,
                        min: 0,
                        max: 100,
                        splitNumber: 8,
                        axisLine: {
                            lineStyle: {
                                width: 6,
                                color: [
                                    [0.25, "#00A11E"],
                                    [0.5, "#93C501"],
                                    [0.75, "#FFA600"],
                                    [1, "#FB3E28"],
                                ],
                            },
                        },
                        pointer: {
                            icon: "path://M12.8,0.7l12,40.1H0.7L12.8,0.7z",
                            length: "12%",
                            width: 10,
                            offsetCenter: [0, "-60%"],
                            itemStyle: {
                                color: "auto",
                            },
                        },
                        axisTick: {
                            length: 8,
                            lineStyle: {
                                color: "auto",
                                width: 1,
                            },
                        },
                        splitLine: {
                            length: 8,
                            lineStyle: {
                                color: "auto",
                                width: 1,
                            },
                        },
                        axisLabel: {
                            show: false,
                        },
                        title: {
                            offsetCenter: [0, "-30%"],
                            fontSize: 12,
                        },
                        detail: {
                            fontSize: 14,
                            offsetCenter: [0, "0%"],
                            valueAnimation: true,
                            formatter: function (value) {
                                return value + "%";
                            },
                            color: "auto",
                        },
                        data: [
                            {
                                value: 100,
                                name: "niveau 1",
                            },
                        ],
                    },
                ],
            },
        };
    },
    watch: {
        data: function () {
            this.option.series[0].data = this.data;
            this.$forceUpdate();
        },
    },
    mounted() {
        this.option.series[0].data = this.data;
        this.$forceUpdate();
    },
};
</script>

<style>
.chart-1 {
    height: 250px;
    object-fit: none;
    width: 300px;
}

.chart-1 > div > canvas {
    object-fit: none;
    height: 100%;
    width: 100%;
}
</style>
