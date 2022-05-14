<template>
    <div
        v-if="listing.length > 0"
        class="relative flex flex-col items-center gap-12 bg-white rounded-2xl pt-4"
    >
        <h1
            class="font-heading font-bold text-4xl welcome-text mt-4 text-vN"
            style="text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25)"
        >
            Classement
        </h1>
        <!-- <button class="absolute top-10 left-10" @click="refresh">
            <img src="/assets/icons/refresh.svg" alt="refresh icon" />
        </button> -->

        <transition-group
            name="flip-list"
            tag="ul"
            class="flex items-center gap-12 w-4/5"
        >
            <Podium
                :name="listing[1].entreprise_name"
                :key="listing[1].entreprise_name"
                :caisse="listing[1].caisse"
                :ca="listing[1].ca"
                :dettes="listing[1].dettes"
                :score="listing[1].score"
                :position="2"
            />
            <Podium
                :name="listing[0].entreprise_name"
                :key="listing[0].entreprise_name"
                :caisse="listing[0].caisse"
                :ca="listing[0].ca"
                :dettes="listing[0].dettes"
                :score="listing[0].score"
                :position="1"
            />
            <Podium
                :name="listing[2].entreprise_name"
                :key="listing[2].entreprise_name"
                :caisse="listing[2].caisse"
                :ca="listing[2].ca"
                :dettes="listing[2].dettes"
                :score="listing[2].score"
                :position="3"
            />
        </transition-group>
        <!-- <button @click="shuffle">click</button> -->
        <div class="w-4/5 flex flex-col gap-10">
            <transition-group name="flip-list" tag="ul">
                <Listing
                    v-for="(item, i) in listing.slice(3, 13)"
                    :key="item.entreprise_name"
                    :name="item.entreprise_name"
                    :caisse="item.caisse"
                    :ca="item.ca"
                    :dettes="item.dettes"
                    :score="item.score"
                    :position="i + 4"
                />
            </transition-group>
        </div>
    </div>
    <!-- <div class="flex w-full">
        <div
            class="flex flex-col items-center justify-center py-auto w-1/2 h-screen rounded-md bg-green-600"
        >
            <p class="font-extrabold my-2 text-white text-3xl">
                <i class="fa fa-crown text-3xl mx-2 text-yellow-300"></i
                >Entreprise Plus Rentable
            </p>
            <vue-letter-avatar
                :name="listing[0].entreprise_name"
                size="40"
                :rounded="true"
            />
            <p class="font-extrabold my-2 text-white text-6xl">
                {{ listing[0].entreprise_name }}
            </p>
            <p class="font-extrabold my-1 text-white text-4xl">
                Profit : {{ listing[0].profit }} DA
            </p>
            <p
                v-if="show_score"
                class="font-extrabold my-1 text-white text-4xl"
            >
                Score Final {{ listing[0].score }} Pts
            </p>
        </div>
        <div
            class="flex flex-col mx-2 items-center justify-start w-1/2 h-screen"
        >
            <div
                class="w-full h-12 px-3 flex flex-nowrap items-center justify-between my-2 rounded-md mx-4"
            >
                <h2 class="font-bold">Entreprise</h2>
                <h2 class="text-lg font-extrabold">Profit</h2>
                <h2 v-if="show_score" class="text-lg font-extrabold">
                    Score Final
                </h2>
            </div>
            <div
                class="w-full h-20 px-3 flex flex-nowrap items-center justify-between bg-gray-200 my-2 rounded-md mx-4 hover:bg-green-500 hover:text-white"
                v-for="item in listing"
                :key="item.score"
            >
                <h2 class="font-bold">{{ item.entreprise_name }}</h2>
                <h2 class="text-lg font-extrabold">{{ item.profit }} DA</h2>
                <h2 v-if="show_score" class="text-lg font-extrabold">
                    {{ item.score }} Pts
                </h2>
            </div>
        </div>
    </div> -->
</template>

<script type="text/javascript">
import Listing from "./Listing";
import Podium from "./Podium";
export default {
    name: "LeaderBoard",
    components: {
        Listing,
        Podium,
    },
    props: ["showFs"],
    data() {
        return {
            listing: [],
            show_score: false,
        };
    },
    methods: {
        // shuffle: function () {
        //     this.listing = _.shuffle(this.listing.slice(0, 3));
        // },
        refresh() {
            this.getListing();
            this.$toasted.success("Classement mis à jour", {
                keepOnHover: true,
                icon: {
                    name: "✔",
                },
                position: "bottom-right",
                // className: "toast-success",
                duration: 3000,
            });
        },
        getListing() {
            axios.get("/api/ranking").then((resp) => {
                this.listing = resp.data.list;
                this.show_score = resp.data.meta;
            });
        },
    },
    beforeMount() {
        this.getListing();
    },
    mounted() {
        setInterval(() => {
            this.getListing();
        }, 30000);
        /*
			if(this.showFs == false){
				this.show_score = false
			}
			else{
				this.show_score = true
			}
			*/
    },
};
</script>

<style>
.flip-list-move {
    transition: transform 1s;
}

.toast-success {
    background-color: #def7ec !important;
    color: #3c6e4e !important;
}
</style>
