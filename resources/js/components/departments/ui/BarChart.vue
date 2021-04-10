<template>
  <v-chart ref = "chart" class="chart" :option="option" autoresize />
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
import "echarts"
import VChart, { THEME_KEY } from "vue-echarts";



export default {
  name: "BarChart",
  components: {
    VChart
  },
  props: ["xData","yData","unit","width"],
  data() {
    return {
      option:{
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: []
        },
        yAxis: {
          type: 'value'
        },
        tooltip: {
          trigger: 'item',
          formatter: '{b} : {c} ' + this.unit
        },
        series: [{
          data: [],
          type: 'bar',
          showBackground: true,
          barWidth: this.width,
          backgroundStyle: {
              color: 'rgba(180, 180, 180, 0.25)'
          }
        }]
      }
    }
  },
  mounted(){
    
    this.option.xAxis.data = this.xData
    this.option.series[0].data = this.yData.map(e=>{
      return Math.round(e)*1000/1000;
    })
    //this.$refs.chart.resize()
    //this.$forceUpdate()
    
  }

};
</script>

<style scoped>
.chart {
  height: 400px;
  padding-left: 2.5rem;

}
</style>