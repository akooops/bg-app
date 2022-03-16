<template>
    <div v-if="dette" class="bg-white flex flex-col p-2">
        <p>Dettes</p>
        <div class="flex items-center">
            <p class="font-bold">
                {{ dettes }}
            </p>
        </div>
    </div>
    <div v-else class="bg-white flex flex-col p-2">
        <p>Disponibilités</p>
        <div class="flex items-center">
            <p class="font-bold">
                {{ caisse }}
            </p>
        </div>
    </div>
</template>

<script>
export default {
    name: "SimulationTime",
    props: ["user", "dette"],
    data() {
        return {
            show_menu: false,
            caisse: "",
            dettes: "",
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
        console.log(this.dette);
    },
};
</script>
