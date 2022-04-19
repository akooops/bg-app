<template>
    <tr>
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
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.product }}
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.quantity }}
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <!-- {{ item.quantity_selling }} -->
            <input type="number" v-model.number="quantity_selling" :min="item.quantity_selling" :max="item.quantity" class="w-2/3 text-center">
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.price_min }}
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.price_max }}
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <input type="number" v-model.number="price" :min="item.price_min" :max="item.price_max" class="w-2/3 text-center">
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <button
                @click="apply_changes(item)"
                class="p-1 px-2 rounded-full text-vN"
                :class="
                    new_changes ? 'bg-vert' : 'bg-gray-400'
                "
                :disabled="!new_changes"
            >
                Appliquer changements
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

            price: this.item.price,
            quantity_selling: this.item.quantity_selling,
        };
    },

    methods: {
        apply_changes(product) {
            if (this.new_changes) {
                this.item.price = this.price;
                this.item.quantity_selling = this.quantity_selling;

                this.new_changes = false;

                let data = {
                    entreprise_id: this.user.id,
                    product_id: product.id,

                    new_selling_quantity: this.quantity_selling,
                    new_price: this.price,
                };

                axios
                    .post("/api/entreprise/sell-product", data)
                    .then((resp) => {

                    });
            }
        }
    },

    watch: {
        'quantity_selling': function () {
            if (this.quantity_selling < this.item.quantity_selling) {
                this.quantity_selling = this.item.quantity_selling;
            }
            else if (this.quantity_selling >= this.item.quantity) {
                this.quantity_selling = this.item.quantity;
            }
            else if (this.quantity_selling == this.item.quantity_selling && this.price == this.item.price) {
                this.new_changes = false;
            }
            else {
                this.new_changes = true;
            }
        },

        'price': function() {
            if (this.price <= this.item.price_min) {
                this.price = this.item.price_min;
            }
            else if (this.price >= this.item.price_max) {
                this.price = this.item.price_max;
            }
            else if (this.quantity_selling == this.item.quantity_selling && this.price == this.item.price) {
                this.new_changes = false;
            }
            else {
                this.new_changes = true;
            }
        },

        'item.quantity_selling': function() {
            this.quantity_selling = this.item.quantity_selling;
        },
    },

    mounted() {
    },
};
</script>
