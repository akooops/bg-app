<template>
    <div
        class="w-full flex flex-col items-center rounded-2xl gap-3 shadow-md bg-white py-8"
    >
        <div
            class="rounded-full bg-gradient-to-t from-lightVert to-lighterVert p-4"
        >
            <img :src="icon" :alt="title" />
        </div>
        <p class="w-28 h-12 text-center text-md font-normal text-vN">
            {{ title }}
        </p>
        <p
            v-for="(v, key) in value"
            :key="key"
            class="text-md font-medium text-gray"
        >
            {{ v }}
            <span
                v-if="secondValue != null"
                class="text-sm text-gray-700 dark:text-gray-200"
            >
                <span v-if="secondValue.length > key">
                    - {{ secondValue[key] }}
                </span>
            </span>

            <span
                v-if="thirdValue != null"
                class="text-sm text-gray-700 dark:text-gray-200"
            >
                <span v-if="thirdValue.length > key">
                    {{ thirdValue[key] }}
                </span>
            </span>
        </p>
    </div>
</template>

<script type="text/javascript">
export default {
    name: "StatCard",
    props: [
        "title",
        "subtitle",
        "value",
        "icon",
        "change",
        "color",
        "secondValue",
        "thirdValue",
        "ww",
    ],
    mounted() {},
};
</script>
