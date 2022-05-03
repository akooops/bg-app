<template>
    <div class="flex flex-col gap-8 text-vN">
        <div class="relative flex justify-between items-center">
            <div>
                <h2 class="text-2xl text-vN font-normal mb-4">
                    Hi {{ user.name }},
                </h2>
                <h1 class="text-3xl text-Vn font-bold">Welcome Back</h1>
            </div>
            <select
                v-model="selected_product"
                class="w-64 rounded-md border-[#0B343433] self-end bg-transparent"
            >
                <option
                    :value="product.id"
                    v-for="(product, key) in products"
                    :key="key"
                >
                    {{ product.name }}
                </option>
            </select>
        </div>
        <div class="w-full border-b border-[#807A7A33]"></div>
        <div class="w-full flex items-center gap-8">
            <div
                class="bg-white w-3/5 shadow-lg flex justify-between border-[#EEEEF2] border rounded-md p-8"
            >
                <div class="flex flex-col gap-4">
                    <h1 class="text-2xl font-bold">
                        {{ product_selected.name }}
                    </h1>
                    <h1 class="text-lg font-light">
                        {{ product_selected.description }}
                    </h1>
                </div>
                <img
                    src="/assets/cookies.png"
                    class="w-48"
                    :alt="product_selected.name"
                />
            </div>
            <div
                class="px-12 flex flex-col w-2/5 gap-3 shadow-lg text-vN font-normal bg-white border-[#EEEEF2] border rounded-md p-8"
            >
                <div class="flex justify-between gap-16">
                    <p class="text-lg">Stock</p>
                    <div class="flex items-center gap-4">
                        <p class="font-normal text-[#0B3434B2]">
                            {{
                                Math.round(
                                    product_selected.quantity
                                ).toLocaleString()
                            }}
                        </p>
                        <svg
                            width="106"
                            height="21"
                            viewBox="0 0 106 21"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                d="M0.538086 16.0765C7.56251 16.0765 10.7499 14.6534 14.0857 13.2878C17.2084 12.0095 20.5696 10.7301 28.241 10.7301V7.63351C20.0822 7.63351 16.3198 9.02728 12.9125 10.4221C9.71833 11.7297 6.96937 12.9799 0.538086 12.9799V16.0765ZM28.241 10.7301C32.032 10.7301 34.5239 11.3296 36.3433 12.1578C38.1657 12.9872 39.4223 14.0916 40.7362 15.3245C42.0264 16.5354 43.4463 17.9527 45.4346 19.0096C47.4656 20.0892 49.9998 20.7576 53.5694 20.7576V17.661C50.4111 17.661 48.3941 17.0759 46.8881 16.2754C45.3393 15.4521 44.2362 14.3626 42.8551 13.0665C41.4976 11.7926 39.9345 10.3901 37.6262 9.33941C35.3149 8.28742 32.3651 7.63351 28.241 7.63351V10.7301ZM53.5694 20.7576C60.6626 20.7576 65.0257 18.6835 68.8453 16.6936C72.6245 14.7246 75.662 12.9799 80.4808 12.9799V9.88335C74.7901 9.88335 71.0997 12.0274 67.4145 13.9474C63.7697 15.8462 59.9319 17.661 53.5694 17.661V20.7576ZM80.4808 12.9799C86.132 12.9799 89.49 10.3713 92.8002 8.12247C96.0674 5.90281 99.5422 3.80023 105.821 3.80023V0.703677C98.6438 0.703677 94.5488 3.19093 91.06 5.56111C87.6142 7.90209 85.0301 9.88335 80.4808 9.88335V12.9799Z"
                                fill="#576634"
                            />
                        </svg>
                    </div>
                </div>
                <div class="flex justify-between gap-16">
                    <p class="text-lg">Demande restante</p>
                    <div class="flex items-center gap-4">
                        <p class="font-normal text-[#0B3434B2]">
                            {{
                                Math.round(
                                    product_selected.left_demand
                                ).toLocaleString()
                            }}
                        </p>
                        <svg
                            width="106"
                            height="21"
                            viewBox="0 0 106 21"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                d="M0.538086 6.35186C3.573 6.35186 5.68243 7.13313 7.40626 8.27249C9.19427 9.45426 10.6038 11.0342 12.2702 12.8254C13.8948 14.5717 15.7258 16.4696 18.2176 17.9029C20.742 19.3549 23.86 20.2863 28.0373 20.2863V17.1898C24.3577 17.1898 21.7794 16.3794 19.7615 15.2187C17.7111 14.0393 16.1537 12.4536 14.5374 10.7162C12.9629 9.02384 11.2787 7.12014 9.11367 5.6892C6.88449 4.21584 4.18155 3.25531 0.538086 3.25531V6.35186ZM28.0373 20.2863C32.1492 20.2863 35.096 19.5759 37.4043 18.4319C39.7032 17.2926 41.2553 15.7748 42.5988 14.402C43.9716 12.9993 45.0675 11.8214 46.6014 10.9336C48.0848 10.0751 50.0671 9.44841 53.1795 9.44841V6.35186C49.6135 6.35186 47.0781 7.07993 45.0503 8.25354C43.0732 9.39782 41.6646 10.9294 40.3858 12.2362C39.0776 13.5729 37.8307 14.7646 36.0292 15.6574C34.2372 16.5455 31.7823 17.1898 28.0373 17.1898V20.2863ZM53.1795 9.44841C60.1514 9.44841 64.4398 7.81606 68.2299 6.23213C71.9635 4.6718 75.0303 3.25531 79.893 3.25531V0.158755C74.3235 0.158755 70.7118 1.83881 67.0359 3.37504C63.4165 4.88765 59.5643 6.35186 53.1795 6.35186V9.44841ZM79.893 3.25531C82.0047 3.25531 83.7403 4.00834 85.4161 5.24945C87.1459 6.53054 88.7026 8.24074 90.5308 10.1362C94.1059 13.8428 98.4535 17.9639 105.821 17.9639V14.8674C99.8314 14.8674 96.2779 11.6342 92.7596 7.98649C91.0411 6.20479 89.2531 4.23783 87.2591 2.76105C85.2111 1.2443 82.8441 0.158755 79.893 0.158755V3.25531Z"
                                fill="#0B3434"
                            />
                        </svg>
                    </div>
                </div>
                <div class="flex justify-between gap-16">
                    <p class="text-lg">Prix Min.</p>
                    <div class="flex items-center gap-4">
                        <p class="font-normal text-[#0B3434B2]">
                            {{ product_selected.price_min }}
                        </p>
                        <svg
                            width="106"
                            height="21"
                            viewBox="0 0 106 21"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                d="M0.538086 16.0765C7.56251 16.0765 10.7499 14.6534 14.0857 13.2878C17.2084 12.0095 20.5696 10.7301 28.241 10.7301V7.63351C20.0822 7.63351 16.3198 9.02728 12.9125 10.4221C9.71833 11.7297 6.96937 12.9799 0.538086 12.9799V16.0765ZM28.241 10.7301C32.032 10.7301 34.5239 11.3296 36.3433 12.1578C38.1657 12.9872 39.4223 14.0916 40.7362 15.3245C42.0264 16.5354 43.4463 17.9527 45.4346 19.0096C47.4656 20.0892 49.9998 20.7576 53.5694 20.7576V17.661C50.4111 17.661 48.3941 17.0759 46.8881 16.2754C45.3393 15.4521 44.2362 14.3626 42.8551 13.0665C41.4976 11.7926 39.9345 10.3901 37.6262 9.33941C35.3149 8.28742 32.3651 7.63351 28.241 7.63351V10.7301ZM53.5694 20.7576C60.6626 20.7576 65.0257 18.6835 68.8453 16.6936C72.6245 14.7246 75.662 12.9799 80.4808 12.9799V9.88335C74.7901 9.88335 71.0997 12.0274 67.4145 13.9474C63.7697 15.8462 59.9319 17.661 53.5694 17.661V20.7576ZM80.4808 12.9799C86.132 12.9799 89.49 10.3713 92.8002 8.12247C96.0674 5.90281 99.5422 3.80023 105.821 3.80023V0.703677C98.6438 0.703677 94.5488 3.19093 91.06 5.56111C87.6142 7.90209 85.0301 9.88335 80.4808 9.88335V12.9799Z"
                                fill="#B2D06B"
                            />
                        </svg>
                    </div>
                </div>
                <div class="flex justify-between gap-16">
                    <p class="text-lg">Prix Max.</p>
                    <div class="flex items-center gap-4">
                        <p class="font-normal text-[#0B3434B2]">
                            {{ product_selected.price_max }}
                        </p>
                        <svg
                            width="105"
                            height="17"
                            viewBox="0 0 105 17"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                d="M0.538086 3.893C3.65746 3.893 5.73791 4.49886 7.35607 5.34848C9.02041 6.22236 10.2697 7.38282 11.7873 8.72857C13.2774 10.05 14.9699 11.4908 17.3558 12.5727C19.752 13.6593 22.7514 14.3439 26.8588 14.3439V11.2473C23.1092 11.2473 20.5596 10.6255 18.6346 9.75257C16.6991 8.8749 15.298 7.70304 13.8418 6.41174C12.413 5.14478 10.8633 3.69253 8.79557 2.60687C6.68169 1.49695 4.0971 0.796451 0.538086 0.796451V3.893ZM26.8588 14.3439C30.8824 14.3439 33.7884 13.9723 36.1006 13.3898C38.4218 12.805 40.0853 12.0214 41.5872 11.2815C43.0895 10.5414 44.3633 9.88245 46.0753 9.38308C47.7739 8.88759 49.9565 8.53783 53.1795 8.53783V5.44128C49.724 5.44128 47.2416 5.81727 45.2082 6.41042C43.1881 6.99967 41.6629 7.79224 40.2188 8.50369C38.7744 9.21525 37.3442 9.88316 35.3441 10.387C33.335 10.8932 30.6921 11.2473 26.8588 11.2473V14.3439ZM53.1795 8.53783C56.3666 8.53783 58.6572 8.98706 60.457 9.62756C62.2614 10.2697 63.6413 11.127 65.0298 12.052C67.8655 13.9411 70.6785 16.0857 76.4036 16.0857V12.9891C71.6965 12.9891 69.5757 11.3597 66.7466 9.47496C65.3027 8.51299 63.6674 7.48329 61.4952 6.71025C59.3183 5.93553 56.6707 5.44128 53.1795 5.44128V8.53783ZM76.4036 16.0857C82.0943 16.0857 86.1705 12.6166 90.06 9.67612C94.0526 6.65778 98.1357 3.893 104.273 3.893V0.796451C97.0527 0.796451 92.2641 4.12801 88.1926 7.20601C84.0183 10.3618 80.8383 12.9891 76.4036 12.9891V16.0857Z"
                                fill="#FFBC3E"
                            />
                        </svg>
                    </div>
                </div>
            </div>
        </div>
        <div
            ref="product"
            class="grid grid-cols-2 gap-8 grid-rows-2 items-center w-full"
        >
            <div
                class="h-[500px] py-4 flex flex-col gap-4 items-center w-full bg-white border border-[#EEEEF2] shadow-lg rounded-xl"
            >
                <h2 class="self-start text-xl font-bold ml-8 text-vN">
                    Part du Marché par Produit
                </h2>
                <BarChart
                    v-if="market_share_entrep != null"
                    unit="%"
                    :x-data="market_share_entrep.names"
                    :y-data="market_share_entrep.values.map((e) => e * 100)"
                    :width="50"
                ></BarChart>
            </div>
            <div
                class="h-[500px] py-4 flex gap-4 flex-col pl-8 items-center w-full bg-white border border-[#EEEEF2] shadow-lg rounded-xl"
            >
                <h2 class="self-start text-xl font-bold text-vN">
                    Part du Marché Pour le produit
                </h2>
                <PieChart
                    v-if="market_share_prod != null"
                    :legend="entreprise_names"
                    :serie="market_share_prod"
                ></PieChart>
            </div>
            <div
                class="h-[500px] py-4 pl-8 flex flex-col gap-4 items-center w-full bg-white border border-[#EEEEF2] shadow-lg rounded-xl"
            >
                <h2 class="self-start text-xl font-bold text-vN">Coûts</h2>
                <BarChart
                    v-if="indicators['costs'] != null"
                    unit="UM"
                    :x-data="indicators['costs'].map((i) => i.name)"
                    :y-data="indicators['costs'].map((i) => i.value)"
                    :width="50"
                ></BarChart>
            </div>
            <div
                class="h-[500px] py-4 flex flex-col pl-8 gap-4 items-center w-full bg-white border border-[#EEEEF2] shadow-lg rounded-xl"
            >
                <h2 class="self-start text-xl font-bold text-vN">
                    Chiffres d'Affaire
                </h2>
                <CircleChart
                    v-if="indicators['ca'] != null"
                    :legend="product_names"
                    :serie="indicators['ca'].slice(0, 5)"
                    :simple='true'
                    class='vv1'
                    orient='vertical'
                    left ="2%"
                    bottom= 'center'
                ></CircleChart>
            </div>
        </div>

  
    </div>
