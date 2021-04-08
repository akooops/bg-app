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
  name: "PieChart",
  components: {
    VChart
  },
  props: ["legend","serie"],
  watch:{
    serie:function(n,o){
      this.$forceUpdate()
    }
  },
  data() {
    return {
      option:{
   
    tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b} : {c} ({d}%)'
    },
    legend: {
        left: 'center',
        top: 'bottom',
        data: this.legend
    },
    center: ['20%', '50%'],
    toolbox: {
        show: true,
        feature: {
            mark: {show: true},
            dataView: {show: true, readOnly: false},
            restore: {show: true},
            saveAsImage: {show: true}
        }
    },
    series: [
        {
            name: 'Part du Marché',
            type: 'pie',
            radius: [50, 140],
            center: ['50%', '50%'],
            roseType: 'radius',
            itemStyle: {
                borderRadius: 5
            },
            label: {
                show: false
            },
            emphasis: {
                label: {
                    show: true
                }
            },
            data: []
        }
    ]
  }
  }
  },
  mounted(){
    
    this.option.legend.data = this.legend
    this.option.series[0].data = this.serie
    //this.$refs.chart.resize()
    //this.$forceUpdate()
    
  }

};
</script>

<style scoped>
.chart {
  height: 350px;
  margin-left: 3rem;
}
</style>