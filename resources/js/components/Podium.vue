<template>
    <div
        :class="
            'relative h-48 flex items-center bg-gradient-to-t rounded-3xl py-7 w-full px-4 text-vN mb-10 border-[#EEEEF2] '+bg
        "
    >   <div v-if="position == 1"
        class="mb-[200px]"
        >

        </div>
        <div class="flex flex-col h-3/4 items-start justify-between">
            <h1 class="uppercase text-2xl font-bold text-vN">
                {{ name }}
            </h1>
            <div class="flex items-center gap-4">
                <p class="text-2xl font-bold text-vN">
                    {{
                        Math.round(caisse)
                            .toLocaleString()
                            .split(/\s/)
                            .join(",")
                    }}
                </p>
                <img
                    src="/assets/icons/star.svg"
                    class="h-8 w-8"
                    alt="Star icon rating"
                />
            </div>
            <div
                class="absolute z-10 -top-10 -right-10 bg-vN p-3 h-20 w-20 rounded-full"
            >
                <img src="/assets/logo/IEC_WHITE.png" />
            </div>
            
            <div
                v-if="position == 1"
                class="z-0 absolute h-12 w-12 -top-16 -right-16 rotate-45 p-2"
            >
                <img src="/assets/icons/crown.svg" alt="crow icon" />
            </div>
            <div
                v-if="position == 2"
                class="z-100 absolute h-12 w-12 top-6 -right-6 "
            >
                <img src="/assets/icons/second.svg" alt="second place icon" />
            </div>
            <div
                v-if="position == 3"
                class="z-100 absolute h-14 w-14 top-2 -right-6"
            >
                <img src="/assets/icons/3rd.svg" alt="third place icon" />
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Podium",
    props: ["name", "caisse", "dettes", "ca", "score", "position"],
    computed: {
        bg: function () {
            if (this.position == 1) {
                return "from-[#FFBC3E82] to-[#FFBC3E28]";
            } else if (this.position == 2) {
                return "from-[#0B34343B] via-[#0B343418] to-[#0B34341F]";
            } else {
                return "from-[#FFBC3E2F] via-[#FFBC3E28] to-[#FFBC3E66]";
            }
        },
    },
};
</script>
