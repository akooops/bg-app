<template>
    <v-chart
        ref="chart"
        class="chart px-5 py-3 bg-white shadow-md rounded-xl w-1/3"
        :option="option"
        autoresize
    />
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
import * as echarts from "echarts";
import VChart, { THEME_KEY, Bar } from "vue-echarts";

export default {
    name: "LineGraph",
    components: {
        VChart,
    },

    props: ["xData", "yData"],
    data() {
        return {
            option: {
                xAxis: {
                    type: "category",
                    showGrid: false,
                    name: "Prix",
                },
                yAxis: {
                    type: "value",
                    boundaryGap: [0, "30%"],
                    showGrid: false,
                    name: "Unités",
                    splitLine: {
                        show: false,
                    },
                },
                tooltip: {
                    show: true,
                },
                series: [
                    {
                        type: "bar",
                        data: [],
                        color: ["#B2D06B"],
                        itemStyle: {
                            //gradient color
                            color: new echarts.graphic.LinearGradient(
                                0,
                                0,
                                0,
                                1,
                                [
                                    {
                                        offset: 0,
                                        color: "rgba(178, 208, 107, 0.1)",
                                    },
                                    {
                                        offset: 1,
                                        color: "#B2D06B",
                                    },
                                ]
                            ),
                        },
                        //remove grid
                    },
                    {
                        //remove tooltip for line chart
                        type: "line",
                        smooth: true,
                        showSymbol: false,
                        // symbold size

                        lineStyle: {
                            color: "#0B3434",
                            width: 3,
                        },
                        areaStyle: {
                            color: "#0B3434",
                            opacity: 0,
                        },
                        data: [],
                    },
                ],
            },
        };
    },
    methods: {
        updateGraph() {
            // spread all xdata and ydata on the option data
            this.option.series[0].data = this.yData.map((item, index) => {
                return [this.xData[index], item];
            });
            this.option.series[1].data = this.yData.map((item, index) => {
                return [this.xData[index], item];
            });

            this.$forceUpdate();

            console.log('graph update');
        }
    },
    watch: {
        // 'xData': function() {
        //     this.updateGraph();
        // },
        'yData': function() {
            this.updateGraph();
        }
    },
    mounted() {
        this.updateGraph();

        //     this.option.xAxis.data = this.xData;
        //     this.option.series[0].data = this.yData;
        //     //this.$refs.chart.resize()
        //     //this.$forceUpdate()
    },
};
</script>

<style scoped>
.chart {
    height: 250px;
}
</style>
