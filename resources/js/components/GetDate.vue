<template>
<v-date-picker  v-model="range" is-range />

<script>
let dt= new Date(2020, 0, 1);
let ff= new Date(2020, 0, 7);


export default {
    name: "GetDate",
    props: ["user"],
    data() {
        
        return {
            time: null,
            date:null,
              range: {
      start: dt,
      end: df
    }
        };

            
    },
   
    methods: {
        getSimulationData() {
            axios
                .get("/api/temps")
                .then((resp) => {
                    this.time = resp.data["temps"];
                    this.date = resp.data['date'];
                });
        },
    },
    mounted() {
        this.getSimulationData();
        window.Echo.channel("simulation_date").listen(
            "SimulationDateChanged",
            (e) => {
                this.time = e.date;
            }
        );
     
    },
};
</script>