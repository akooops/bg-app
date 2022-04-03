<template>
    <div
        class="flex flex-col gap-3 items-center py-8 w-1/3 rounded-3xl bg-white shadow-md hover:shadow-lg"
    >
        <img
            :src="'/assets/icons/' + name + '.svg'"
            :alt="name + 'icon'"
            class="h-12 w-12"
        />
        <div class="text-center">
            <a
                class="font-semibold block mb-5 hover:text-vert text-vN text-2xl"
                :href="'/entreprise/department/' + name"
                >{{ name }}</a
            >

            <a
                :href="'/entreprise/department/' + name"
                class="bg-vert text-white px-3 py-2 rounded-full text-sm hover:bg-white hover:text-vert transition-all border border-transparent hover:border-vert text-center"
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
