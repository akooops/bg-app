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
import VChart from "vue-echarts";

export default {
  name: "SpeedoMeter",
  components: {
    VChart
  },
  props: ["data"],
  data() {
    return {
      option:{
       series: [{
        type: 'gauge',
        min: 0,
        max: 1,
        axisLine: {
            lineStyle: {
                width: 30,
                color: [
                    [0.3, '#fd666d'],
                    [0.7, '#37a2da'],
                    [1, '#67e0e3' ]
                ]
            }
        },
        pointer: {
            itemStyle: {
                color: 'auto'
            }
        },
        axisTick: {
            distance: -30,
            length: 8,
            lineStyle: {
                color: '#fff',
                width: 2
            }
        },
        splitLine: {
            distance: -30,
            length: 30,
            lineStyle: {
                color: '#fff',
                width: 4
            }
        },
        axisLabel: {
            color: 'auto',
            distance: -30,
            fontSize: 14
        },
        detail: {
            valueAnimation: false,
            formatter: '{value}',
            color: 'auto'
        },
        data: []
    }]
      }
    }
  },
  mounted(){
    
    this.option.series[0].data = this.data
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