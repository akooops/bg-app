<template>
    <div class="w-full">
        <div
            v-if="show_success"
            class="my-2 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative"
            role="alert"
        >
            <strong class="font-bold">{{ message }}</strong>

            <span
                @click="show_success = false"
                class="absolute top-0 bottom-0 right-0 px-4 py-3"
            >
                <svg
                    class="fill-current h-6 w-6 text-green-500"
                    role="button"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                >
                    <title>Close</title>
                    <path
                        d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10    11.819l-2.651 3.029a1.2 1.2 0 1   1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1     1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697    1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"
                    />
                </svg>
            </span>
        </div>

        <div
            v-if="show_error"
            class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative"
            role="alert"
        >
            <strong class="font-bold">{{ message }}</strong>

            <span
                @click="show_error = false"
                class="absolute top-0 bottom-0 right-0 px-4 py-3"
            >
                <svg
                    class="fill-current h-6 w-6 text-red-500"
                    role="button"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                >
                    <title>Close</title>
                    <path
                        d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10    11.819l-2.651 3.029a1.2 1.2 0 1   1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1     1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697    1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"
                    />
                </svg>
            </span>
        </div>

        <div class="flex gap-6 mt-10">
            <div
                class="flex-grow bg-white rounded-xl gap-6 text-center flex flex-col py-7 shadow-lg px-2"
            >
                <img class="mx-auto h-16 w-16" src="/images/prod.png" alt="" />
                <div class="mx-auto text-center text-vN flex-1">
                    <h1 class="text-2xl font-medium mb-4">
                        Lancer une production
                    </h1>
                    <p class="text-sm text-nav text-opacity-80">
                        En lançant une production, vous produirez une quantité
                        d'un produit que vous pourrez par la suite vendre.<br />

                        <span class="text-jaune font-medium"> Astuce :</span>
                        Planifiez bien votre production en amont pour eviter les
                        coûts de stock !
                    </p>
                </div>

                <button
                    @click="launch_prod_modal = true;"
                    class="rounded-xl bg-vert text-white mx-auto py-2 px-11 mb-8 text-lg font-medium"
                >
                    Lancer
                </button>
            </div>

            <div
                class="flex-grow  rounded-xl gap-6 text-center flex flex-col py-7 shadow-xl px-2" style="border-width : 0.5px;"
            >
                <img
                    class="mx-auto h-16 w-16"
                    src="/images/machine.png"
                    alt=""
                />
                <div class="mx-auto text-center text-vN flex-1">
                    <h1 class="text-2xl font-medium mb-4">Machine</h1>
                    <p class="text-sm text-nav text-opacity-80">
                        En achetant de nouvelles machines ou en réparant des
                        anciennes machines vous pourrez produire plus de
                        quantité.
                        <br />
                    </p>
                    <p class="text-sm text-nav text-opacity-80 mt-2">
                        <span class="text-jaune font-medium"> Astuce :</span>
                        Attention à ne pas sur-estimer vos besoins en machines
                    </p>
                </div>
                <div class="flex flex-col gap-3 mt-3">
                    <button
                        @click="
                            machine.transaction = 'buy';
                            machine.show_transaction_modal = true;
                        "
                        class="rounded-xl bg-vert text-white mx-auto py-2 px-11 text-lg font-medium"
                    >
                        Acheter
                    </button>
                    <button
                        @click="
                            machine.transaction = 'sell';
                            machine.show_transaction_modal = true;
                        "
                        class="rounded-xl bg-vert text-white mx-auto py-2 px-11 text-lg font-medium"
                    >
                        Vendre
                    </button>
                </div>
            </div>

            <div
                class="flex-grow bg-white rounded-xl gap-6 text-center flex flex-col py-7 shadow-lg px-2"
            >
                <img
                    class="mx-auto h-16 w-16"
                    src="/images/atelier.png"
                    alt=""
                />
                <div class="mx-auto text-center text-vN flex-1">
                    <h1 class="text-2xl font-medium mb-4">Atelier</h1>
                    <p class="text-sm text-nav text-opacity-80">
                        Dans cette section vous pouvez lancer des actions pour
                        améliorer l'état de vos usines et votre productivité.
                    </p>
                </div>

                <select
                    v-model="action.value"
                    aria-placeholder="Choisissez une action"
                    class="rounded-md focus:border-vert focus:ring-0 w-5/6 mx-auto border-vert"
                    style="border-width: 1px"
                >
                    <option value="5s">Appliquer les 5S</option>
                    <option value="audit">Effectuer un audit qualité</option>
                    <option value="maintenance_lv1">Réparer les machines de niveau 1</option>
                    <option value="maintenance_lv2">Réparer les machines de niveau 2</option>
                    <option value="maintenance_lv3">Réparer les machines de niveau 3</option>
                </select>
                <button
                    @click="showActionInfo"
                    class="rounded-xl bg-vert text-white mx-auto py-2 px-11 mb-8 text-lg font-medium"
                >
                    Lancer
                </button>
            </div>
        </div>
        <Modal v-if="launch_prod_modal">
            <template v-slot:content>
                <div class="flex flex-col w-2/5 px-6 mx-auto">
                    <h1 class="text-vert font-semibold text-2xl">
                        Lancer une production
                    </h1>
                    <h1 class="text-vN text-lg mt-4">Produit :</h1>
                    <select v-model="launch_data.prod_id">
                        <option
                            :value="product.id"
                            v-for="(product, key) in products"
                            :key="key"
                        >
                            {{ product.name }}
                        </option>
                    </select>
                    <h1 class="text-vN text-lg mt-2">Choix de la machine :</h1>
                    <div class="flex flex-col m-3 gap-4 mx-auto">
                        <div class="flex gap-3 items-center">
                            <input
                                v-model="launch_data.machine_lvl"
                                type="radio"
                                id="machine1"
                                name="machine1"
                                class="text-vert"
                                :value="1"
                            /><label for="machine1">Niveau 1</label>
                        </div>
                        <div class="flex gap-3 items-center">
                            <input
                                v-model="launch_data.machine_lvl"
                                type="radio"
                                id="machine2"
                                name="machine2"
                                class="text-vert"
                                :value="2"
                            /><label for="machine2">Niveau 2</label>
                        </div>
                        <div class="flex gap-3 items-center">
                            <input
                                v-model="launch_data.machine_lvl"
                                type="radio"
                                id="machine3"
                                name="machine3"
                                class="text-vert"
                                :value="3"
                            /><label for="machine3">Niveau 3</label>
                        </div>
                    </div>
                    <h1 class="text-vN text-lg mt-2">Nombre de machines:</h1>
                    <input
                        class="mx-4 w-2/3"
                        v-model="launch_data.machine_nb"
                        type="number"
                        min="1"
                        :max="
                            launch_data.machine_lvl == 1 ?
                            indicators['nb_machines_lv1'].value - indicators['nb_machines_lv1_busy'].value :
                            launch_data.machine_lvl == 2 ?
                            indicators['nb_machines_lv2'].value - indicators['nb_machines_lv2_busy'].value :
                            indicators['nb_machines_lv3'].value - indicators['nb_machines_lv3_busy'].value
                        "
                    />
                    <h1 class="text-vN text-lg">
                        Quantité( en lot de 100 pièces)
                    </h1>
                    <input
                        type="number "
                        v-model="launch_data.quantity"
                        class="px-2 text-lg text-yellow-500 border rounded-md border-gray-200"
                        min="1"
                    />
                    <h1 class="text-vN text-lg mt-3 pt-3">Prix (Unitaire)</h1>
                    <input
                        type="number "
                        v-model="launch_data.price"
                        class="px-2 text-lg text-yellow-500 border rounded-md border-gray-200"
                        :min="selectedProd.price_min"
                        :max="selectedProd.price_max"
                    />
                    <p class="text-red-500" v-if="can_produce == false">
                        {{ can_produce_msg }}
                    </p>
                    <div class="flex flex-row justify-center gap-7 mt-12">
                        <button
                            v-if="stock_updated == true && machine_info_updated == true"
                            :diabled="can_produce == false"
                            @click="launchProduction()"
                            class="bg-vN text-white px-7 py-1 rounded-md"
                        >
                            Lancer
                        </button>
                        <button
                            class="bg-vN text-white px-7 py-1 rounded-md"
                            @click="
                                launch_prod_modal = false;
                                launch_data.price = (selectedProd.price_min + selectedProd.price_max) / 2;
                                launch_data.quantity = 1;
                                launch_data.machine_lvl = 1;
                                launch_data.machine_nb = 1;
                            "
                        >
                            Annuler
                        </button>
                    </div>
                </div>

                <div class="flex flex-col w-3/5 px-6">
                    <h1 class="text-vN pl-3 font-semibold text-lg">
                        Informations importantes
                    </h1>
                    <h1 class="text-vN text-lg pl-3">Nécessite :</h1>
                    <div class="p-3">
                        <table class="w-full" style="background-color: #f9f9fc">
                            <thead class="text-xs text-gray-700 uppercase">
                                <tr class="border-b border-t text-vN">
                                    <th class="px-3 py-1">Matière Premiere</th>
                                    <th class="px-3 py-1">
                                        Quantité Nécessaire
                                    </th>
                                    <th class="px-3 py-1">Quantité Stockés</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="(
                                        material, key
                                    ) in selectedProd.raw_materials"
                                    :key="key"
                                    class="text-vN border-b"
                                >
                                    <td
                                        class="flex justify-center icon-material py-1"
                                    >
                                        <img
                                            src="/assets/icons/khobz.png"
                                            alt="khobz"
                                        />
                                        <span>{{ material.name }}</span>
                                    </td>
                                    <td class="text-center py-1">
                                        {{ material.pivot.quantity }}
                                    </td>
                                    <td
                                        v-if="stock != null"
                                        class="text-center py-1"
                                        :class="
                                            material.pivot.quantity * launch_data.quantity <= stock.find((item) => { return ( item.id == material.pivot.raw_material_id); }).quantity
                                            ? 'text-blue-700' : 'text-red-700'
                                        "

                                    >
                                        <span v-if=" stock.find( (element) => element.id == material.id ) != undefined ">
                                            {{ stock.find((element) => element.id == material.id).quantity }}
                                        </span>
                                        <span v-else>0</span>
                                    </td>
                                    <td
                                        v-else
                                        class="text-center text-black py-1"

                                    >
                                    0
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <h1 class="text-vN text-lg pl-3">Machines :</h1>

                    <div class="p-3">
                        <table class="w-full" style="background-color: #f9f9fc">
                            <thead class="text-xs text-gray-700 uppercase">
                                <tr class="border-b border-t">
                                    <th class="px-4 py-1 text-vN">
                                        Temps Total estimé
                                    </th>
                                    <th class="px-4 py-1 text-vN">
                                        Temps unitaire
                                    </th>
                                    <th class="px-4 py-1 text-vN">
                                        Nombre d'employés
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b">
                                    <td class="flex justify-center icon-material text-yellow-500 py-1">
                                        {{ Math.round(prodDelay * Math.pow(10, 2)) / Math.pow(10, 2) }} J
                                    </td>
                                    <td class="text-center text-yellow-500 py-1">
                                        FILL THIS (lot/min)
                                    </td>
                                    <td class="text-center text-yellow-500 py-1">
                                        Simples:
                                        <span class="font-bold" :class="indicators['nb_workers_lv1'].value - indicators['nb_workers_lv1_busy'].value >= prod_factors.labor_lv1 ? 'text-blue-700' : 'text-red-700'">
                                            {{ prod_factors.labor_lv1 }} / {{ indicators["nb_workers_lv1"].value - indicators["nb_workers_lv1_busy"].value }}
                                        </span>
                                        <br />
                                        Experts:
                                        <span class="font-bold" :class="indicators['nb_workers_lv2'].value - indicators['nb_workers_lv2_busy'].value >= prod_factors.labor_lv2 ? 'text-blue-700' : 'text-red-700'">
                                            {{ prod_factors.labor_lv2 }} / {{ indicators["nb_workers_lv2"].value - indicators["nb_workers_lv2_busy"].value }}
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <h1 class="text-vN text-lg pl-3">Prévisions :</h1>
                    <div class="p-3">
                        <table class="w-full" style="background-color: #f9f9fc">
                            <thead class="text-xs text-gray-700 uppercase">
                                <tr class="border-b border-t">
                                    <th class="px-4 py-1 text-vN">
                                        Chiffre d’Affaire Estimés
                                    </th>
                                    <th class="px-4 py-1 text-vN">
                                        Coût Total Estimé
                                    </th>
                                    <th class="px-4 py-1 text-vN">
                                        Profit Estimé
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b">
                                    <td class="flex justify-center icon-material text-yellow-500 py-1">
                                        {{ salesRevenues }} UM
                                    </td>
                                    <td class="text-center text-yellow-500 py-1">
                                        {{ totalCost }} UM
                                    </td>
                                    <td class="text-center text-yellow-500 py-1">
                                        {{ profit }} UM
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <h1 class="text-yellow-500 my-2 pl-3">Remarques :</h1>
                    <p class="text-vN text-sm pl-3">
                        - Les prévisions sont calculés dans le cas ou toutes la
                        quantité produite est vendue
                    </p>
                    <p class="text-vN text-sm pl-3">
                        - Votre taux de rebut est de
                        {{ Math.round(indicators["reject_rate"].value * Math.pow(10, 2)) }}%,
                        pour le réduire, lancez une étude AMDEC.
                    </p>
                </div>
            </template>
        </Modal>

        <Modal v-if="machine.show_transaction_modal">
            <template v-slot:content>
                <div class="flex flex-col items-center gap-5 p-5">
                    <h2 v-if="machine.transaction == 'buy'" class="font-bold text-lg">
                        Acheter une Machine
                    </h2>
                    <h2 v-if="machine.transaction == 'sell'" class="font-semibold text-lg">
                        Vendre une Machine
                    </h2>
                    <div class="w-full gap-4 flex-col flex">
                        <div class="flex flex-col items-start gap-2">
                            <p class="text-md font-medium text-nav">
                                Choix du niveau de la machine
                            </p>
                            <select
                                class="rounded-sm focus:border-vert focus:ring-0 w-full border-gray-200"
                                style="border-width: 1px"
                                v-model="machine.transaction_lv"
                            >
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </div>
                        <div class="flex flex-col items-start gap-2">
                            <p class="text-md font-medium text-nav">
                                Nombre que vous souhaitez
                                {{ machine.transaction == "buy" ? "acheter" : "vendre" }}
                            </p>
                            <input
                                v-model="machine.transaction_nb"
                                min="1"
                                :max="
                                    machine.transaction == 'sell' ?
                                        (machine.transaction_lv == 1 ?
                                            indicators['nb_machines_lv1'].value - indicators['nb_machines_lv1_busy'].value :
                                        machine.transaction_lv == 2 ?
                                            indicators['nb_machines_lv2'].value - indicators['nb_machines_lv2_busy'].value :
                                            indicators['nb_machines_lv3'].value - indicators['nb_machines_lv3_busy'].value) :
                                        undefined
                                "
                                type="number"
                                class="rounded-sm focus:border-vert w-full focus:ring-0 border-gray-200"
                                style="border-width: 1px"
                            />
                        </div>
                        <div class="flex flex-col">
                            <p class="text-me font-medium text-nav">Prix</p>
                            <p
                                v-if="machine.transaction == 'buy'"
                                class="py-2 px-4 border-gray-200 w-40 text-jaune"
                                style="border-width: 1px"
                            >
                                {{
                                    (
                                        machine.transaction_lv == 1 ?
                                        machine.buy_price_lv1 :
                                        machine.transaction_lv == 2 ?
                                        machine.buy_price_lv2 :
                                        machine.buy_price_lv3
                                    )

                                    * machine.transaction_nb
                                }}
                            </p>
                            <p
                                v-else
                                class="py-2 px-4 border-gray-200 w-40 text-jaune"
                                style="border-width: 1px"
                            >
                                {{
                                    (
                                        machine.transaction_lv == 1 ?
                                        machine.buy_price_lv1 :
                                        machine.transaction_lv == 2 ?
                                        machine.buy_price_lv2 :
                                        machine.buy_price_lv3
                                    )

                                    * machine.transaction_nb *
                                    indicators[
                                        machine.transaction_lv == 1 ?
                                        "machines_lv1_health" :
                                        machine.transaction_lv == 2 ?
                                        "machines_lv2_health" :
                                        "machines_lv3_health"
                                    ].value
                                }}
                            </p>
                        </div>
                    </div>
                    <div
                        class="w-full flex items-center gap-4 justify-center mt-5"
                    >
                        <button
                            v-if="machine_info_updated == true || machine.transaction == 'buy'"
                            @click="confirmMachineTransaction"
                            class="border-0 px-3 py-1 text-vN hover:text-vert"
                        >
                            Confirmer
                        </button>
                        <button
                            @click="
                                machine.transaction_nb =
                                machine.transaction == 'buy' ? 1 : machine.transaction_nb;
                                machine.transaction_lv = 1;
                                machine.show_transaction_modal = false;"
                            class="px-3 py-1 text-vN opacity-80"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>
        <Modal v-if="action.show_info" class="pt-44">
            <template v-slot:content>
                <div class="flex flex-col gap-5">
                    <h1 class="text-lg text-jaune uppercase">
                        {{ action.value }}
                    </h1>
                    <p class="">
                        {{ action.phrase }}
                    </p>
                    <p class="">
                        {{ action.result_phrase }}
                    </p>
                    <div class="w-full flex items-center gap-4 justify-center">
                        <button
                            @click="confirmAction"
                            class="bg-vert rounded-md px-3 border-2 border-vert py-1 text-white"
                        >
                            Confirmer
                        </button>
                        <button
                            @click="action.show_info = false"
                            class="bg-white border-vert border-2 rounded-md px-3 py-1 text-vert"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>
    </div>
