<template>
    <div>
        <div v-if="stock.length == 0" class="w-full flex flex-col items-center">
            <p class="text-lg text-vN mt-2 ml-3">
                Votre stock est vide pour le moment, lancez des commandes !
            </p>
            <button
                @click="$emit('create-command')"
                class="text-vN rounded-3xl px-5 py-2 font-semibold mt-5 bg-gradient-to-t from-[#B2D06B40] to-[#B2D06B11]"
                href="#"
            >
                Créer une commande
            </button>
        </div>

        <table v-else class="border-collapse w-full table-fixed">
            <thead class="sticky top-0 border-b bg-white font-semibold text-vN">
                <tr>
                    <th class="p-3 text-sm table-cell"></th>
                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                        @click="sort('material')"
                    >
                        Matière
                    </th>
                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                        @click="sort('quantity')"
                    >
                        Quantité
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr
                    v-for="(item, key) in stock"
                    v-bind:key="key"
                    class="bg-white flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-gray text-vN font-light text-sm h-14"
                >
                    <td
                        class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                    >
                        <img
                            src="/assets/icons/khobz.png"
                            alt="khobz"
                            class="mx-auto w-10 h-10"
                        />
                    </td>
                    <td
                        class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                    >
                        {{ item.material }}
                    </td>
                    <td
                        class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                    >
                        {{ item.quantity }}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
export default {
    name: "Stock",
    data() {
        return {};
    },
    props: ["user", "stock"],
    methods: {},
    mounted() {},
    methods: {
        sort(key) {
            this.reverse = !this.reverse;
            this.stock.sort((a, b) => {
                if (a[key] < b[key]) {
                    return this.reverse ? -1 : 1;
                }
                if (a[key] > b[key]) {
                    return this.reverse ? 1 : -1;
                }
                console.log(this.commands);
                return 0;
            });
        },
    },
};
</script>
