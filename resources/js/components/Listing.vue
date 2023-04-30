<template>
    <div
        class="relative flex items-center rounded-[41px] py-4 w-full px-1 text-vN bg-gradient-to-t from-[#C59866] to-[#FAEEDE]"
    >
        <div
            class="relative only:flex items-center font-heading font-semibold w-full"
        >
            <div class="flex items-center gap-4">
                <div class="bg-vN p-3 h-20 w-20 rounded-full">
                    <img src="/assets/logo/IEC_WHITE.png"/>
                </div>
                <span class="text-center" style="
                    color: #000;
                    height: 25px;
                    width: 25px;
                    background-color: #bbb;
                    border-radius: 50%;
                    display: inline-block;">
                {{ position }}
                </span>
                <h1 class="uppercase text-2xl font-bold text-vN">
                    {{ name }}
                </h1>
            </div>
            <!-- <div
                class="absolute flex flex-col items-center justify-center top-0 right-0 w-52 h-full bg-[#FFFFFFC9] text-vN rounded-bl-full text-2xl font-heading font-semibold rounded"
            >
                <p class="text-center">#{{ position }}</p>
                <p class="text-center">Rank</p>
            </div> -->
            <div
                class="absolute flex items-center gap-4 mx-auto right-[40px] bottom-1/2 border border-[10px] bg-[#FAEEDE] " 
            >
                
                <p class="text-2xl font-bold text-vN">
                    {{
                        Math.round(caisse)
                            .toLocaleString()
                            .split(/\s/)
                            .join(",")
                    }}
                </p>
                <!-- <img
                    src="/assets/icons/star.svg"
                    class="h-8 w-8"
                    alt="Star icon rating"
                /> -->
            </div>
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
