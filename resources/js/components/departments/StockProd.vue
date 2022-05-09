<template>
    <div class="mt-10 py-2">
        <div v-if="!stock_loaded" class="flex flex-col items-center mt-16">
            <img class="w-16 h-16 load" src="/assets/logo/bg_logo.svg" alt="" />
            <div class="text-vN pt-2 font-semibold">Chargement...</div>
        </div>

        <table v-else class="border-collapse w-full table-auto shadow-md">
            <thead class="sticky top-0 border-b bg-white font-semibold text-vN">
                <tr>
                    <th class="p-3 text-sm table-cell"></th>

                    <th class="p-3 text-sm table-cell">Produit</th>

                    <th class="p-3 text-sm table-cell">Quantité en stock</th>

                    <th class="p-3 text-sm table-cell">Quantité en vente</th>

                    <th class="p-3 text-sm table-cell">Mettre en vente</th>

                    <th class="p-3 text-sm table-cell">Prix Minimal</th>

                    <th class="p-3 text-sm table-cell">Prix Maximal</th>

                    <th class="p-3 text-sm table-cell">Changer le prix</th>

                    <th class="p-3 text-sm table-cell">Profit unitaire</th>

                    <th class="p-3 text-sm table-cell"></th>
                </tr>
            </thead>
            <tbody>
                <tr
                    v-for="(item, key) in stock"
                    v-bind:key="key"
                    is="StockProdItem"
                    :user="user"
                    :item="item"
                ></tr>
            </tbody>
        </table>
    </div>
</template>

<script>
import StockProdItem from "./ui/StockProdItem";
export default {
    name: "StockProd",
    components: {
        StockProdItem,
    },

    props: ["user", "stock", "stock_loaded"],

    data() {
        return {
            // stock: [],
            // stock_loaded: false,
        };
    },

    methods: {
        // getStock() {
        //     axios
        //         .get("/api/entreprise/products-stock", {
        //             params: {
        //                 entreprise_id: this.user.id,
        //             },
        //         })
        //         .then((response) => {
        //             this.stock = response.data;
        //             this.stock_loaded = true;
        //         })
        //         .catch(function (error) {});
        // },
    },
    mounted() {

    },
    created() {

    }
};
</script>
