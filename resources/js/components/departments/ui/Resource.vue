<template>
    <div class="">
        <div>
            <CircleChart
                :legend="[
                    machine[0].name.replace('Machines -', ''),
                    machine[1].name.replace('Machines -', ''),
                    machine[2].name.replace('Machines -', ''),
                ]"
                orient="vertical"
                left="10%"
                bottom="center"
                :serie="machine"
                :simple="false"
                class="vv"
            ></CircleChart>
        </div>
        <div class="flex flex-row w-5/6 mx-auto mt-2">
            <div class="rounded-l-full bg-vN h-2 w-full"></div>
            <div class="rounded-r-full bg-jaune h-2 w-full"></div>
        </div>

        <div class="w-full flex justify-around mt-6 mb-6">
            <div class="flex flex-col w-max gap-3">
                <div class="flex flex-row items-center gap-4">
                    <div class="w-4 h-4 rounded-full bg-vN"></div>
                    <h1>Machines Occupés</h1>
                </div>
                <div class="flex flex-row items-center gap-4">
                    <div class="w-4 h-4 rounded-full bg-jaune"></div>
                    <h1>Machines libres</h1>
                </div>
            </div>
            <div class="flex flex-col w-max justify-center gap-3">
                <p class="text-center">{{ machine_used }}</p>
                <p class="text-center">{{ free_machines }}</p>
            </div>
            <div class="flex flex-col w-max gap-3">
                <p
                    class="text-center rounded-full px-2"
                    style="background: rgba(230, 242, 254, 1)"
                >
                    {{ Math.round((machine_used / total_machines) * 100) }}%
                </p>
                <p
                    class="text-center rounded-full px-2"
                    style="background: rgba(230, 242, 254, 1)"
                >
                    {{ Math.round((free_machines / total_machines) * 100) }}%
                </p>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Resource",
    components: {},
    props: [],
    watch: {},
    data() {
        return {};
    },
    mounted() {},
};
</script>
