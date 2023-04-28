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
  name: "HBarChart",
  components: {
      VChart,
  },
  props: ["produit_en_stock", "produit_vendu", "width"],
  data() {
      return {
          option: {
tooltip: {
  trigger: 'axis',
  axisPointer: {
    // Use axis to trigger tooltip
    type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
  }
},
legend: {},
grid: {
  left: '3%',
  right: '4%',
  bottom: '3%',
  containLabel: true
},
xAxis: {
  type: 'value'
},
yAxis: {
  type: 'category',
  data: ['Pantalon cargo','Pantalon portofino','Robe de mariée à dos ouvert',
       'T-shirt','Polo rugby','Pull à col rond','Parkas','Richelieu','Tuxedo',
      'Jupe ajustée a taille ceinturée','Jupe longue','Pull à col bâteau']
},
series: [
  {
    name: 'Quantité vendu',
    type: 'bar',
    stack: 'total',
    label: {
      show: true
    },
    emphasis: {
      focus: 'series'
    },
    data: [320, 302, 301, 334, 390, 330, 320],
    color: "rgba(11, 52, 52, 1)",
  },
  {
    name: 'Quantité en stock',
    type: 'bar',
    stack: 'total',
    label: {
      show: true
    },
    emphasis: {
      focus: 'series'
    },
    data: [120, 132, 101, 134, 90, 230, 210],
    color: "rgba(255, 188, 62, 1)",
  },
 


]
},
      };
  },
  mounted() {
      
      this.option.series[1].data = this.produit_en_stock ; 
      this.option.series[0].data = this.produit_vendu ; 

      //this.$refs.chart.resize()
      //this.$forceUpdate()
  },
};
</script>


