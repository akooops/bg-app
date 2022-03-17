<template>
    <div class="w-full rounded-3xl bg-white shadow-md">
        <div class="relative">
            <div class="flex h-32 justify-center items-center">
                <!-- <i :class="'fa ' + icon" class="text-vert text-6xl"></i> -->
                <img
                    :src="'/assets/icons/' + name + '.svg'"
                    alt=""
                    class="h-36 w-36"
                />
            </div>
        </div>
        <div class="p-3 text-center">
            <h3 class="text-lg font-bold mb-4">
                <a
                    class="hover:text-vert text-vN"
                    :href="'/entreprise/department/' + name"
                    >{{ name }}</a
                >
            </h3>

            <a
                :href="'/entreprise/department/' + name"
                class="bg-vert text-white px-3 py-1 rounded-full hover:bg-white hover:text-vert transition-all border border-transparent hover:border-vert text-center"
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
        return {};
    },
    props: ["name"],
};
</script>
