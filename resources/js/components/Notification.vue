<template>
    <div>
        <div
            class="z-[49] bg-opacity-30 absolute top-0 left-0 w-screen h-screen bg-gray-100"
            v-if="show_scenario_modal"
        ></div>
        <ScenarioModal
            v-if="show_scenario_modal"
            @close="show_scenario_modal = false"
            :event="event"
        />
        <div class="relative">
            <button @click="toggleNotifBox" class="icon-wrapper">
                <img
                    src="/assets/icons/notifications.svg"
                    alt="notification icon"
                    class="h-11 w-11"
                    :class="nb_unread_notifs > 0 ? 'horloge' : ''"
                />

                <div
                    v-if="nb_unread_notifs > 0"
                    class="bg-red-500 absolute -top-1 right-0 w-5 h-5 rounded-full"
                >
                    <p
                        class="text-white text-center my-auto mx-auto"
                        style="font-size: 12px"
                    >
                        {{ nb_unread_notifs }}
                    </p>
                </div>
            </button>

            <transition name="notifs">
                <div
                    v-if="show_notifications"
                    class="absolute dropDown min-w-[350px] w-max notif z-20 flex flex-col gap-1 bottom-22 right-0 bg-white shadow-2xl h-96 rounded-lg overflow-x-hidden overflow-y-scroll"
                    style="border: 0.5px solid rgba(128, 128, 128, 0.5)"
                >
                    <div class="flex flex-row mx-5 my-3">
                        <h1 class="text-vN font-semibold text-2xl mr-auto">
                            Notifications
                        </h1>
                    </div>

                    <NotificationItem
                        v-for="(notif, i) in notifications"
                        :key="i"
                        :title="notif.title"
                        :text="notif.text"
                        :time="notif.time"
                        :actual_time="actual"
                        :type="notif.type"
                        :icon="notif.icon_path"
                        class="mx-3 border-b-2 py-3"
                    >
                    </NotificationItem>
                </div>
            </transition>
        </div>
    </div>
</template>

