<template>
    <div>
        <button @click="openNotifBox" class="relative">
            <img
                src="/assets/icons/notifications.svg"
                alt="notification icon"
                class="h-9 w-9"
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

            <div v-if="show_notifications" class="absolute flex flex-col gap-1 content-center items-center bottom-22 right-0 bg-blue-300 border-black w-80 h-96 rounded-lg overflow-x-hidden overflow-y-scroll z-100">
                <NotificationItem
                    v-for="(notif, i) in notifications"
                    :key="i"
                    :title="notif.title"
                    :text="notif.text"
                    :time="notif.time"
                    :real_time="notif.created_at"
                >
                </NotificationItem>

                <!-- <p v-for="(notif, i) in notifications" :key="i">
                    {{ notif }}
                </p> -->
            </div>
        </button>
    </div>
</template>

<script>
import NotificationItem from "./departments/ui/NotificationItem";
export default {
    name: "Notification",
    components: {
        NotificationItem,
    },
    props: ["user"],
    data() {
        return {
            notifications: [],

            show_notifications: false,
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
        openNotifBox() {
            this.show_notifications = !this.show_notifications;

            if (this.show_notifications && this.nb_unread_notifs > 0) {
                let unread_notifs = this.notifications.filter((x) => x.read == false);
                let unread_notifs_ids = unread_notifs.map(x => x.id);

                this.notifications.filter(x => unread_notifs_ids.includes(x.id)).forEach((notif) => {
                    notif.read = true;
                });

                let data = {
                    "read_notifications_ids": unread_notifs_ids,
                };

                axios
                    .post("/api/entreprise/read-notifications", data);
            }
        }
    },
    created() {
        this.getNotifications();
    },
    mounted() {
        if (this.user.type == "entreprise") {
            window.Echo.channel("entreprise_" + this.user.id).listen(
                "NewNotification",
                (e) => {
                    this.getNotifications();
                    this.$forceUpdate();
                }
            );
        }
    },
};
</script>

<style>
</style>
