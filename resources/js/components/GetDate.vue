<template>
<v-date-picker v-model="range" is-range />

<script>

export default {
    
    name: "GetDate",
    props: ["user"],
    data() {
        
        return {
            time: null,
            range: {
                 start: new Date(2020, 0, 1),
                 end: new Date(2020, 0, 5)
                   }       
            };
    },
   
    methods: {
        getSimulationData() {
            axios
                .get("/api/temps")
                .then((resp) => {
                    this.days = resp.data["temps"];
                    this.date = resp.data['date']
                });
        },
    },
    mounted() {
        this.getSimulationData();
        window.Echo.channel("simulation_date").listen(
            "SimulationDateChanged",
            (e) => {
                this.days = e.date;
            }
        );
     
    },
};
</script>