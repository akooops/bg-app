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

    props: ["xData", "Pantalon cargo","Pantalon portofino","Robe de mariée à dos ouvert",
         "T-shirt","Polo rugby","Pull à col rond","Parkas","Richelieu","Tuxedo",
        "Jupe ajustée a taille ceinturée","Jupe longue","Pull à col bâteau"],
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
                          name: 'Pantalon cargo',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Pontalon portfino',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 200, 134, 90, 2, 111]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Robe de mariée à dos ouvert',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                     {
                        //remove tooltip for line chart
                          name: 'T-shirt"',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                     {
                        //remove tooltip for line chart
                          name: 'Polo rugby',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Pull à col rond',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Parkas',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Richelieu',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Tuxedo',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Jupe ajustée a taille ceinturée',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Jupe longue',
                          type: 'line',
                          stack: 'Total',
                          data: [120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        //remove tooltip for line chart
                          name: 'Pull à col bâteau',
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
            this.option.series[0].data = this.cargo;
            this.option.series[1].data = this.portfino;
            this.option.series[2].data = this.robe;
            this.option.series[3].data = this.tshirt;
            this.option.series[4].data = this.polo;
            this.option.series[5].data = this.pull;
            this.option.series[6].data = this.parka;
            this.option.series[7].data = this.richelieu;
            this.option.series[8].data = this.tuxedo;
            this.option.series[9].data = this.jupe1;
            this.option.series[10].data = this.jupe2;
            this.option.series[12].data = this.pullcol;


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
