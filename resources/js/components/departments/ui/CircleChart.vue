<template>
    <v-chart ref="chart" class="chart" :option="option" autoresize />
</template>

<script>
/*
import { use } from "echarts/core";
import { CanvasRenderer } from "echarts/renderers";
import { LineChart } from "echarts/charts";
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent
} from "echarts/components";
use([
  CanvasRenderer,
  LineChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent
  ]);
*/
import "echarts";
import VChart, { THEME_KEY } from "vue-echarts";

export default {
    name: "CircleChart",
    components: {
        VChart,
    },
    props: ["legend", "serie"],
    watch: {
        serie: function (n, o) {
            this.$forceUpdate();
        },
    },
    data() {
        return {
            option: {
                tooltip: {
                    trigger: "item",
                },
                legend: {
                    top: "bottom",
                },
                series: [
                    {
                        name: "Part du Marché",
                        type: "pie",
                        radius: ["40%", "70%"],
                        label: {
                            show: false,
                            position: "center",
                        },

                        itemStyle: {
                            borderRadius: 10,
                            borderColor: "#fff",
                            borderWidth: 1,
                        },
                        avoidLabelOverlap: false,
                        // labelLine: {
                        //     show: true,
                        // },
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: "rgba(0, 0, 0, 0.5)",
                            },
                            label: {
                                show: true,
                                fontSize: "30",
                                fontWeight: "bold",
                            },
                        },
                        color: [
                            "#FFBC3E",
                            "#0B3434",
                            "#B2D06B",
                            "#B2D06B54",
                            "#576634",
                        ],
                        data: [],
                    },
                ],
            },
        };
    },
    mounted() {
        this.option.legend.data = this.legend;
        this.option.series[0].data = this.serie;
        //this.$refs.chart.resize()
        //this.$forceUpdate()
    },
};
</script>

<style scoped>
.chart {
    height: 400px;
}
</style>