</template>

<script>
import LineGraph from "./ui/LineGraph";
import BarChart from "./ui/BarChart";
import PieChart from "./ui/PieChart";
import SpeedoMeter from "./ui/SpeedoMeter";
import StatCard from "./ui/StatCard";
import CircleChart from "./ui/CircleChart";
export default {
    name: "Finance",
    props: ["user", "products", "entreprises"],
    data() {
        return {
            indicators: [],
            products_stock: [],
            selected_product: 5,
            product_selected: {
                name: "Galletes",
                description:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                left_demand: 0,
                quantity: 0,
                price_min: 0,
                price_min: 0,
            },
            market_share_prod: null,
            market_share_entrep: null,
            entreprise_names: [],
            product_names: [],
        };
    },
    components: {
        StatCard,
        LineGraph,
        BarChart,
        PieChart,
        SpeedoMeter,
        CircleChart,
    },
    watch: {
        selected_product: function (n, o) {
            this.market_share_prod = null;
            this.product_selected.name = this.products.filter(
                (p) => p.id == n
            )[0].name;
            this.product_selected.description = this.products.filter(
                (p) => p.id == n
            )[0].description;
            this.product_selected.quantity = this.products_stock.filter(
                (p) => p.id == n
            )[0].quantity;
            this.product_selected.left_demand = this.products.filter(
                (p) => p.id == n
            )[0].left_demand;
            this.product_selected.price_max = this.products.filter(
                (p) => p.id == n
            )[0].price_max;
            this.product_selected.price_min = this.products.filter(
                (p) => p.id == n
            )[0].price_min;
            this.$refs["product"].scrollIntoView();
            this.getMarketShareProd();
        },
    },
    computed: {},
    methods: {
        getProductsStock() {
            axios
                .get("/api/entreprise/products-stock", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((response) => {
                    this.products_stock = response.data;
                    this.product_selected.quantity =
                        this.products_stock[0].quantity;
                })
                .catch(function (error) {});
        },
        getMarketShareProd() {
            axios
                .get("/api/indicator/market-share-prod", {
                    params: {
                        product_id: this.selected_product,
                    },
                })
                .then((resp) => {
                    this.market_share_prod = resp.data;
                });
        },
        getMarketShares() {
            axios
                .get("/api/indicator/market-share", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.market_share_entrep = resp.data;
                });
        },
        getFinIndicators() {
            axios
                .get("/api/indicator/finance", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.indicators = resp.data;
                });
        },
    },
    mounted() {
        this.entreprise_names = this.entreprises.map((e) => e.name);
        this.product_names = this.products.map((p) => p.name);
        this.product_selected.left_demand = this.products[0].left_demand;
        this.product_selected.price_min = this.products[0].price_min;
        this.product_selected.price_max = this.products[0].price_max;
        this.getProductsStock();
        this.getMarketShares();
        this.getMarketShareProd();
        this.getFinIndicators();
    },
};
</script>