</template>

<script type="text/javascript">
import Modal from "../Modal";
export default {
    name: "ProdCenter",
    components: { Modal },
    props: ["products", "indicators", "user", "caisse"],
    data() {
        return {
            quantity: 1,
            launch_prod_modal: false,
            launch_data: {
                prod_id: 1,
                price: 0,
                quantity: 1,
                machine_lvl: 1,
                machine_nb: 1,
            },
            prod_factors: {
                machines: 0,
                labor_lv1: 0,
                labor_lv2: 0,
            },
            machine: {
                show_transaction_modal: false,
                transaction: "",

                buy_price_lv1: 0,
                buy_price_lv2: 0,
                buy_price_lv3: 0,

                sell_price_lv1: 0,
                sell_price_lv2: 0,
                sell_price_lv3: 0,

                durability_lv1: 1,
                durability_lv2: 1,
                durability_lv3: 1,

                speed_lv1: 1,
                speed_lv2: 1,
                speed_lv3: 1,

                pollution_lv1: 1,
                pollution_lv2: 1,
                pollution_lv3: 1,

                transaction_nb: 1,
                transaction_lv: 1,
            },
            can_produce_msg: "",
            can_produce: false,
            stock: null,

            show_success: false,
            show_error: false,
            message: "",
            action: {
                value: "5s",
                price: {
                    "5s": 40000,
                    audit: 60000,
                    maintenance_lv1:
                        10000 *
                        (1 - this.indicators["machines_lv1_health"]["value"]) *
                        this.indicators["nb_machines_lv1"]["value"],
                    maintenance_lv2:
                        15000 *
                        (1 - this.indicators["machines_lv2_health"]["value"]) *
                        this.indicators["nb_machines_lv2"]["value"],
                    maintenance_lv3:
                        20000 *
                        (1 - this.indicators["machines_lv3_health"]["value"]) *
                        this.indicators["nb_machines_lv3"]["value"],
                },
                phrase: "",
                result_phrase: "",
                show_info: false,
            },

            stock_updated: false,
            machine_info_updated: false,
        };
    },
    watch: {
        "launch_data.prod_id": function () {
            this.launch_data.price =
                (this.selectedProd.price_min + this.selectedProd.price_max) / 2;
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.quantity": function () {
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.price": function () {
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.machine_lvl": function () {
            this.can_produce = false;

            // let free_workers_lv1 =
            //     this.indicators["nb_workers_lv1"].value -
            //     this.indicators["nb_workers_lv1_busy"].value;
            // let free_workers_lv2 =
            //     this.indicators["nb_workers_lv2"].value -
            //     this.indicators["nb_workers_lv2_busy"].value;

            // if (
            //     this.prod_factors.labor_lv1 > free_workers_lv1 &&
            //     free_workers_lv2 > 0
            // ) {
            //     this.prod_factors.labor_lv2 =
            //         parseInt(this.prod_factors.labor_lv2) +
            //         parseInt(this.prod_factors.labor_lv1) -
            //         free_workers_lv1;
            //     this.prod_factors.labor_lv1 = free_workers_lv1;
            // }

            // let free_machines =
            //     this.launch_data.machine_lvl == 1
            //         ? this.indicators["nb_machiness_lv1"].value -
            //           this.indicators["nb_machiness_lv1_busy"].value
            //         : this.launch_data.machine_lvl == 2
            //         ? this.indicators["nb_machiness_lv2"].value -
            //           this.indicators["nb_machiness_lv2_busy"].value
            //         : this.indicators["nb_machiness_lv3"].value -
            //           this.indicators["nb_machiness_lv3_busy"].value;

            // if (this.launch_data.machine_nb > free_machines) {
            //     this.launch_data.machine_nb = free_machines;
            // }

            this.verifyProd();
        },
        "launch_data.machine_nb": function () {
            this.can_produce = false;
            this.verifyProd();
        },
        "machine.transaction_lv": function () {
            if (this.machine.transaction_lv == 1) {
                if (
                    this.indicators["nb_machines_lv1"]["value"] -
                        this.indicators["nb_machines_lv1_busy"]["value"] ==
                    0
                ) {
                    this.machine.transaction_nb = 0;
                } else if (
                    this.indicators["nb_machines_lv1"]["value"] -
                        this.indicators["nb_machines_lv1_busy"]["value"] <
                    this.machine.transaction_nb
                ) {
                    this.machine.transaction_nb =
                        this.indicators["nb_machines_lv1"]["value"] -
                        this.indicators["nb_machines_lv1_busy"]["value"];
                } else if (this.machine.transaction_nb == 0) {
                    this.machine.transaction_nb = 1;
                }
            } else if (this.machine.transaction_lv == 2) {
                if (
                    this.indicators["nb_machines_lv2"]["value"] -
                        this.indicators["nb_machines_lv2_busy"]["value"] ==
                    0
                ) {
                    this.machine.transaction_nb = 0;
                } else if (
                    this.indicators["nb_machines_lv2"]["value"] -
                        this.indicators["nb_machines_lv2_busy"]["value"] <
                    this.machine.transaction_nb
                ) {
                    this.machine.transaction_nb =
                        this.indicators["nb_machines_lv2"]["value"] -
                        this.indicators["nb_machines_lv2_busy"]["value"];
                } else if (this.machine.transaction_nb == 0) {
                    this.machine.transaction_nb = 1;
                }
            } else if (this.machine.transaction_lv == 3) {
                if (
                    this.indicators["nb_machines_lv3"]["value"] -
                        this.indicators["nb_machines_lv3_busy"]["value"] ==
                    0
                ) {
                    this.machine.transaction_nb = 0;
                } else if (
                    this.indicators["nb_machines_lv3"]["value"] -
                        this.indicators["nb_machines_lv3_busy"]["value"] <
                    this.machine.transaction_nb
                ) {
                    this.machine.transaction_nb =
                        this.indicators["nb_machines_lv3"]["value"] -
                        this.indicators["nb_machines_lv3_busy"]["value"];
                } else if (this.machine.transaction_nb == 0) {
                    this.machine.transaction_nb = 1;
                }
            }
        },
    },
    computed: {
        selectedProd() {
            return this.products.find(
                (item) => item.id == this.launch_data.prod_id
            );
        },
        salesRevenues() {
            let coeff = 1 - this.indicators["reject_rate"].value;
            return (
                this.launch_data.price * this.launch_data.quantity * 100 * coeff
            );
        },
        totalCost() {
            return (
                this.launch_data.quantity *
                this.selectedProd.unit_prod_price *
                100
            );
        },
        profit() {
            return this.salesRevenues - this.totalCost;
        },
        prodDelay() {
            let coeff =
                (this.indicators["5s_day"].value < 30 ? 1.5 : 1) *
                (this.launch_data.machine_lvl == 1
                    ? this.machine.speed_lv1
                    : this.launch_data.machine_lvl == 2
                    ? this.machine.speed_lv2
                    : this.machine.speed_lv3) *
                this.launch_data.machine_nb;

            return (
                (this.selectedProd.prod_speed_factor *
                    this.launch_data.quantity) / (coeff)
            );
        },
    },
    methods: {
        launchProduction() {
            let data = {
                product_id: this.selectedProd.id, // slected product id
                entreprise_id: this.user.id, // this users's id
                quantity: this.launch_data.quantity, // number of lots (100 units) to be produced
                price: this.launch_data.price, // price of selling
                cost: this.totalCost, // cost of production
                delay: this.prodDelay * 60, // time it takes to produce
                machines: this.prod_factors.machines, // number of necessary free machines to produce
                labor_lv1: this.prod_factors.labor_lv1, // number of necessary simple free workers to produce
                labor_lv2: this.prod_factors.labor_lv2, // number of necessary simple free workers to produce
                machines_lvl: this.launch_data.machine_lvl, // selected machine level
            };

            if (this.caisse < data.cost) {
                this.launch_prod_modal = false;
                this.show_error = true;
                this.message =
                    "Vos disponibilités ne suffisent pas pour lancer la production";
                return "";
            }
            axios
                .post("/api/production/launch", data)
                .then((resp) => {
                    if (resp.data.success) {
                        this.show_success = true;
                        this.show_error = false;
                    } else {
                        this.show_success = false;
                        this.show_error = true;
                    }
                    this.message = resp.data.message;
                    this.launch_prod_modal = false;

                    this.launch_data.prod_id = 1;
                    this.launch_data.price =
                        (this.selectedProd.price_min +
                            this.selectedProd.price_max) /
                        2;
                    this.launch_data.quantity = 1;
                    this.launch_data.machine_lvl = 1;
                    this.launch_data.machine_nb = 1;

                    // this.getStock();

                    this.$emit("prodLaunched");
                })
                .catch((e) => {
                    this.show_error = true;
                    this.message =
                        "Oops ! Une erreur est survenue, veuillez infomrer un organisateur";

                    this.launch_prod_modal = false;

                    this.launch_data.prod_id = 1;
                    this.launch_data.price =
                        (this.selectedProd.price_min +
                            this.selectedProd.price_max) /
                        2;
                    this.launch_data.quantity = 1;
                    this.launch_data.machine_lvl = 1;

                    // this.getStock();
                });
        },
        getStock() {
            this.stock_updated = false;
            axios
                .get("/api/entreprise/stock", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((resp) => {
                    this.stock = resp.data;

                    this.launch_data.prod_id = 1;
                    this.launch_data.machine_lvl = 1;
                    this.launch_data.quantity = 1;
                    this.launch_data.price =
                        (this.selectedProd.price_min +
                            this.selectedProd.price_max) /
                        2;

                    this.verifyProd();

                    this.stock_updated = true;
                });
        },
        verifyProd() {
            this.prod_factors = {
                machines: this.launch_data.machine_nb,
                // this.launch_data.quantity * this.selectedProd.machine_units,

                labor_lv1:
                    (this.launch_data.machine_lvl == 2 ? 2 : 1) *
                    this.launch_data.machine_nb,

                labor_lv2:
                    this.launch_data.machine_lvl == 3
                        ? this.launch_data.machine_nb
                        : 0,
            };

            let resp = true;
            if (
                this.launch_data.price > this.selectedProd.price_max ||
                this.launch_data.price < this.selectedProd.price_min
            ) {
                resp = false;
                this.can_produce_msg =
                    "Le prix doit être entre " +
                    this.selectedProd.price_min +
                    " DA - " +
                    this.selectedProd.price_max +
                    " DA";
            } else {
                let free_machines = 0;

                let free_workers_lv1 =
                    this.indicators["nb_workers_lv1"].value -
                    this.indicators["nb_workers_lv1_busy"].value;
                let free_workers_lv2 =
                    this.indicators["nb_workers_lv2"].value -
                    this.indicators["nb_workers_lv2_busy"].value;

                if (this.launch_data.machine_lvl == 1) {
                    free_machines =
                        this.indicators["nb_machines_lv1"].value -
                        this.indicators["nb_machines_lv1_busy"].value;
                } else if (this.launch_data.machine_lvl == 2) {
                    free_machines =
                        this.indicators["nb_machines_lv2"].value -
                        this.indicators["nb_machines_lv2_busy"].value;
                } else if (this.launch_data.machine_lvl == 3) {
                    free_machines =
                        this.indicators["nb_machines_lv3"].value -
                        this.indicators["nb_machines_lv3_busy"].value;
                }

                if (
                    this.prod_factors.labor_lv1 > free_workers_lv1 &&
                    free_workers_lv2 > 0
                ) {
                    this.prod_factors.labor_lv2 =
                        parseInt(this.prod_factors.labor_lv2) +
                        parseInt(this.prod_factors.labor_lv1) -
                        free_workers_lv1;
                    this.prod_factors.labor_lv1 = free_workers_lv1;
                }

                if (
                    this.prod_factors.machines <= free_machines &&
                    this.prod_factors.labor_lv1 <= free_workers_lv1 &&
                    this.prod_factors.labor_lv2 <= free_workers_lv2
                ) {
                    for (const material of this.selectedProd.raw_materials) {
                        let stock_material = this.stock.find((item) => {
                            return item.id == material.pivot.raw_material_id;
                        });
                        if (stock_material == undefined) {
                            resp = false;
                            this.can_produce_msg =
                                "Pas assez de matière " +
                                material.name +
                                " vous ne pouvez pas lancer la production !";
                            break;
                        }
                        if (material.pivot.quantity < stock_material.quantity) {
                            continue;
                        } else {
                            resp = false;
                            this.can_produce_msg =
                                "Pas assez de matière " +
                                material.name +
                                " vous ne pouvez pas lancer la production !";
                            break;
                        }
                    }
                } else {
                    resp = false;
                    if (this.prod_factors.machines > free_machines) {
                        this.can_produce_msg =
                            "Pas assez de machines libres, vous ne pouvez pas lancer la production !";
                    } else {
                        this.can_produce_msg =
                            "Pas assez d'employés libres, vous ne pouvez pas lancer la production !";

                        if (this.launch_data.machine_lvl == 3) {
                            this.can_produce_msg =
                                "Pas assez d'employés qualifiés libres pour utiliser des machines de niveau 3 !";

                            if (free_workers_lv2 == 0) {
                                this.can_produce_msg =
                                    "Vous n'avez pas d'employés qualifiés pour utiliser des machines de niveau 3 !";
                            }
                        }
                    }
                }
            }
            this.can_produce = resp;
        },
        getMachineInfo(type) {
            this.machine_info_updated = false;
            axios
                .post("/api/entreprise/machine/info", {
                    entreprise_id: this.user.id,
                })
                .then((resp) => {
                    this.machine.buy_price_lv1 = resp.data.buy_price_lv1;
                    this.machine.buy_price_lv2 = resp.data.buy_price_lv2;
                    this.machine.buy_price_lv3 = resp.data.buy_price_lv3;

                    this.machine.sell_price_lv1 = resp.data.sell_price_lv1;
                    this.machine.sell_price_lv2 = resp.data.sell_price_lv2;
                    this.machine.sell_price_lv3 = resp.data.sell_price_lv3;

                    this.machine.durability_lv1 = resp.data.durability_lv1;
                    this.machine.durability_lv2 = resp.data.durability_lv2;
                    this.machine.durability_lv3 = resp.data.durability_lv3;

                    this.machine.speed_lv1 = resp.data.speed_lv1;
                    this.machine.speed_lv2 = resp.data.speed_lv2;
                    this.machine.speed_lv3 = resp.data.speed_lv3;

                    this.machine.pollution_lv1 = resp.data.pollution_lv1;
                    this.machine.pollution_lv2 = resp.data.pollution_lv2;
                    this.machine.pollution_lv3 = resp.data.pollution_lv3;

                    this.machine_info_updated = true;
                });
        },
        confirmMachineTransaction() {
            this.machine.show_transaction_modal = false;
            if (this.machine.transaction == "buy") {
                // if (
                //     this.machine.buy_price * this.machine.transaction_nb >
                //     this.caisse
                // ) {
                //     this.show_error = true;
                //     this.message =
                //         "Vos disponibilités ne suffisent pas pour acheter " +
                //         this.machine.transaction_nb +
                //         " machine(s)";
                //     this.machine.show_transaction_modal = false;
                //     return "";
                // }
                axios
                    .post("/api/entreprise/machine/buy", {
                        entreprise_id: this.user.id,
                        level: this.machine.transaction_lv,
                        number: this.machine.transaction_nb,
                    })
                    .then((resp) => {
                        this.machine.show_transaction_modal = false;
                        this.machine.transaction_nb = 1;
                        this.machine.transaction_lv = 1;

                        if (resp.data.success) {
                            this.show_success = true;
                            this.show_error = false;
                        } else {
                            this.show_success = false;
                            this.show_error = true;
                        }

                        this.message = resp.data.message;
                    });
            } else if (this.machine.transaction == "sell") {
                // let nb_machines = 0;
                // let nb_machines_busy = 0;

                // if (this.machine.transaction_lv == 1) {
                //     nb_machines = this.indicators["nb_machines_lv1"]["value"];
                //     nb_machines_busy = this.indicators["nb_machines_lv1_busy"]["value"];
                // }
                // else if (this.machine.transaction_lv == 2) {
                //     nb_machines = this.indicators["nb_machines_lv2"]["value"];
                //     nb_machines_busy = this.indicators["nb_machines_lv2_busy"]["value"];
                // }
                // else if (this.machine.transaction_lv == 3) {
                //     nb_machines = this.indicators["nb_machines_lv3"]["value"];
                //     nb_machines_busy = this.indicators["nb_machines_lv3_busy"]["value"];
                // }

                // if (this.machine.transaction_nb > nb_machines) {
                //     this.show_error = true;
                //     this.message = "Pas assez de machines!";
                //     this.machine.transaction_nb = 1;
                //     this.machine.transaction_lv = 1;
                //     this.machine.show_transaction_modal = false;
                //     return;
                // }
                // else if (this.machine.transaction_nb > nb_machines - nb_machines_busy) {
                //     this.show_error = true;
                //     this.message = "Vous ne pouvez pas vendre les machines en plein production";
                //     this.machine.transaction_nb = 1;
                //     this.machine.transaction_lv = 1;
                //     this.machine.show_transaction_modal = false;
                //     return;
                // }

                axios
                    .post("/api/entreprise/machine/sell", {
                        entreprise_id: this.user.id,
                        level: this.machine.transaction_lv,
                        number: this.machine.transaction_nb,
                    })
                    .then((resp) => {
                        this.machine.show_transaction_modal = false;
                        this.machine.transaction_nb = 1;
                        this.machine.transaction_lv = 1;

                        if (resp.data.success) {
                            this.show_success = true;
                            this.show_error = false;
                        } else {
                            this.show_success = false;
                            this.show_error = true;
                        }

                        this.message = resp.data.message;
                    });
            }
        },
        showActionInfo() {
            switch (this.action.value) {
                case "5s":
                    this.action.phrase =
                        "Vous allez lancer une amélioration en appliquant les 5S, celà vous coutera " +
                        this.action.price["5s"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pourrez produire plus rapidement !";
                    break;
                case "audit":
                    this.action.phrase =
                        "Vous allez lancer un audit qualité en suivant la norme ISO 9001, celà vous coutera " +
                        this.action.price["audit"] +
                        " DA";
                    this.action.result_phrase =
                        "Votre taux de rebut sera plus faible.";
                    break;
                case "maintenance_lv1":
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 1, celà vous coutera " +
                        this.action.price["maintenance_lv1"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines de niveau 1 avec un prix plus élevé.";
                    break;
                case "maintenance_lv2":
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 2, celà vous coutera " +
                        this.action.price["maintenance_lv2"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines de niveau 2 avec un prix plus élevé.";
                    break;
                case "maintenance_lv3":
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 3, celà vous coutera " +
                        this.action.price["maintenance_lv3"] +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines de niveau 3 avec un prix plus élevé.";
                    break;
            }
            this.action.show_info = true;
        },
        confirmAction() {
            this.action.show_info = false;
            let price = this.action.price[this.action.value];
            // if (price > this.caisse) {
            //     this.show_error = true;
            //     this.message =
            //         "Vos disponibilités ne suffisent pas pour acheter des machines";
            //     this.action.show_info = false;
            //     return "";
            // }
            axios
                .post("/api/entreprise/action/apply", {
                    type: this.action.value,
                    price: price,
                    entreprise_id: this.user.id,
                })
                .then((resp) => {
                    this.action.show_info = false;

                    if (resp.data.success) {
                        this.show_success = true;
                        this.show_error = false;
                    } else {
                        this.show_success = false;
                        this.show_error = true;
                    }

                    this.message = resp.data.message;
                });
        },
    },
    mounted() {
        this.getMachineInfo();
        this.getStock();

        window.Echo.channel("entreprise_" + this.user.id)
            .listen("NewNotification", (e) => {
                if (e.notification.type == "StockUpdate") {
                    this.getStock();
                    this.$forceUpdate();
                }
                if (e.notification.type == "MachinesUpdate") {
                    this.getMachineInfo();
                    this.$forceUpdate();
                }
            });
    }
};
</script>
