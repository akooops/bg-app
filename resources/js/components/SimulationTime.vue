<template>
    <div class="flex items-center gap-3">
        <Notification :user="user" :actual="time"></Notification>
        <div class="flex items-center gap-3">
            <p class="font-semibold">
                <span class="uppercase">{{ user.name }}</span>
                Team
            </p>
            <div
                class="w-12 p-1 h-12 relative flex justify-center items-center rounded-full text-sm text-white uppercase bg-vN"
            >
                <img src="/assets/logo/IEC_WHITE.png" alt="IEC logo" />
            </div>
            <button
                @click="show_menu = !show_menu"
                class="relative block focus:bg-vert focus:bg-opacity-5 p-1 focus:border rounded-sm focus:border-Vn border-opacity-50"
            >
                <img
                    src="/assets/icons/chevron-down.svg"
                    alt="arrow down icon"
                    class="h-5 w-5"
                />
                <transition name="logout">
                    <a
                        href="/logout"
                        v-if="show_menu"
                        class="z-10 flex flex-row justify-between dropDown w-max gap-2 absolute z-999 -bottom-16 right-0 bg-white border-opacity-5 border-vN shadow-md p-3 rounded-lg"
                        style="border-width: 1px"
                    >
                        <img
                            src="/assets/icons/logout.svg"
                            alt="logout icon"
                            class="w-5 h-5"
                        />
                        <p>Se déconnecter</p>
                    </a>
                </transition>
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

        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NewNotification",
            (e) => {
                if (e.notification.type == "AdminNotif") {
                    this.getSimulationData();
                    this.$forceUpdate();
                }
            }
        );
        window.Echo.channel("simulation_date").listen(
            "SimulationDateChanged",
            (e) => {
                // console.log("kimmm");
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
    },
};
</script>

<style>
.logout-leave-to {
    animation: closeLogout 200ms ease-in-out forwards;
    transform-origin: top right;
}

@keyframes closeLogout {
    0% {
        transform: scale(1);
    }

    100% {
        transform: scale(0);
    }
}
</style>
