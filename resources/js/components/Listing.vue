<template>
    <div
        class="relative flex items-center bg-gradient-to-t rounded-[41px] py-7 w-full px-4 text-vN mb-10 bg-[#0B343414]"
    >
        <div class="flex items-center font-heading font-semibold w-full">
            <div class="flex items-center gap-4">
                <div class="bg-vN p-3 h-20 w-20 rounded-full">
                    <img src="/assets/logo/IEC_WHITE.png" />
                </div>
                <h1 class="uppercase text-2xl font-bold text-vN">
                    {{ name }} team
                </h1>
            </div>
            <div class="flex items-center gap-4 mx-auto">
                <p class="text-2xl font-bold text-vN">
                    {{ Math.round(caisse).toLocaleString() }}
                </p>
                <img
                    src="/assets/icons/star.svg"
                    class="h-8 w-8"
                    alt="Star icon rating"
                />
            </div>
        </div>
        <div
            class="absolute flex flex-col items-center justify-center top-0 right-0 w-52 h-full bg-[#FFFFFFC9] text-vN rounded-bl-full text-2xl font-heading font-semibold rounded"
        >
            <p class="text-center">{{ position }}</p>
            <p class="text-center">Rank</p>
        </div>
    </div>
</template>

<script>
export default {
    name: "Listing",
    props: ["name", "caisse", "position"],
    computed: {},
};
</script>
