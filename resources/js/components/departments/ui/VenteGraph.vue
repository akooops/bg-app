<template>
    <v-chart
        ref="chart"
        class="chart px-5 py-3  rounded-xl w-1/3"
        :option="option"
        autoresize
    />
    
</template>

<script>

import * as echarts from "echarts";
import VChart, { THEME_KEY, Bar } from "vue-echarts";

export default {
    name: "VenteGraph",
    components: {
        VChart,
    },

    props: ["xData", "sandwich","galettes","granola","cereales","cookies"],
    data() {
        return {
            option: {
                xAxis: {
                    type: "category",
                    showGrid: false,
                    name: "Semaine",
                    
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
                        //remove tooltip for line chart
                          name: 'cookies',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Granolla',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 200, 134, 90, 2, 111]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Sanswich glacé',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                     {
                        //remove tooltip for line chart
                          name: 'Céréales',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                     {
                        //remove tooltip for line chart
                          name: 'Galettes',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                ],
            },
            
        };
    },
    methods: {
        updateGraph() {
            // spread all xdata and ydata on the option data
            this.option.series[0].data = this.cookies;
             this.option.series[1].data = this.granola;
            this.option.series[2].data = this.sandwich;
            this.option.series[3].data = this.cereales;
            this.option.series[4].data = this.galettes;
            this.option.xAxis.data = this.xData;
            
          

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
    height: 20rem;
}
</style>
