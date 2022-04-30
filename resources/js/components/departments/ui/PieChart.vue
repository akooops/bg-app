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
    name: "PieChart",
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
                    formatter: "{a} <br/>{b} : {c} ({d}%)",
                },
                legend: {
                    orient: "vertical",
                    left: "left",
                },
                series: [
                    {
                        name: "Part du Marché",
                        type: "pie",
                        radius: "50%",
                        roseType: "pie",

                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: "rgba(0, 0, 0, 0.5)",
                            },
                        },
                        color: [
                            "#576634",
                            "#6b7d40",
                            "#869c50",
                            "#a0bb60",
                            "#b2d06b",
                            "#c9de97",
                            "#e0ecc4",
                            "#ecf3da",
                            "#f7faf0",
                            "#fbfdf8",
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
