<template>
    <div class="mt-10">
        <div v-if="!stock_loaded" class="flex flex-col items-center mt-16">
            <img class="w-16 h-16 load" src="/assets/logo/bg_logo.svg" alt="">
            <div class="text-vN pt-2 font-semibold">Chargement... </div>
        </div>

        <table v-else class="border-collapse w-full table-fixed">
            <thead class="sticky top-0 border-b bg-white font-semibold text-vN">
                <tr>
                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Produit
                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Quantité en stock
                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Quantité en vente
                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Prix Minimal
                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Prix Maximal
                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Prix de vente
                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Profit unitaire
                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >

                    </th>

                </tr>
            </thead>
            <tbody>
                <tr
                    v-for="(item, key) in stock"
                    v-bind:key="key"
                    is="StockProdItem"
                    :user="user"
                    :item="item"
                >
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
import StockProdItem from "./ui/StockProdItem";
export default {
    name: "StockProd",
    components: {
        StockProdItem
    },

    props: ["user", "stock", "stock_loaded"],

    data() {
        return {
            // stock: [],
            // stock_loaded: false,
        };
    },

    methods: {
        getStock() {
            axios
                .get("/api/entreprise/products-stock", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((response) => {
                    this.stock = response.data;
                    this.stock_loaded = true;
                })
                .catch(function (error) {});
        },
    },
    mounted() {
        // window.Echo.channel("entreprise_" + this.user.id).listen(
        //     "NewNotification",
        //     (e) => {
        //         if (e.notification.type == "ProductionUpdate") {
        //             this.getStock();
        //             this.$forceUpdate();
        //         }

        //         if (e.notification.type == "ProdStockUpdate") {
        //             this.getStock();
        //             this.$forceUpdate();
        //         }
        //     }
        // );
    },
    created() {
        // this.getStock();
    }
};
</script>
