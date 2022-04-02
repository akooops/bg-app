<template>
    <div>
        <p v-if="stock.length == 0">
            Votre stock est vide pour le moment, lancez des commandes !
        </p>
        <table v-else class="border-collapse w-full">
            <thead>
                <tr>
                    <!-- <th
                        class="
                            p-3
                            font-bold
                            uppercase
                            bg-gray-200
                            text-gray-600
                            border border-gray-300
                            hidden
                            lg:table-cell
                        "
                    >
                        Numéro
                    </th> -->
                    <th
                        class="
                            p-3
                            font-bold
                            uppercase
                            bg-gray-200
                            text-gray-600
                            border border-gray-300
                            hidden
                            lg:table-cell
                        "
                    >
                        Matière
                    </th>
                    <th
                        class="
                            p-3
                            font-bold
                            uppercase
                            bg-gray-200
                            text-gray-600
                            border border-gray-300
                            hidden
                            lg:table-cell
                        "
                    >
                        Quantité
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr
                    v-for="(item, key) in stock"
                    v-bind:key="key"
                    class="
                        bg-white
                        lg:hover:bg-gray-100
                        flex
                        lg:table-row
                        flex-row
                        lg:flex-row
                        flex-wrap
                        lg:flex-no-wrap
                        mb-10
                        lg:mb-0
                    "
                >
                    <!-- <td
                        class="
                            w-full
                            lg:w-auto
                            p-3
                            text-gray-800 text-center
                            border border-b
                            block
                            lg:table-cell
                            relative
                            lg:static
                        "
                    >
                        {{ item.id }}
                    </td> -->
                    <td
                        class="
                            w-full
                            lg:w-auto
                            p-3
                            text-gray-800 text-center
                            border border-b
                            block
                            lg:table-cell
                            relative
                            lg:static
                        "
                    >
                        {{ item.material }}
                    </td>
                    <td
                        class="
                            w-full
                            lg:w-auto
                            p-3
                            text-gray-800 text-center
                            border border-b
                            font-extrabold
                            block
                            lg:table-cell
                            relative
                            lg:static
                        "
                    >
                        {{ item.quantity }} KG
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
        return {
        };
    },
    props: ["user", "stock"],
    methods: {

    },
    mounted() {

    },
};
</script>

