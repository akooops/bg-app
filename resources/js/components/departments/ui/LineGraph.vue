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
  name: "LineGraph",
  components: {
    VChart
  },
  props: ["xData","yData"],
  data() {
    return {
      option:{
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: [],
          name: 'Prix'
        },
        yAxis: {
          type: 'value',
          name: 'Unités'
        },
        tooltip:{
          show:true
        },
        series: [{
          data: [],
          type: 'line',
          smooth: true,
          areaStyle: {},
        }]
      }
    }
  },
  mounted(){
    
    this.option.xAxis.data = this.xData
    this.option.series[0].data = this.yData
    //this.$refs.chart.resize()
    //this.$forceUpdate()
    
  }

};
</script>

<style scoped>
.chart {
  height: 250px;

}
</style>