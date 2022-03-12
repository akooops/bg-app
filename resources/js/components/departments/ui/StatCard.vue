<template>
    <div
        class="
            w-72
            h-28
            flex
            items-center
            rounded-lg
            shadow-md
            overflow-hidden
            bg-white
            dark:bg-gray-800
        "
    >
        <div class="p-4 flex items-center">
            <div class="p-3 rounded-full bg-orange-100 mr-4">
                <i :class="['fa', icon, 'text-3xl', color]"></i>
            </div>
            <div>
                <p
                    class="
                        mb-1
                        text-sm
                        font-small
                        text-gray-600
                        dark:text-gray-400
                    "
                >
                    {{ title }}
                </p>
                <p
                    v-for="(v, key) in value"
                    :key="key"
                    class="
                        text-md
                        font-semibold
                        text-gray-700
                        dark:text-gray-200
                    "
                >
                    {{ v }} <span v-if="secondValue != null" class="text-sm text-gray-700 dark:text-gray-200"> - {{ secondValue[key] }}</span>
                </p>
            </div>
        </div>
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
    ],
    mounted() {},
};
</script>
