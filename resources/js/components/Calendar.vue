<template>
    <div
        class="flex flex-col items-center gap-5 ml-6 bg-gradient-to-r from-[#B2D06B45] to-[#B2D06B15] rounded-xl px-2 py-2"
    >
        <div class="flex item-center gap-6 my-5">
            <div class="flex flex-col font-semibold items-center">
                <p class="text-vN text-3xl py-4 px-4 shadow-md rounded-md mb-1">
                    {{ time }}
                </p>
                <p class="text-sm text-nav">Semaines</p>
            </div>
            <div
                class="h-16 mt-1 border-opacity-60 border-l-2 border-nav"
            ></div>
            <div class="flex flex-col items-center font-semibold">
                <p class="text-vN text-3xl py-4 px-4 shadow-md rounded-md mb-1">
                    {{ months[(time % 48) - 1] }}
                </p>
                <p class="text-sm text-nav">Mois</p>
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
            months: [
                "Janvier",
                "Janvier",
                "Janvier",
                "Janvier",
                "Février",
                "Février",
                "Février",
                "Février",
                "Mars",
                "Mars",
                "Mars",
                "Mars",
                "Avril",
                "Avril",
                "Avril",
                "Avril",
                "Mai",
                "Mai",
                "Mai",
                "Mai",
                "Juin",
                "Juin",
                "Juin",
                "Juin",
                "Juillet",
                "Juillet",
                "Juillet",
                "Juillet",
                "Août",
                "Août",
                "Août",
                "Août",
                "Sep",
                "Sep",
                "Sep",
                "Sep",
                "Octobre",
                "Octobre",
                "Octobre",
                "Octobre",
                "Novembre",
                "Novembre",
                "Novembre",
                "Novembre",
                "Décembre",
                "Décembre",
                "Décembre",
                "Décembre",
            ],
        };
    },
    // computed: {
    //     monthIdx() {
    //         if (Math.ceil((this.time_copy * 7) / 30) - 1 > 11) {
    //             this.time_copy = 1;
    //             return Math.ceil((this.time_copy * 7) / 30) - 1;
    //         }
    //         return Math.ceil((this.time_copy * 7) / 30) - 1;
    //     },
    // },
    watch: {},
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
