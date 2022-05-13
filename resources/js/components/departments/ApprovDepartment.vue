<template>
    <div>
        <div>
            <nav class="mb-10 text-sm flex justify-start gap-8">
                <button
                    @click="changeTab('commands')"
                    :class="
                        page_index == 'commands'
                            ? 'border-b-2 border-vert text-vert font-semibold'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg font-heading font-medium text-vN"
                    href="#"
                >
                    Vos commandes
                </button>

                <!-- active -->
                <button
                    @click="changeTab('stock')"
                    :class="
                        page_index == 'stock'
                            ? 'border-b-2 border-vert text-vert font-semibold'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg font-heading font-medium text-vN"
                    href="#"
                >
                    Stock
                </button>

                <button
                    @click="changeTab('command_creator')"
                    :class="
                        page_index == 'command_creator'
                            ? 'border-b-2 border-vert text-vert font-semibold'
                            : 'text-vN hover:text-black'
                    "
                    class="inline-block py-2 focus:outline-none text-lg font-heading font-medium text-vN"
                    href="#"
                >
                    Créer une commande
                </button>
            </nav>
        </div>

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

        <div v-if="page_index == 'commands'">
            <div
                v-if="commands.length == 0"
                class="w-full flex flex-col items-center"
            >
                <p class="text-lg text-vN mt-2 ml-3">
                    Vous n'avez pas encore de commandes.
                </p>
                <button
                    @click="changeTab('command_creator')"
                    class="text-vN rounded-3xl px-5 py-2 font-semibold mt-5 bg-gradient-to-t from-[#B2D06B40] to-[#B2D06B11]"
                    href="#"
                >
                    Créer une commande
                </button>
            </div>

            <div
                v-else
                class="w-full bg-white shadow-md rounded mt-5 overflow-y-scroll"
                style="max-height: 60vh"
            >
                <table class="border-collapse w-full table-auto">
                    <thead
                        class="sticky top-0 border-b bg-white font-semibold text-vN"
                    >
                        <tr>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                @click="sort('command_id')"
                            >
                                Numéro
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                @click="sort('num_items')"
                            >
                                Nombre d'items
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                @click="sort('creation_date')"
                            >
                                date de création
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                @click="sort('status')"
                            >
                                Status
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="(cmd, key) in commands"
                            v-bind:key="key"
                            class="bg-white flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-gray text-vN font-light text-sm h-14"
                        >
                            <td
                                class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                            >
                                {{ cmd.command_id }}
                            </td>
                            <td
                                class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                            >
                                {{ cmd.num_items }}
                            </td>
                            <td
                                class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                            >
                                Semaine N° {{ cmd.creation_date }}
                            </td>
                            <td
                                class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                            >
                                <span
                                    :class="
                                        cmd.status == 'confirmed'
                                            ? 'text-vert'
                                            : 'text-yellow-500'
                                    "
                                    >{{ getStatus(cmd.status) }}</span
                                >
                            </td>
                            <td
                                class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                            >
                                <button @click="showDetails(cmd)">
                                    <img
                                        class="text-white"
                                        src="/assets/icons/menu-points-vertical.svg"
                                        alt="un triangle aux trois côtés égaux"
                                        height="20px"
                                        width="15px"
                                    />
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- <table class="w-full   h-96 overflow-y-scroll">
                <thead
                    class="sticky  top-0 border-b bg-white font-semibold text-vN"
                >
                    <tr>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('command_id')"
                        >
                            Numéro
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('num_items')"
                        >
                           Nombre D'item
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('creation_date')"
                        >
                           Date De Création
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            @click="sort('status')"
                        >
                            Status
                        </th>
                        <th
                            class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"

                        >

                        </th>

                    </tr>
                </thead>
                <tbody  >
                    <tr
                        v-for="(cmd, key) in commands"
                        v-bind:key="key"
                        class="bg-white  flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-gray text-vN font-light text-sm h-14"
                    >
                        <td
                            class="  "
                        >
                            {{ cmd.command_id }}
                        </td>
                        <td
                            class=""
                        >
                            {{ cmd.num_items }}
                        </td>
                        <td
                            class=""
                        >
                              Jour N° {{ cmd.creation_date }}
                        </td>
                        <td
                            class=""
                        >
                            <span
                                    :class="
                                        cmd.status == 'confirmed'
                                            ? 'text-vert'
                                            : 'text-yellow-500'
                                    "
                                    >{{ getStatus(cmd.status) }}</span
                                >
                        </td>
                        <td
                            class=""
                        >
                            <button @click="showDetails(cmd)">
                                <img class="text-white" src="/assets/icons/menu-points-vertical.svg" alt="un triangle aux trois côtés égaux" height="20px" width="15px" /></button>
                        </td>

                    </tr>
                </tbody>
            </table> -->
            </div>

            <Modal
                v-if="show_details_modal"
                id="modal"
                class="align-content-center openmodal"
            >
                <template v-slot:content>
                    <div class="flex flex-col p-4 items-start">
                        <div class="flex justify-between item-center w-full">
                            <h1 class="text-vert text-2xl font-bold">
                                Détails sur la commande N°
                                {{ current_command.command_id }}
                            </h1>
                            <img
                                src="/assets/icons/close.svg"
                                class="w-6 h-6 cursor-pointer"
                                alt="close icon"
                                @click="show_details_modal = false"
                            />
                        </div>

                        <br />

                        <table class="w-full mt-3 bg-[#f9f9fc]">
                            <thead class="text-xs uppercase">
                                <tr
                                    class="border-b border-t border-tableBorder text-vN"
                                >
                                    <th class="px-4 py-3">Matière Premiere</th>
                                    <th class="px-4 py-3">Quantité (KG)</th>
                                    <th class="px-4 py-3">Fournisseur</th>
                                    <th class="px-4 py-3">Date de Livraison</th>
                                    <th class="px-4 py-3">Statue</th>
                                </tr>
                            </thead>

                            <tbody>
                                <tr
                                    v-for="(
                                        item, key
                                    ) in current_command.details"
                                    :key="key"
                                    class="text-vN border-b border-tableBorder"
                                >
                                    <td class="text-center py-3 px-4">
                                        {{ item.material }}
                                    </td>
                                    <td class="text-center py-3 px-4">
                                        {{ item.quantity }} {{ item.unit }}
                                    </td>
                                    <td class="text-center py-3 px-4">
                                        {{ item.supplier }}
                                    </td>
                                    <td>
                                        Semaine N° {{ item.reception_date }}
                                    </td>
                                    <td>
                                        <span
                                            :class="
                                                item.status == 'confirmed'
                                                    ? 'text-vert px-4 text-center'
                                                    : 'text-jaune px-4 text-center'
                                            "
                                            >{{ getStatus(item.status) }}
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- <button
                            class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-7 mx-auto"
                            @click="show_details_modal = false"
                        >
                            Fermer
                        </button> -->
                    </div>
                </template>
            </Modal>

            <!--
            <Modal
                v-if="show_details_modal"
                id="modal"
                class="align-center modal"
                custom_css="w-3/5"
            >
                <template v-slot:content>
                    <h3 class="font-extrabold text-lg my-3">
                        Détails sur la commande N°
                        {{ current_command.command_id }}
                    </h3>

                    <p
                        v-for="(item, key) in current_command.details"
                        v-bind:key="key"
                    >
                        * {{ item.quantity }} {{ item.unit }} de
                        {{ item.material }} chez <b>{{ item.supplier }}</b> -
                        <span
                            :class="
                                item.status == 'confirmed'
                                    ? 'text-green-500'
                                    : 'text-yellow-500'
                            "
                            >{{ getStatus(item.status) }} - Date de livraison:
                            Jour N° {{ item.reception_date }}</span
                        >
                    </p>

                    <button
                        class="
                            bg-gray-200
                            active:bg-gray-600
                            hover:bg-gray-400
                            text-back
                            px-3
                            py-2
                            rounded
                            w-1/2
                            mt-4
                        "
                        @click="show_details_modal = false"
                    >
                        Fermer
                    </button>
                </template>
            </Modal> -->
        </div>

        <div v-if="page_index == 'stock'" class="mt-5">
            <Stock
                :user="user"
                :stock="stock"
                @create-command="changeTab('command_creator')"
            ></Stock>
        </div>

        <div v-if="page_index == 'command_creator'">
            <CommandMaker
                ref="command_maker"
                :user="user"
                :caisse="caisse"
            ></CommandMaker>
        </div>

        <Modal
            v-if="show_change_tab_modal"
            id="modal"
            class="align-center modal"
            custom_css="w-3/5"
        >
            <template v-slot:content>
                <div class="flex flex-col p-2">
                    <h3 v-if="!$refs.command_maker.command_sent" class="font-extrabold text-lg my-3 text-vN">
                        Voulez vous annuler la commande ?
                    </h3>

                    <h3 v-else class="font-extrabold text-lg my-3 text-vN">
                        Si vous quittez maintenant, vous allez annuler la commande que vous venez d'envoyer.
                    </h3>

                    <div class="flex gap-3">
                        <button
                            class="active:bg-red-600 text-vN hover:bg-gray-200 px-3 py-2 rounded w-1/2 mt-4"
                            @click="changeTab(null, true)"
                        >
                            Continuer
                        </button>

                        <button
                            class="active:bg-gray-600 hover:bg-gray-200 text-vN text-opacity-80 px-3 py-2 rounded w-1/2 mt-4"
                            @click="
                                next_tab = null;
                                show_change_tab_modal = false;
                            "
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
import CommandItem from "./ui/CommandItem";
import Stock from "./ui/Stock";
import CommandMaker from "./ui/CommandMaker";
import Modal from "../Modal";
export default {
    name: "DepartmentCard",
    components: { CommandItem, Modal, Stock, CommandMaker },
    data() {
        return {
            show_success: false,
            show_error: false,

            message: "",

            current_command: {},

            show_change_tab_modal: false,
            show_details_modal: false,

            commands_loaded: false,
            stock_loaded: false,

            page_index: "commands",
            next_tab: null,

            caisse: 0,

            commands: [],
            stock: [],
        };
    },
    props: ["user"],
    computed: {},
    methods: {
        sort(key) {
            this.reverse = !this.reverse;
            this.commands.sort((a, b) => {
                if (a[key] < b[key]) {
                    return this.reverse ? -1 : 1;
                }
                if (a[key] > b[key]) {
                    return this.reverse ? 1 : -1;
                }
                console.log(this.commands);
                return 0;
            });
        },
        showDetails(command) {
            this.current_command = command;
            this.show_details_modal = true;
        },

        getStatus(status) {
            if (status == "pending") {
                return "Livraison...";
            } else if (status == "confirmed") {
                return "Reçue";
            }
        },

        getCommands() {
            axios
                .get("/api/entreprise/commands", {
                    params: { entreprise_id: this.user.id },
                })
                .then((resp) => {
                    this.commands = resp.data;
                    this.commands_loaded = true;
                });
        },

        getStock() {
            axios
                .get("/api/entreprise/stock", {
                    params: {
                        entreprise_id: this.user.id,
                    },
                })
                .then((response) => {
                    this.stock = response.data;
                })
                .catch(function (error) {});
        },

        changeTab(tab_name = null, confirm = false) {
            if (!confirm) {
                if (
                    this.page_index == "command_creator" &&
                    (this.$refs.command_maker.commands.length > 0 || this.$refs.command_maker.command_sent)
                ) {
                    this.next_tab = tab_name;
                    this.show_change_tab_modal = true;
                } else {
                    this.page_index = tab_name;
                }
            } else {
                this.page_index = this.next_tab;
                this.show_change_tab_modal = false;
            }
        },
    },
    created() {
        axios
            .get("/api/navbar", {
                params: {
                    entreprise_id: this.user.id,
                    type: this.user.type,
                },
            })
            .then((resp) => {
                this.caisse = resp.data["caisse"];
            });

        this.getCommands();
        this.getStock();
    },
    mounted() {
        window.Echo.channel("entreprise_" + this.user.id)
            .listen("NewNotification", (e) => {
                if (e.notification.type == "CommandUpdate") {
                    this.getCommands();
                    this.$forceUpdate();
                }
                if (e.notification.type == "StockUpdate") {
                    this.getStock();
                    this.$forceUpdate();
                }
                if (e.notification.type == "AdminNotif") {
                    this.getStock();
                    this.$forceUpdate();
                }
            })
            .listen("NavbarDataChanged", (e) => {
                this.caisse = e.caisse;
            });
    },
};
</script>
