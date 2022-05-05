<template>
    <div class="w-full">
        <!-- <div
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
        </div> -->

        <div class="flex gap-6 mt-10">
            <div
                class="flex-grow bg-white rounded-xl gap-6 text-center flex flex-col py-7 shadow-lg px-2"
            >
                <img class="mx-auto h-16 w-16" src="/images/prod.png" alt="" />
                <div class="mx-auto text-center text-vN flex-1">
                    <h1 class="text-2xl font-medium mb-4 font-heading">
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
                    @click="launch_prod_modal = true"
                    class="bg-vN bg-opacity-85 text-white mx-auto py-2 px-11 mb-8 text-lg font-medium rounded-3xl"
                >
                    Lancer
                </button>
            </div>

            <div
                class="flex-grow rounded-xl bg-white gap-6 text-center flex flex-col py-7 shadow-xl px-2"
                style="border-width: 0.5px"
            >
                <img
                    class="mx-auto h-16 w-16"
                    src="/images/machine.png"
                    alt=""
                />
                <div class="mx-auto text-center text-vN flex-1">
                    <h1 class="text-2xl font-medium mb-4 font-heading">
                        Machine
                    </h1>
                    <p class="text-sm text-nav text-opacity-80">
                        En achetant de nouvelles machines ou en réparant des
                        anciennes machines vous pourrez produire plus de
                        quantité.
                        <br />
                    </p>
                    <p class="text-sm text-nav text-opacity-80 mt-2">
                        <span class="text-jaune font-medium font-heading">
                            Astuce :</span
                        >
                        Attention à ne pas sur-estimer vos besoins en machines
                    </p>
                </div>
                <div class="flex flex-col gap-3 mt-3">
                    <button
                        @click="
                            machine.transaction = 'buy';
                            machine.show_transaction_modal = true;
                        "
                        class="bg-vN bg-opacity-85 text-white mx-auto py-2 px-11 text-lg font-medium rounded-3xl"
                    >
                        Acheter
                    </button>
                    <button
                        @click="
                            machine.transaction = 'sell';
                            machine.show_transaction_modal = true;
                        "
                        class="bg-vN bg-opacity-85 text-white mx-auto py-2 px-11 text-lg font-medium rounded-3xl"
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
                    class="rounded-md focus:border-vert focus:ring-0 w-5/6 mx-auto border-tableBorder"
                    style="border-width: 1px"
                >
                    <option value="maintenance_lv1">
                        Réparation machines niveau 1
                    </option>
                    <option value="maintenance_lv2">
                        Réparation machines niveau 2
                    </option>
                    <option value="maintenance_lv3">
                        Réparation machines niveau 3
                    </option>
                    <option value="5s">Appliquer les 5S</option>
                    <option value="audit">Effectuer un audit qualité</option>
                </select>
                <button
                    @click="showActionInfo"
                    class="bg-vN bg-opacity-85 text-white mx-auto py-2 px-11 mb-8 text-lg font-medium rounded-3xl"
                >
                    Lancer
                </button>
            </div>
        </div>
        <Modal v-if="launch_prod_modal" class="openmodal">
            <template v-slot:content>
                <div class="flex flex-col w-2/5 px-6 mx-auto gap-3">
                    <h1 class="text-vert font-semibold text-2xl font-heading">
                        Lancer une production
                    </h1>
                    <div>
                        <h1
                            class="text-vN text-lg mt-4 font-heading font-medium"
                        >
                            Produit :
                        </h1>

                        <div v-if="products.length > 0">
                            <select
                                v-model="launch_data.prod_id"
                                class="ring-1 ring-tableBorder border-0 focus-within:ring-vert"
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
                        <div v-else></div>
                    </div>

                    <div>
                        <h1
                            class="text-vN text-lg mt-2 font-heading font-medium"
                        >
                            Choix de la machine :
                        </h1>

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
                    </div>
                    <div>
                        <h1
                            class="text-vN text-lg mt-2 font-heading font-medium"
                        >
                            Nombre de machines:
                        </h1>

                        <input
                            class="w-2/3 ring-1 ring-tableBorder border-0 focus-within:ring-vert text-jaune"
                            v-model.number="launch_data.machine_nb"
                            type="number"
                            min="1"
                            :max="
                                launch_data.machine_lvl == 1
                                    ? indicators['nb_machines_lv1'].value -
                                      indicators['nb_machines_lv1_busy'].value
                                    : launch_data.machine_lvl == 2
                                    ? indicators['nb_machines_lv2'].value -
                                      indicators['nb_machines_lv2_busy'].value
                                    : indicators['nb_machines_lv3'].value -
                                      indicators['nb_machines_lv3_busy'].value
                            "
                        />
                    </div>
                    <div>
                        <h1 class="text-vN text-lg font-heading font-medium">
                            Quantité( en lot de 1000 pièces)
                        </h1>
                        <input
                            type="number"
                            v-model.number="launch_data.quantity"
                            min="1"
                            class="ring-1 ring-tableBorder border-0 focus-within:ring-vert text-jaune"
                        />
                        <!-- <input
                            type="number "
                            v-model.number="launch_data.quantity"
                            class="px-2 text-lg text-yellow-500 border rounded-md border-gray-200"
                            min="1"
                        /> -->
                    </div>

                    <p class="text-red-500 w-auto" v-if="can_produce == false">
                        {{ can_produce_msg }}
                    </p>

                    <div class="flex flex-row justify-center gap-7 mt-12">
                        <button
                            :disabled="
                                stock_updated == true &&
                                machine_info_updated == true &&
                                (can_produce == false || prod_launched == true)
                            "
                            :class="
                                can_produce == false
                                    ? 'opacity-40 bg-gray-600'
                                    : 'bg-vN'
                            "
                            @click="launchProduction()"
                            class="text-white px-7 py-1 rounded-md"
                        >
                            Lancer
                        </button>
                        <button
                            class="bg-vN text-white px-7 py-1 rounded-md hover:opacity-75"
                            :disabled="prod_launched == true"
                            @click="
                                launch_prod_modal = false;
                                launch_data.quantity = 1;
                                launch_data.machine_lvl = 1;
                                launch_data.machine_nb = 1;
                            "
                        >
                            Annuler
                        </button>
                    </div>
                </div>

                <div class="flex flex-col w-4/5 px-6">
                    <h1 class="text-vN pl-3 font-bold font-heading text-lg">
                        Informations importantes
                    </h1>
                    <h1 class="text-vN text-md font-heading font-semibold pl-3">
                        Nécessite :
                    </h1>
                    <div class="p-3">
                        <table class="w-full" style="background-color: #f9f9fc">
                            <thead class="text-xs uppercase">
                                <tr
                                    class="border-b border-tableBorder border-t text-vN"
                                >
                                    <th class="px-3 py-3">Matière première</th>
                                    <th class="px-3 py-3">
                                        Quantité nécessaire
                                    </th>
                                    <th class="px-3 py-3">Quantité en stock</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="(
                                        material, key
                                    ) in selectedProd.raw_materials"
                                    :key="key"
                                    class="text-vN border-b border-tableBorder"
                                >
                                    <td
                                        class="flex justify-center icon-material py-1"
                                    >
                                        <img
                                            class="h-8 w-8"
                                            :src="material.icon"
                                            alt="khobz"
                                        />
                                        <span>{{ material.name }}</span>
                                    </td>
                                    <td class="text-center py-1 text-vN">
                                        {{
                                            material.pivot.quantity *
                                            launch_data.quantity
                                        }}
                                    </td>
                                    <td
                                        v-if="
                                            stock != null &&
                                            stock.length > 0 &&
                                            stock.find(
                                                (element) =>
                                                    element.id == material.id
                                            ) != undefined
                                        "
                                        class="text-center py-1 text-vN"
                                        :class="
                                            material.pivot.quantity *
                                                launch_data.quantity <=
                                            stock.find((item) => {
                                                return (
                                                    item.id ==
                                                    material.pivot
                                                        .raw_material_id
                                                );
                                            }).quantity
                                                ? ''
                                                : 'text-red-500'
                                        "
                                    >
                                        <span
                                            v-if="
                                                stock.find(
                                                    (element) =>
                                                        element.id ==
                                                        material.id
                                                ) != undefined
                                            "
                                        >
                                            {{
                                                stock.find(
                                                    (element) =>
                                                        element.id ==
                                                        material.id
                                                ).quantity
                                            }}
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
                    <h1 class="text-vN text-md font-heading font-semibold pl-3">
                        Machines :
                    </h1>

                    <div class="p-3">
                        <table class="w-full" style="background-color: #f9f9fc">
                            <thead class="text-xs uppercase">
                                <tr
                                    class="border-b border-t border-tableBorder"
                                >
                                    <th class="px-4 text-vN py-3">
                                        Temps Total estimé
                                    </th>
                                    <!-- <th class="px-4 py-1 text-vN">
                                        Temps unitaire
                                    </th> -->
                                    <th class="px-4 text-vN py-3">
                                        Employés libres
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b">
                                    <td
                                        class="text-center icon-material text-jaune py-1"
                                    >
                                        {{
                                            Math.round(
                                                prodDelay * Math.pow(10, 2)
                                            ) / Math.pow(10, 2)
                                        }}
                                        J
                                    </td>
                                    <!-- <td
                                        class="text-center text-yellow-500 py-1"
                                    >
                                        FILL THIS (lot/min)
                                    </td> -->
                                    <td class="text-center text-jaune py-1">
                                        Simples:
                                        <span
                                            class="font-bold text-vN mb-3"
                                            :class="
                                                indicators['nb_workers_lv1']
                                                    .value -
                                                    indicators[
                                                        'nb_workers_lv1_busy'
                                                    ].value >=
                                                prod_factors.labor_lv1
                                                    ? ''
                                                    : 'text-red-700'
                                            "
                                        >
                                            {{ prod_factors.labor_lv1 }} /
                                            {{
                                                indicators["nb_workers_lv1"]
                                                    .value -
                                                indicators[
                                                    "nb_workers_lv1_busy"
                                                ].value
                                            }}
                                        </span>
                                        <br />
                                        Experts:
                                        <span
                                            class="font-bold text-vN"
                                            :class="
                                                indicators['nb_workers_lv2']
                                                    .value -
                                                    indicators[
                                                        'nb_workers_lv2_busy'
                                                    ].value >=
                                                prod_factors.labor_lv2
                                                    ? ''
                                                    : 'text-red-700'
                                            "
                                        >
                                            {{ prod_factors.labor_lv2 }} /
                                            {{
                                                indicators["nb_workers_lv2"]
                                                    .value -
                                                indicators[
                                                    "nb_workers_lv2_busy"
                                                ].value
                                            }}
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <h1
                        class="text-vert text-md font-heading font-semibold pl-3"
                    >
                        Prévisions :
                    </h1>
                    <div class="p-3">
                        <table class="w-full" style="background-color: #f9f9fc">
                            <thead class="text-xs text-gray-700 uppercase">
                                <tr class="border-b border-t">
                                    <!-- <th class="px-4 py-1 text-vN">
                                        Chiffre d’Affaire Estimés
                                    </th> -->
                                    <th class="px-4 text-vN py-3">
                                        Coût Total Estimé
                                    </th>
                                    <!-- <th class="px-4 py-1 text-vN">
                                        Profit Estimé
                                    </th> -->
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b">
                                    <!-- <td class="flex justify-center icon-material text-yellow-500 py-1">
                                        {{ salesRevenues }} DA
                                    </td> -->
                                    <td class="text-center text-vert py-1">
                                        {{ Math.round(totalCost) }} DA
                                    </td>
                                    <!-- <td class="text-center text-yellow-500 py-1">
                                        {{ profit }} DA
                                    </td> -->
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div
                        class="flex flex-row items-center mt-6 px-4 py-2 gap-3 border rounded-md border-yellow-500"
                    >
                        <img
                            src="/assets/icons/warning.png"
                            class="h-10 w-10"
                            alt="fgghgf"
                        />
                        <h1 class="w-80 text-vN">
                            Votre taux de rebut est de
                            {{
                                Math.round(
                                    indicators["reject_rate"].value *
                                        Math.pow(10, 2)
                                )
                            }}%, pour le réduire, lancez une étude AMDEC.
                        </h1>
                    </div>
                </div>
            </template>
        </Modal>

        <Modal v-if="machine.show_transaction_modal" class="openmodal">
            <template v-slot:content>
                <div class="flex flex-col items-center gap-5 p-5">
                    <h2
                        v-if="machine.transaction == 'buy'"
                        class="text-vert font-bold text-xl"
                    >
                        Acheter une Machine
                    </h2>
                    <h2
                        v-if="machine.transaction == 'sell'"
                        class="text-vert font-bold text-xl"
                    >
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
                                v-model.number="machine.transaction_lv"
                            >
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </div>
                        <div class="flex flex-col items-start gap-2">
                            <p class="text-md font-medium text-nav">
                                Nombre que vous souhaitez
                                {{
                                    machine.transaction == "buy"
                                        ? "acheter"
                                        : "vendre"
                                }}
                            </p>
                            <input
                                v-model.number="machine.transaction_nb"
                                min="1"
                                :max="
                                    machine.transaction == 'sell'
                                        ? machine.transaction_lv == 1
                                            ? indicators['nb_machines_lv1']
                                                  .value -
                                              indicators['nb_machines_lv1_busy']
                                                  .value
                                            : machine.transaction_lv == 2
                                            ? indicators['nb_machines_lv2']
                                                  .value -
                                              indicators['nb_machines_lv2_busy']
                                                  .value
                                            : indicators['nb_machines_lv3']
                                                  .value -
                                              indicators['nb_machines_lv3_busy']
                                                  .value
                                        : undefined
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
                                    (machine.transaction_lv == 1
                                        ? machine.buy_price_lv1
                                        : machine.transaction_lv == 2
                                        ? machine.buy_price_lv2
                                        : machine.buy_price_lv3) *
                                    machine.transaction_nb
                                }}
                            </p>
                            <p
                                v-else
                                class="py-2 px-4 border-gray-200 w-40 text-jaune"
                                style="border-width: 1px"
                            >
                                {{
                                    (
                                        (machine.transaction_lv == 1
                                            ? machine.buy_price_lv1
                                            : machine.transaction_lv == 2
                                            ? machine.buy_price_lv2
                                            : machine.buy_price_lv3) *
                                        machine.transaction_nb *
                                        indicators[
                                            machine.transaction_lv == 1
                                                ? "machines_lv1_health"
                                                : machine.transaction_lv == 2
                                                ? "machines_lv2_health"
                                                : "machines_lv3_health"
                                        ].value
                                    ).toPrecision(6)
                                }}
                            </p>
                        </div>
                    </div>
                    <div
                        class="w-full flex items-center gap-4 justify-end mt-5"
                    >
                        <button
                            v-if="
                                machine_info_updated == true ||
                                machine.transaction == 'buy'
                            "
                            @click="confirmMachineTransaction"
                            class="font-heading font-medium border-0 px-3 py-1 text-vN hover:text-vert bg-opacity-30"
                        >
                            Confirmer
                        </button>
                        <button
                            @click="
                                machine.transaction_nb =
                                    machine.transaction == 'buy'
                                        ? 1
                                        : machine.transaction_nb;
                                machine.transaction_lv = 1;
                                machine.show_transaction_modal = false;
                            "
                            class="font-heading font-medium px-3 py-1 text-vN opacity-80 hover:opacity-100"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>
        <Modal v-if="action.show_info" class="my-auto openmodal">
            <template v-slot:content>
                <div class="flex flex-col gap-5">
                    <h1 class="text-xl text-center text-jaune font-headgin">
                        {{ action.name }}
                    </h1>
                    <p class="text-vN">
                        {{ action.phrase }}
                    </p>
                    <p class="text-vN">
                        {{ action.result_phrase }}
                    </p>
                    <div class="w-full flex items-center gap-4 justify-end">
                        <button
                            @click="confirmAction"
                            class="font-heading font-medium px-3 py-1 text-vN hover:text-vert"
                        >
                            Confirmer
                        </button>
                        <button
                            @click="action.show_info = false"
                            class="font-heading font-medium px-3 py-1 text-vN text-opacity-80 hover:text-opacity-100"
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
                prod_id: 5,
                // price: 0,
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
            stock: [],

            prod_launched: false,

            show_success: false,
            show_error: false,
            message: "",
            action: {
                value: "maintenance_lv1",
                name: "Maintenance Niveau 1",
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
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.quantity": function () {
            this.launch_data.quantity = Math.round(this.launch_data.quantity);
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.machine_lvl": function () {
            this.can_produce = false;
            this.verifyProd();
        },
        "launch_data.machine_nb": function () {
            this.launch_data.machine_nb = Math.round(
                this.launch_data.machine_nb
            );
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

        indicators: function (n) {
            this.action.price["maintenance_lv1"] =
                10000 *
                (1 - n["machines_lv1_health"]["value"]) *
                n["nb_machines_lv1"]["value"];
            this.action.price["maintenance_lv2"] =
                10000 *
                (1 - n["machines_lv2_health"]["value"]) *
                n["nb_machines_lv2"]["value"];
            this.action.price["maintenance_lv3"] =
                10000 *
                (1 - n["machines_lv3_health"]["value"]) *
                n["nb_machines_lv3"]["value"];
            this.$forceUpdate();
            this.verifyProd();
        },
    },
    computed: {
        selectedProd() {
            return this.products.find(
                (item) => item.id == this.launch_data.prod_id
            );
        },

        totalCost() {
            return (
                this.launch_data.quantity *
                this.selectedProd.unit_prod_price *
                1000
            );
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
                    this.launch_data.quantity) /
                coeff
            );
        },
    },
    methods: {
        launchProduction() {
            this.prod_launched = true;

            let data = {
                product_id: this.selectedProd.id, // slected product id
                entreprise_id: this.user.id, // this users's id
                quantity: this.launch_data.quantity, // number of lots (1000 units) to be produced
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
                    this.prod_launched = true;

                    this.launch_data.prod_id = 5;

                    this.launch_data.quantity = 1;
                    this.launch_data.machine_lvl = 1;
                    this.launch_data.machine_nb = 1;

                    // this.getStock();

                    this.$emit("prodLaunched");
                    this.prod_launched = false;
                    this.$toasted.success("Production lancée", {
                        keepOnHover: true,
                        icon: {
                            name: "✔",
                        },
                        position: "bottom-right",
                        className: "toast-success",
                        duration: 3000,
                    });
                })
                .catch((e) => {
                    this.show_error = true;
                    this.message =
                        "Oops ! Une erreur est survenue, veuillez infomrer un organisateur";

                    this.launch_prod_modal = false;
                    this.$toasted.error("Production non lancée", {
                        keepOnHover: true,
                        icon: {
                            name: "❌",
                        },
                        position: "bottom-right",
                        className: "toast-error",
                        duration: 3000,
                    });

                    this.launch_data.prod_id = 5;
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

                    // this.launch_data.prod_id = 5;
                    // this.launch_data.machine_lvl = 1;
                    // this.launch_data.quantity = 1;

                    this.verifyProd();

                    this.stock_updated = true;
                });
        },

        verifyProd() {
            if (this.selectedProd == undefined) {
                return false;
            }

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

            let free_machines = 0;
            let machines_health = 0;

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

                machines_health = this.indicators["machines_lv1_health"].value;
            } else if (this.launch_data.machine_lvl == 2) {
                free_machines =
                    this.indicators["nb_machines_lv2"].value -
                    this.indicators["nb_machines_lv2_busy"].value;

                machines_health = this.indicators["machines_lv2_health"].value;
            } else if (this.launch_data.machine_lvl == 3) {
                free_machines =
                    this.indicators["nb_machines_lv3"].value -
                    this.indicators["nb_machines_lv3_busy"].value;

                machines_health = this.indicators["machines_lv3_health"].value;
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
                if (machines_health < 0.05) {
                    resp = false;
                    this.can_produce_msg =
                        "Les machines de niveau " +
                        this.launch_data.machine_lvl +
                        " sont HS (santé < 5%), veuillez les réparer pour pouvoir les utiliser.";
                }

                for (const material of this.selectedProd.raw_materials) {
                    if (
                        this.stock != null &&
                        this.stock.length > 0 &&
                        this.stock.find(
                            (element) => element.id == material.id
                        ) != undefined
                    ) {
                        if (
                            material.pivot.quantity *
                                this.launch_data.quantity >
                            this.stock.find((item) => {
                                return (
                                    item.id == material.pivot.raw_material_id
                                );
                            }).quantity
                        ) {
                            resp = false;
                            this.can_produce_msg =
                                "Pas assez de matière " +
                                material.name +
                                ", vous ne pouvez pas lancer la production !";
                            break;
                        }
                    } else {
                        resp = false;
                        this.can_produce_msg =
                            "Pas assez de matière " +
                            material.name +
                            ", vous ne pouvez pas lancer la production !";
                        break;
                    }

                    // let stock_material = this.stock.find((item) => {
                    //     return item.id == material.pivot.raw_material_id;
                    // });
                    // if (stock_material == undefined) {
                    //     resp = false;
                    //     this.can_produce_msg =
                    //         "Pas assez de matière " +
                    //         material.name +
                    //         " vous ne pouvez pas lancer la production !";
                    //     break;
                    // }
                    // if (material.pivot.quantity < stock_material.quantity) {
                    //     continue;
                    // } else {
                    //     resp = false;
                    //     this.can_produce_msg =
                    //         "Pas assez de matière " +
                    //         material.name +
                    //         " vous ne pouvez pas lancer la production !";
                    //     break;
                    // }
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

                    this.verifyProd();
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
                            this.$toasted.success("Machine(s) Achetée(s)", {
                                keepOnHover: true,
                                icon: {
                                    name: "✔",
                                },
                                position: "bottom-right",
                                className: "toast-success",
                                duration: 3000,
                            });
                        } else {
                            this.$toasted.error("Machine(s) Achetée(s)", {
                                keepOnHover: true,
                                icon: {
                                    name: "❌",
                                },
                                position: "bottom-right",
                                className: "toast-error",
                                duration: 3000,
                            });
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
                            this.$toasted.success("Machine(s) Vendue(s)", {
                                keepOnHover: true,
                                icon: {
                                    name: "✔",
                                },
                                position: "bottom-right",
                                className: "toast-success",
                                duration: 2000,
                            });
                            this.show_success = true;
                            this.show_error = false;
                        } else {
                            this.$toasted.error("Machine(s) Vendue(s)", {
                                keepOnHover: true,
                                icon: {
                                    name: "❌",
                                },
                                position: "bottom-right",
                                className: "toast-error",
                                duration: 2000,
                            });
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
                    this.action.name = "5S";
                    this.action.phrase =
                        "Vous allez lancer une amélioration en appliquant les 5S, celà vous coutera " +
                        this.action.price["5s"].toPrecision(6) +
                        " DA";
                    this.action.result_phrase =
                        "Vous pourrez produire plus rapidement !";
                    break;
                case "audit":
                    this.action.name = "Audit Qualité";
                    this.action.phrase =
                        "Vous allez lancer un audit qualité en suivant la norme ISO 9001, celà vous coutera " +
                        this.action.price["audit"].toPrecision(6) +
                        " DA";
                    this.action.result_phrase =
                        "Votre taux de rebut sera plus faible.";
                    break;
                case "maintenance_lv1":
                    this.action.name = "Maintenance Niveau 1";
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 1, celà vous coutera " +
                        this.action.price["maintenance_lv1"].toPrecision(6) +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines de niveau 1 avec un prix plus élevé.";
                    break;
                case "maintenance_lv2":
                    this.action.name = "Maintenance Niveau 2";
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 2, celà vous coutera " +
                        this.action.price["maintenance_lv2"].toPrecision(6) +
                        " DA";
                    this.action.result_phrase =
                        "Vous pouvez vendre vos machines de niveau 2 avec un prix plus élevé.";
                    break;
                case "maintenance_lv3":
                    this.action.name = "Maintenance Niveau 3";
                    this.action.phrase =
                        "Vous allez réparer vos machines de niveau 3, celà vous coutera " +
                        this.action.price["maintenance_lv3"].toPrecision(6) +
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
                        this.$toasted.show(resp.data.message, {
                            keepOnHover: true,
                            singleton: true,
                            icon: {
                                name: "✔",
                            },
                            position: "bottom-right",
                            className: "toast-success",
                            duration: 3000,
                        });
                    } else {
                        this.$toasted.show(resp.data.message, {
                            keepOnHover: true,
                            singleton: true,
                            icon: {
                                name: "❌",
                            },
                            position: "bottom-right",
                            className: "toast-error",
                            duration: 3000,
                        });
                        this.show_success = false;
                        this.show_error = true;
                    }

                    this.message = resp.data.message;
                });
        },
    },
    mounted() {
        window.Echo.channel("entreprise_" + this.user.id).listen(
            "NewNotification",
            (e) => {
                if (e.notification.type == "StockUpdate") {
                    this.getStock();
                    this.$forceUpdate();
                }
                if (e.notification.type == "MachinesUpdate") {
                    this.getMachineInfo();
                    this.$forceUpdate();
                }
                if (e.notification.type == "AdminNotif") {
                    this.getMachineInfo();
                    this.$forceUpdate();
                }
            }
        );
    },
    created() {
        this.getMachineInfo();
        this.getStock();
    },
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