<script>
import NotificationItem from "./departments/ui/NotificationItem";
import ScenarioModal from "./ScenarioModal";
export default {
    name: "Notification",
    components: {
        NotificationItem,
        ScenarioModal,
    },
    props: ["user", "actual"],
    data() {
        return {
            notifications: [],
            show_scenario_modal: false,
            show_notifications: false,
            event: "",
        };
    },
    computed: {
        nb_unread_notifs() {
            return this.notifications.filter((x) => x.read == false).length;
        },
    },
    methods: {
        getNotifications() {
            axios
                .get("/api/entreprise/notifications", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.notifications = resp.data["notifications"];
                })
                .catch((e) => {
                    console.log("Couldn't fetch notifications");
                });
        },
        toggleNotifBox() {
            this.show_notifications = !this.show_notifications;

            if (this.show_notifications && this.nb_unread_notifs > 0) {
                let unread_notifs = this.notifications.filter(
                    (x) => x.read == false
                );
                let unread_notifs_ids = unread_notifs.map((x) => x.id);

                this.notifications
                    .filter((x) => unread_notifs_ids.includes(x.id))
                    .forEach((notif) => {
                        notif.read = true;
                    });

                let data = {
                    read_notifications_ids: unread_notifs_ids,
                };

                axios.post("/api/entreprise/read-notifications", data);
            }
        },
        openNotifBox() {
            this.show_notifications = true;

            if (this.show_notifications && this.nb_unread_notifs > 0) {
                let unread_notifs = this.notifications.filter(
                    (x) => x.read == false
                );
                let unread_notifs_ids = unread_notifs.map((x) => x.id);

                this.notifications
                    .filter((x) => unread_notifs_ids.includes(x.id))
                    .forEach((notif) => {
                        notif.read = true;
                    });

                let data = {
                    read_notifications_ids: unread_notifs_ids,
                };

                axios.post("/api/entreprise/read-notifications", data);
            }
        },
    },
    created() {
        this.getNotifications();
    },
    mounted() {
        if (this.user.type == "entreprise") {
            window.Echo.channel("entreprise_" + this.user.id).listen(
                "NewNotification",
                (e) => {
                    if (e.notification.type === "GameReset") {
                        window.localStorage.clear();
                        document.location.href = "/";
                    }
                    if (e.notification.type === "ScenarioNotif") {
                        console.log(e.notification);
                        switch (e.notification.title) {
                            case "Changement climatique":                               //agg
                                this.event = "climat";                   //agg
                                localStorage.setItem(
                                    "current_event",
                                    JSON.stringify({
                                        name: "Changement climatique",                  //agg
                                        changes: {
                                            raw_materials: [
                                                {
                                                    name: "lin",                            //agg
                                                    new_value: 24000,                       //agg
                                                },
                                                {
                                                    name: "coton",                          //agg
                                                    new_value: 2900,                        //agg
                                                },

                                            ],
                                        },
                                    })
                                );
                                break;
                            case " Tremblement de terre Turquie":         //agg
                                this.event = "turquie";
                                localStorage.setItem(
                                    "current_event",
                                    JSON.stringify({
                                        name: " Tremblement de terre Turquie",
                                        changes: {
                                            raw_materials: [
                                                {
                                                    name: "coton",              //agg
                                                    new_value: 3300,             //agg
                                                },
                                                {
                                                    name: "laine",                    //agg
                                                    new_value: 11000,                  //agg
                                                },

                                            ],
                                        },
                                    })
                                );
                                break;
                            case "Un post d’un influenceur":
                                this.event = "influenceur";

                                break;
                            case "Reglement RH":
                                this.event = "rh";

                                break;
                            case "Les repercusions de la guerre":
                                this.event = "guerre";

                                break;
                            case "Les crises geopolitiques ":
                                this.event = "chine";

                                break;
                            case "Crise banque et inflations":
                                this.event = "banque";

                                break;
                            default:
                                this.event = "";
                                break;
                        }
                        this.show_scenario_modal = true;
                    }
                    this.getNotifications();
                    this.$forceUpdate();
                    if (
                        e.notification.style == "info" ||
                        e.notification.style == null
                    ) {
                        this.$toasted.show(e.notification.title, {
                            keepOnHover: true,
                            icon: {
                                name: "❕",
                            },
                            position: "bottom-right",
                            duration: 5000,
                            className: "toast-info",

                            action: [
                                {
                                    text: "Voir",
                                    onClick: (e, toastObject) => {
                                        window.scrollTo(0, 0);
                                        this.openNotifBox();
                                        toastObject.goAway(0);
                                    },
                                },
                                {
                                    text: "Fermer",
                                    onClick: (e, toastObject) => {
                                        toastObject.goAway(0);
                                    },
                                },
                            ],
                        });
                    } else if (e.notification.style == "success") {
                        this.$toasted.show(e.notification.title, {
                            keepOnHover: true,
                            icon: {
                                name: "✔",
                            },
                            position: "bottom-right",
                            className: "toast-success",
                            duration: 5000,
                            action: [
                                {
                                    text: "Voir",
                                    onClick: (e, toastObject) => {
                                        window.scrollTo(0, 0);
                                        this.openNotifBox();
                                        toastObject.goAway(0);
                                    },
                                },
                                {
                                    text: "Fermer",
                                    onClick: (e, toastObject) => {
                                        toastObject.goAway(0);
                                    },
                                },
                            ],
                        });
                    } else if (e.notification.style == "failure") {
                        this.$toasted.show(e.notification.title, {
                            keepOnHover: true,
                            icon: {
                                name: "❌",
                            },
                            position: "bottom-right",
                            className: "toast-error",
                            duration: 5000,
                            action: [
                                {
                                    text: "Voir",
                                    onClick: (e, toastObject) => {
                                        window.scrollTo(0, 0);
                                        this.openNotifBox();
                                        toastObject.goAway(0);
                                    },
                                },
                                {
                                    text: "Fermer",
                                    onClick: (e, toastObject) => {
                                        toastObject.goAway(0);
                                    },
                                },
                            ],
                        });
                    } else {
                        this.$toasted.show(e.notification.title, {
                            keepOnHover: true,
                            icon: {
                                name: "⚠️",
                            },
                            position: "bottom-right",
                            className: "toast-warning",
                            duration: 5000,
                            action: [
                                {
                                    text: "Voir",
                                    onClick: (e, toastObject) => {
                                        window.scrollTo(0, 0);
                                        this.openNotifBox();
                                        toastObject.goAway(0);
                                    },
                                },
                                {
                                    text: "Fermer",
                                    onClick: (e, toastObject) => {
                                        toastObject.goAway(0);
                                    },
                                },
                            ],
                        });
                    }
                }
            );
        }
    },
};
</script>

<style>
.toast-info {
    background-color: #c9e3ff !important;
    color: #7abef8 !important;
}

.toast-success {
    background-color: #def7ec !important;
    color: #3c6e4e !important;
}

.toast-error {
    background-color: #fde8e8 !important;
    color: #ca1e1e !important;
}

.toast-warning {
    background-color: #ffbc3e !important;
    color: white !important;
}

.toasted-container .toasted .action {
    color: black !important;
}

.notifs-leave-to {
    animation: closeNotifs 200ms ease-in-out forwards;
    transform-origin: top right;
}

@keyframes closeNotifs {
    0% {
        transform: scale(1);
    }

    100% {
        transform: scale(0);
    }
}
</style>
