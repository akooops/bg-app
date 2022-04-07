<template>
  <div class="bg-red-500 border-2 border-red-700 w-64">
      <p>{{ title }}</p>
      <p>{{ text }}</p>
      <p>Semaine {{ time }} ( {{ getHour(real_time) }} )</p>
  </div>
</template>

<script type="text/javascript">
export default {
    name: "NotificationItem",
    props: ["title", "text", "time", "real_time", "type"],
    data() {
        return {

        };
    },
    methods: {
        getHour(time) {
            return (new Date(time).getUTCHours() + "h" + new Date(time).getUTCMinutes());
        },
    },
    created() {

    },
};
</script>
