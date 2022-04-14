<template>
    <div class="flex items-center gap-3">
        <Notification :user="user" :actual="time"></Notification>
        <div class="flex items-center gap-3">
            <p class="font-semibold">
                <span class="uppercase">{{ user.name }}</span>
                Team
            </p>
            <div
                v-bind:class="
                    bg +
                    ' w-9 h-9 relative flex justify-center items-center rounded-full {{ bg }} text-sm text-white uppercase'
                "
            >
                {{ user.name.substr(0, 2) }}
            </div>
            <button
                @click="show_menu = !show_menu"
                class="relative focus:bg-vert focus:bg-opacity-5 p-1 focus:border-2 rounded-sm focus:border-Vn border-opacity-50"
            >
                <img
                    src="/assets/icons/chevron-down.svg"
                    alt="arrow down icon"
                    class="h-4 w-4"
                />
                <a
                    href="/logout"
                    v-if="show_menu"
                    class="flex items-center gap-2 absolute z-999 -bottom-14 right-0 bg-white border-opacity-5 border-vN shadow-md w-44 p-2 rounded-lg"
                    style="border-width: 1px"
                >
                    <img
                        src="/assets/icons/logout.svg"
                        alt="logout icon"
                        class="w-5 h-5"
                    />
                    <p>Se déconnecter</p>
                </a>
            </button>
        </div>
    </div>
</template>

<script>
import Notification from "./Notification";
export default {
    name: "SimulationTime",
    components: {
        Notification,
    },
    props: ["user"],
    data() {
        return {
            time: null,
            show_menu: false,
            caisse: 0,
            dettes: 0,
            bg: "",
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
                    this.caisse = resp.data["caisse"];
                    this.dettes = resp.data["dettes"];
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
        if (this.user.type == "entreprise") {
            window.Echo.channel("entreprise_" + this.user.id).listen(
                "NavbarDataChanged",
                (e) => {
                    this.caisse = e.caisse;
                    this.dettes = e.dettes;
                }
            );
        }
        let backgrounds = [
            "bg-red-500",
            "bg-orange-500",
            "bg-yellow-500",
            "bg-green-500",
            "bg-blue-500",
            "bg-indigo-500",
            "bg-purple-500",
        ];
        this.bg = backgrounds[Math.floor(Math.random() * backgrounds.length)];
    },
};
</script>

<style></style>
