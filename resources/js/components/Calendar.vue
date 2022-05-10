<template>
    <div class="flex flex-col items-center gap-5 ml-6">
        <div class="flex item-center gap-6 my-5">
            <div class="flex flex-col font-semibold items-center">
                <p class="text-jaune py-2 px-4 shadow-sm rounded-md mb-1">
                    {{ time }}
                </p>
                <p class="text-xs text-nav">Semaines</p>
            </div>
            <div class="h-8 mt-1 border-opacity-60 border-l-2 border-nav"></div>
            <div class="flex flex-col items-center font-semibold">
                <p class="text-vN py-2 px-4 shadow-sm rounded-md mb-1">
                    {{ time / 4 }}
                </p>
                <p class="text-xs text-nav">Mois</p>
            </div>
        </div>
        <!-- <vc-date-picker
            ref="datepicker"
            color="orange"
            v-model="range"
            :disabled-dates="{}"
            is-range
        ></vc-date-picker> -->
    </div>
</template>

<script>
export default {
    name: "Calendar",
    props: ["user"],
    data() {
        return {
            time: 1,

            range: {
                start: new Date("2022-04-17"),
                end: new Date("2022-04-25"),
            },
        };
    },
    methods: {
        getSimulationData() {
            axios
                .get("/api/navbar", {
                    params: {
                        entreprise_id: this.user.id,
                        type: this.user.type,
                    },
                })
                .then((resp) => {
                    this.time = resp.data["time"];
                });
        },
    },

    mounted() {
        //  this.enddate();

        // const datePicker = this.$refs.datepicker;
        this.getSimulationData();
        // datePicker.move(new Date(2022, 1, this.time));

        window.Echo.channel("simulation_date").listen(
            "SimulationDateChanged",
            (e) => {
                this.time = e.date;
            }
        );
    },
};
</script>

<style></style>
