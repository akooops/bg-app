<template>
    <v-chart ref="chart" class=""  :option="option" autoresize />
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
    name: "BarChart",
    components: {
        VChart,
    },
    props: ["xData", "yData", "unit", "width"],
    data() {
        return {
            option: {
                xAxis: {
                    axisLine: {
                        show: true, // Hide full Line
                    },
                    axisTick: {
                        show: false, // Hide Ticks,
                    },
                    axisLabel: {
                        interval: 0,
                        rotate: 35, //If the label names are too long you can manage this by rotating the label.
                    },
                    type: "category",
                    showGrid: false,
                    data: [],
                },
                yAxis: {
                    type: "value",
                    splitLine: {
                        show: false,
                    },
                },

                tooltip: {
                    trigger: "axis",
                    formatter: "{b} : {c} " + this.unit,
                },
                series: [
                    {
                        data: [],
                        type: "bar",
                        barGap: "20%",
                        barCategoryGap: "40%",
                        showBackground: true,
                        barWidth: this.width,
                        color: "rgba(11, 52, 52, 1)",
                        backgroundStyle: {
                            color: "rgba(11, 52, 52, 0)",
                        },
                    },
                ],
            },
        };
    },
    mounted() {
        this.option.xAxis.data = this.xData;
        this.option.series[0].data = this.yData;
        //this.$refs.chart.resize()
        //this.$forceUpdate()
    },
};
</script>


