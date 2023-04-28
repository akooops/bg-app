<template>
    <div
        class="flex gap-3 w-1/4 justify-evenly items-center rounded-xl p-1 bg-white shadow-sm"
    >
        <img
            class="h-12 w-12 p-1"
            src="/assets/icons/nv/money.svg"
            alt="chiffre d'affaire icon"
        />
        <div class="flex items-center flex-col gap-1">
            <h1 class="text-vN text-lg font-medium font-heading">
                Chiffre d'affaire
            </h1>
            <span class="text-vN text-opacity-80 text-lg"
                >{{
                    Math.round(indicators["ca"].value).toLocaleString().split(/\s/).join(',')
                }}
                DA</span
            >
        </div>
    </div>
</template>

<script>
export default {
    name: "Indicator",
    props: ["indicators"],
    data() {
        return {
            // indicators: {
            //     ca: {
            //         value: 0,
            //     },
            // },
        };
    },
};
</script>
