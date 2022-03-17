<template>
    <div
        v-if="dette"
        class="bg-white flex flex-col p-2 shadow-md rounded-lg w-48"
    >
        <div class="flex items-center text-nav text-opacity-60 font-semibold">
            <img
                src="/assets/icons/dettes.svg"
                alt="dispo icon"
                class="h-10 w-10"
            />
            <p>Dettes</p>
        </div>
        <p class="font-bold text-vN pl-4">
            <number v-model="price" v-bind="number"></number
            >{{ Math.round(dettes).toLocaleString() }}
        </p>
    </div>
    <div v-else class="bg-white flex flex-col p-2 shadow-md rounded-lg w-48">
        <div class="flex items-center text-nav text-opacity-60 font-semibold">
            <img
                src="/assets/icons/disponibility.svg"
                alt="dispo icon"
                class="h-10 w-10"
            />
            <p>Disponibilités</p>
        </div>
        <p class="font-bold text-vN pl-4">
            {{ Math.round(caisse).toLocaleString() }}
        </p>
    </div>
</template>

<script>
export default {
    name: "Disponibility",
    props: ["user", "dette"],
    data() {
        return {
            show_menu: false,
            caisse: 0,
            dettes: 0,
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
                    this.caisse = resp.data["caisse"];
                    this.dettes = resp.data["dettes"];
                });
        },
    },
    mounted() {
        this.getSimulationData();
        if (this.user.type == "entreprise") {
            window.Echo.channel("entreprise_" + this.user.id).listen(
                "NavbarDataChanged",
                (e) => {
                    this.caisse = e.caisse;
                    this.dettes = e.dettes;
                }
            );
        }
    },
};
</script>
