<template>
    <tr
        class="bg-white flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-gray text-vN font-light text-sm h-14"
    >
        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <!-- <img
                :src="'/assets/icons/' + item.icon"
                :alt="item.name"
                class="mx-auto w-10 h-10"
            /> -->
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.product }}
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.quantity }}
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.quantity_selling }}
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static bg-slate-100"
        >
            <!-- {{ item.quantity_selling }} -->
            <input
                type="number"
                v-model.number="quantity_selling"
                :min="0"
                :max="item.quantity"
                step="10"
                class="w-4/5 text-center ring-1 ring-tableBorder border-0 focus-within:ring-vert"
            />
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.price_min }}
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.price_max }}
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static bg-slate-100"
        >
            <input
                type="number"
                v-model.number="price"
                :min="item.price_min"
                :max="item.price_max"
                class="w-4/5 text-center ring-1 ring-tableBorder border-0 focus-within:ring-vert"
            />
        </td>

        <!-- <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ price - item.dist_cost }}
        </td> -->

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <button
                @click="apply_changes(item)"
                class="rounded-3xl font-semibold px-3 py-2 bg-vert text-white"
                :class="
                    new_changes && canSell
                        ? 'bg-vert'
                        : sending_changes
                        ? 'bg-blue-200'
                        : canSell
                        ? 'bg-gris text-vN'
                        : 'bg-red-500'
                "
                :disabled="
                    !new_changes ||
                    sending_changes ||
                    !canSell
                "
            >
                Vendre
            </button>
        </td>
    </tr>
</template>

<script type="text/javascript">
export default {
    name: "StockProdItem",
    props: ["user", "item"],
    data() {
        return {
            new_changes: false,

            sending_changes: false,

            price: this.item.price,
            quantity_selling: 0,
        };
    },

    methods: {
        apply_changes(product) {
            if (this.new_changes) {
                this.sending_changes = true;
                this.new_changes = false;

                let data = {
                    entreprise_id: this.user.id,
                    product_id: product.id,

                    new_selling_quantity:
                        this.quantity_selling + this.item.quantity_selling,
                    new_price: this.price,
                };

                let price_temp = this.item.price;
                let quant_temp = this.item.quantity;
                let quant_sell_temp = this.item.quantity_selling;

                this.item.price = this.price;
                this.item.quantity -= this.quantity_selling;
                this.item.quantity_selling += this.quantity_selling;

                this.quantity_selling = 0;

                axios
                    .post("/api/entreprise/sell-product", data)
                    .then((resp) => {
                        this.sending_changes = false;

                        if (resp.data.success) {
                            this.$toasted.success(
                                "Données de vente mises à jour",
                                {
                                    keepOnHover: true,
                                    icon: {
                                        name: "✔",
                                    },
                                    position: "bottom-right",
                                    className: "toast-success",
                                    duration: 2000,
                                }
                            );
                        } else {
                            this.new_changes = true;

                            this.item.price = price_temp;
                            this.item.quantity = quant_temp;
                            this.item.quantity_selling = quant_sell_temp;
                        }
                    });
            }
        },
    },

    watch: {
        quantity_selling: function () {
            if (this.quantity_selling > this.item.quantity) {
                this.quantity_selling = this.item.quantity;
            } else if (this.quantity_selling < 0) {
                this.quantity_selling = 0;
            }

            if (this.quantity_selling == 0 && this.price == this.item.price) {
                this.new_changes = false;
            } else {
                this.new_changes = true;
            }
        },

        price: function () {
            // if (this.price < this.item.price_min) {
            //     this.price = this.item.price_min;
            // } else if (this.item.price_max < this.price) {
            //     this.price = this.item.price_max;
            // }

            if (this.quantity_selling == 0 && this.price == this.item.price) {
                this.new_changes = false;
            } else {
                this.new_changes = true;
            }
        },

        // "item.quantity_selling": function () {
        //     this.quantity_selling = this.item.quantity_selling;
        // },
    },

    computed: {
        canSell() {
            if (
                this.quantity_selling > this.item.quantity ||
                this.quantity_selling < 0
            ) {
                return false;
            }

            if (
                this.price < this.item.price_min ||
                this.item.price_max < this.price
            ) {
                return false;
            }

            return true;
        },
    },

    mounted() {},
};
</script>

<style>
.toast-success {
    background-color: #def7ec !important;
    color: #3c6e4e !important;
}
.toast-error {
    background-color: #fde8e8 !important;
    color: #ca1e1e !important;
}
</style>
