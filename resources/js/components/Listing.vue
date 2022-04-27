<template>
    <div
        :class="
            'relative flex items-center justify-between bg-gradient-to-t  rounded-3xl py-7 px-4 text-vN mb-10 ' +
            bg
        "
    >
        <div class="flex items-center gap-4 font-heading font-semibold">
            <div class="bg-vN p-3 h-24 w-24 rounded-full">
                <img src="/assets/logo/IEC_WHITE.png" />
            </div>
            <div class="flex flex-col h-[96px] justify-between">
                <h1 class="uppercase text-2xl">{{ name }} team</h1>
                <div class="flex items-center gap-4">
                    <div class="flex flex-col items-center">
                        <p class="text-lg font-sans color-[#0B3434B2]">
                            Disponibilités
                        </p>
                        <p class="text-vert">{{ caisse }}</p>
                    </div>
                    <div class="flex flex-col items-center">
                        <p class="text-lg font-sans color-[#0B3434B2]">
                            Dettes
                        </p>
                        <p class="text-vert">{{ dettes }}</p>
                    </div>
                    <div class="flex flex-col items-center">
                        <p class="text-lg font-sans color-[#0B3434B2]">
                            Chiffre d'affaire
                        </p>
                        <p class="text-vert">{{ ca }}</p>
                    </div>
                </div>
            </div>
        </div>
        <div
            class="absolute flex flex-col items-center justify-center top-0 right-0 w-52 h-full bg-[#FFFFFFC9] text-vN rounded-bl-full text-2xl font-heading font-semibold"
        >
            <p class="text-center">{{ position }}</p>
            <p class="text-center">Rank</p>
        </div>
    </div>
</template>

<script>
export default {
    name: "Listing",
    props: ["name", "caisse", "dettes", "ca", "score", "position"],
    computed: {
        bg: function () {
            if (this.position == 1) {
                return "from-[#B2D06B3D] to-[#0B34344F]";
            } else if (this.position == 2) {
                return "from-[#FFBC3E00] via-[#B2D06B33] to-[#FFBC3E96]";
            } else {
                return "from-[#FFBC3E00] via-[#B2D06B33] to-[#B2D06BB0]";
            }
        },
    },
};
</script>
