<template>
    <div
        class="
            w-1/3
            mr-3
            my-2
            max-w-sm
            overflow-hidden
            rounded
            border
            bg-white
            shadow
        "
    >
        <div class="relative">
            <div class="flex h-32 justify-center items-center">
                <i :class="'fa ' + icon" class="text-blue-500 text-6xl"></i>
            </div>
        </div>
        <div class="p-3 text-center">
            <h3 class="text-lg font-extrabold mb-4 truncate-2nd">
                <a
                    class="hover:text-blue-500"
                    :href="'/entreprise/department/' + name"
                    >Département {{ name }}</a
                >
            </h3>

            <a
                :href="'/entreprise/department/' + name"
                class="bg-green-400 text-white px-3 py-1 rounded text-center"
            >
                Accéder
            </a>
        </div>
    </div>
</template>

<script type="text/javascript">
export default {
    name: "DepartmentCard",
    data() {
        return {
            message: "hello",
        };
    },
    props: ["name", "icon"],
};
</script>
