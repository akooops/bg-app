<template>
    <div>
      <div class="relative ">
        <button @click="openNotifBox" class=" icon-wrapper">
            <img
                src="/assets/icons/notifications.svg"
                alt="notification icon"
                class="h-9 w-9 "
                :class="nb_unread_notifs > 0 ? 'horloge': '' "
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

            <div v-if="show_notifications" class="absolute notif z-20 flex flex-col gap-1 bottom-22  right-0 bg-white shadow-2xl  h-96 rounded-lg overflow-x-hidden overflow-y-scroll " style="width: 48vmin ; border : 0.5px solid rgba(128, 128, 128, 0.5);  ">
                <div class="flex flex-row mx-5 my-3">
                    <h1 class="text-vN font-semibold text-2xl mr-auto">Notifications</h1>
                    <button class="ml-auto"><img src="/assets/icons/reload.svg" alt="" class="w-7 h-7"></button>
                </div>
               
                <NotificationItem
                    v-for="(notif, i) in notifications"
                    :key="i"
                    :title="notif.title"
                    :text="notif.text"
                    :time="notif.time"
                    :actual_time="actual"
                    :type="notif.type"
                    class="mx-3 border-b-2 py-3"
                >
                </NotificationItem>

            
            </div>
       
        </div>
    </div>
</template>

<script>
import NotificationItem from "./departments/ui/NotificationItem";
export default {
    name: "Notification",
    components: {
        NotificationItem,
    },
    props: ["user","actual"],
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
