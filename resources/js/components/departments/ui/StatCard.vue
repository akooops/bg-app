<template>
    <div
        class="
            w-72
            h-24
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
                        mb-2
                        text-sm
                        font-medium
                        text-gray-600
                        dark:text-gray-400
                    "
                >
                    {{ title }}
                </p>
                <p
                    class="
                        text-lg
                        font-semibold
                        text-gray-700
                        dark:text-gray-200
                    "
                >
                    {{ value }}
                </p>
                <p class="text-md text-gray-700 dark:text-gray-200">
                    {{ secondValue }}
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
