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
            <!-- {{ item.quantity_selling }} -->
            <input
                type="number"
                v-model.number="quantity_selling"
                :min="item.quantity_selling"
                :max="item.quantity_selling + item.quantity"
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
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <input
                type="number"
                v-model.number="price"
                :min="item.price_min"
                :max="item.price_max"
                class="w-4/5 text-center ring-1 ring-tableBorder border-0 focus-within:ring-vert"
            />
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ price - item.dist_cost }}
        </td>

        <td
            class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <button
                @click="apply_changes(item)"
                class="rounded-3xl font-semibold px-3 py-2 bg-vert text-white"
                :class="
                    new_changes
                        ? 'bg-vert'
                        : sending_changes
                        ? 'bg-blue-200'
                        : 'bg-gris text-black'
                "
                :disabled="!new_changes || sending_changes"
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
            quantity_selling: this.item.quantity_selling,
        };
    },

    methods: {
        apply_changes(product) {
            if (this.new_changes) {
                this.item.price = this.price;
                this.item.quantity -=
                    this.quantity_selling - this.item.quantity_selling;
                this.item.quantity_selling = this.quantity_selling;

                this.new_changes = false;
                this.sending_changes = true;

                let data = {
                    entreprise_id: this.user.id,
                    product_id: product.id,

                    new_selling_quantity: this.quantity_selling,
                    new_price: this.price,
                };

                axios
                    .post("/api/entreprise/sell-product", data)
                    .then((resp) => {
                        this.sending_changes = false;
                    });
            }
        },
    },

    watch: {
        quantity_selling: function () {
            if (this.quantity_selling < this.item.quantity_selling) {
                this.quantity_selling = this.item.quantity_selling;
            } else if (
                this.quantity_selling - this.item.quantity_selling >=
                this.item.quantity
            ) {
                this.quantity_selling = this.item.quantity;
            } else if (
                this.quantity_selling == this.item.quantity_selling &&
                this.price == this.item.price
            ) {
                this.new_changes = false;
            } else {
                this.new_changes = true;
            }
        },

        price: function () {
            if (this.price <= this.item.price_min) {
                this.price = this.item.price_min;
            } else if (this.price >= this.item.price_max) {
                this.price = this.item.price_max;
            } else if (
                this.quantity_selling == this.item.quantity_selling &&
                this.price == this.item.price
            ) {
                this.new_changes = false;
            } else {
                this.new_changes = true;
            }
        },

        "item.quantity_selling": function () {
            this.quantity_selling = this.item.quantity_selling;
        },
    },

    mounted() {},
};
</script>
