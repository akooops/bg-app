<template>
    <div>
        <div
            v-if="show_success"
            class="
                my-2
                bg-green-100
                border border-green-400
                text-green-700
                px-4
                py-3
                rounded
                relative
            "
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
            class="
                bg-red-100
                border border-red-400
                text-red-700
                px-4
                py-3
                rounded
                relative
            "
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
        <div v class="w-full bg-white shadow-md rounded my-2">

            <table  class="border-collapse w-full table-fixed">
                <thead
                    class="sticky  top-0 border-b bg-white font-semibold text-vN"
                >
                    <tr>

                        <th class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"  >
                          Matière premiere
                        </th>
                        <th class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"  >
                         Fournisseur
                        </th>
                        <th class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"  >
                         Délai de Livraison
                        </th>
                        <th class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"  >
                         Quantité
                        </th>
                        <th class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"  >
                          Prix Unitaire
                        </th>
                        <th class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"  >
                          Prix Total
                        </th>
                        <th class="p-3 text-sm table-cell cursor-pointer text-left hover:text-vert select-none"  >
                         Action
                        </th>

                    </tr>
                </thead>
                <tbody  >
                     <tr v-for="(cmd, key) in commands" :key="key">
                        <td class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.material }}
                        </td>
                        <td class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.supplier }}
                        </td>
                        <td class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.time_to_ship }} sem
                        </td>
                        <td class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.quantity }} KG
                        </td>
                        <td class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">{{ cmd.price }} DA/KG</td>
                        <td class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.total_price }} DA
                        </td>
                        <td class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            <div
                                class="flex w-full justify-center gap-3 align-middle"
                            >
                                <button @click="editRow(key, false)" class="bg-vert rounded-3xl bg-opacity-70 text-white px-3">
                                    Modifier
                                </button>
                                <button @click="deleteRow(key)">
                                    <img class="w-10 h-10 " src="/assets/icons/trash.png" alt="">
                                </button>

                            </div>
                        </td>

                    </tr>
                </tbody>
            </table>
            <!-- <table class="min-w-max w-full table-auto">
                <thead>
                    <tr
                        class="
                            bg-gray-200
                            text-gray-600
                            uppercase
                            text-sm
                            leading-normal
                        "
                    >
                        <th class="py-3 px-6 text-left">Matière Première</th>
                        <th class="py-3 px-6 text-center">Fournisseur</th>
                        <th class="py-3 px-6 text-center">Délai Liv.</th>
                        <th class="py-3 px-6 text-left">Qt.</th>
                        <th class="py-3 px-6 text-center">Prix Unitaire</th>
                        <th class="py-3 px-6 text-center">Prix Total</th>
                        <th class="py-3 px-6 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <tr v-for="(cmd, key) in commands" :key="key">
                        <td class=class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.material }}
                        </td>
                        <td class="class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.supplier }}
                        </td>
                        <td class="class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.time_to_ship }} sem
                        </td>
                        <td class="class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.quantity }} KG
                        </td>
                        <td class="class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">{{ cmd.price }} DA/KG</td>
                        <td class="class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            {{ cmd.total_price }} DA
                        </td>
                        <td class="class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static">
                            <div
                                class="flex w-full justify-center items-center"
                            >
                                <button @click="editRow(key, false)">
                                    Modifier
                                </button>
                                <button @click="deleteRow(key)">
                                    <i
                                        class="
                                            mx-auto
                                            fa fa-trash
                                            text-red-500 text-xl
                                        "
                                    ></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table> -->
            <div
                class="flex w-full justify-center items-center">
                <button
                    @click="commandModal()"
                    class="
                        bg-vert
                        bg-opacity-70
                        text-white
                        my-3
                        rounded-3xl
                        w-34
                        h-10
                        px-3
                        py-2
                    "
                >
                    Ajouter une ligne
                </button>
            </div>
            <div
                v-if="commands.length > 0"
                class="flex w-full justify-center items-center"
            >
                <button
                    @click="sendCommand"
                    class="text-white my-3  w-34 h-10 px-3 py-2 rounded-full"
                    v-bind:class="{
                        'bg-gray-500': this.command_sent == true,
                        'bg-vN': this.command_sent == false,
                    }"
                    :disabled="this.command_sent == true"
                >
                    Envoyer la commande
                </button>
            </div>
        </div>


      <Modal v-if="show_add_modal">
          <template v-slot:content>
             <div class="flex flex-col">
                <h1 class="text-vert text-center text-2xl">Ajouter une nouvelle commande</h1>
                <div class="flex flex-row my-4 px-6 py-4 text-vN">
                  <div class="w-2/5 flex flex-col ">
                   <h1 class="font-semibold">Matière</h1>
                    <select
                        v-if="materials != null"
                        v-model="commandItem['material']"
                        class=" rounded-md w-auto border-gray "

                    >
                        <option
                            :value="mp.name"
                            :key="mp.name"
                            v-for="mp in materials"
                        >
                            {{ mp.name }}
                        </option>
                    </select>
                    <select v-else>

                    </select>
                   <h1 class="font-semibold mt-4">Fournisseur :</h1>
                   <select
                        v-if="suppliers != null"
                        v-model="commandItem['supplier']"
                        class=" rounded-md border-gray"

                    >
                        <option v-for="supp in suppliers" :key="supp.id" :value="supp.name">
                            {{ supp.name }}
                        </option>
                    </select>
                    <select v-else>

                    </select>
                    <h1 class="font-semibold mt-4">Quantité :</h1>
                    <input
                        class="rounded-md border-gray"
                        type="number"
                        min="1"
                        placeholder="Quantité en unité"
                        v-model="commandItem.quantity"
                    />
                  </div>

                  <div class="w-1/5"></div>
                  <div >
                    <h1 class="font-semibold mt-4">Prix Unitaire :</h1>
                    <p class="rounded-md px-3 py-1" style="border : 1px solid;  border-color: rgba(128, 122, 122)">{{materialPrice}}</p>

                    <h1 class="font-semibold mt-3">Prix Total :</h1>
                     <p class="rounded-md px-3 py-1" style="border : 1px solid;  border-color: rgba(128, 122, 122)">{{totalPrice}}</p>
                     <h1 class="font-semibold mt-3">Délai de Livraison</h1>
                     <p class="rounded-md  px-3 py-1" style="border : 1px solid;  border-color: rgba(128, 122, 122)">{{supplierDelay ? supplierDelay : 0}}</p>

                  </div>
              </div>

              <div v-if="commandDisabled" class="text-center">
                        <p class="font-bold text-red-700">
                            Matière première indisponnible ou informations entrées invalides.
                        </p>
              </div>

              <div class="flex gap-4 justify-end mr-5">
                <button
                        @click="editing_command_id == null ? addRow() : editRow(editing_command_id, true)"
                        v-if="supp_raw_mat_updated"
                        :disabled="commandDisabled"
                        class=" py-3 px-3 text-white rounded-md font-semibold"
                        v-bind:class="{
                            'text-vN text-opacity-20': commandDisabled,
                            'text-vN hover:bg-gray-200': !commandDisabled,
                        }"
                    >
                        Ajouter
                    </button>
                    <button
                        @click="
                            editing_command_id = null;
                            show_add_modal = false;"
                        class=" py-3 px-3 text-vN font-semibold text-opacity-80 hover:bg-gray-200 rounded-md"
                    >
                        Fermer
                    </button>
              </div>
              </div>


          </template>

      </Modal>
    </div>
</template>

<script type="text/javascript">
import CommandItem from "./CommandItem";
import Modal from "../../Modal";
export default {
    name: "CommandMaker",
    components: { CommandItem, Modal },
    data() {
        return {
            num_commands: 0,

            show_success: false,
            show_error: false,
            command_sent: false,

            message: "",

            show_add_modal: false,
            editing_command_id: null,

            commandItem: {
                material: "",
                supplier: "",
                price: null,
                quantity: 1,
                total_price: null,
                time_to_ship: 0,
            },
            commands: [],
            filtered_materials: [],

            materials: null,
            suppliers: null,

            supp_raw_mat_updated: false,
        };
    },
    props: ["user", "caisse"],
    computed: {
        supplierDelay() {
            if (this.commandItem.supplier != "" && this.commandItem.material != "") {

                let material = this.materials.find(
                    (item) => this.commandItem.material == item.name
                );

                let supplier = this.suppliers.find(
                    (item) => this.commandItem.supplier == item.name
                );

                let supp_raw_mat = supplier.raw_materials.find(
                    (item) => item.id == material.id
                );

                if (supp_raw_mat == undefined) {
                    return "";
                }
                else {
                    supp_raw_mat = supp_raw_mat.pivot;
                }

                this.commandItem.time_to_ship = supp_raw_mat.time_to_deliver;
                return supp_raw_mat.time_to_deliver + " sem";
            }

            else {
                return ""
            }
        },
        materialPrice() {
            if (
                this.commandItem.material != "" &&
                this.commandItem.supplier != ""
            ) {
                let material = this.materials.find(
                    (item) => this.commandItem.material == item.name
                );

                let supplier = this.suppliers.find(
                    (item) => this.commandItem.supplier == item.name
                );

                let supp_raw_mat = supplier.raw_materials.find(
                    (item) => item.id == material.id
                );

                if (supp_raw_mat == undefined) {
                    return 0;
                }
                else {
                    supp_raw_mat = supp_raw_mat.pivot;
                }

                return Math.round(material.price * supp_raw_mat.price_factor);
            } else {
                return 0;
            }
        },
        totalPrice() {
            if (this.materialPrice != null) {
                return (
                    Math.round(
                        this.materialPrice * this.commandItem.quantity * 100
                    ) / 100
                );
            } else {
                return 0;
            }
        },
        commandDisabled() {
            if (
                this.commandItem.material == "" ||
                this.commandItem.supplier == ""
            ) {
                return true;
            }

            if (this.commandItem.quantity <= 0) {
                return true;
            }

            let material = this.materials.find(
                (item) => this.commandItem.material == item.name
            );

            let supplier = this.suppliers.find(
                (item) => this.commandItem.supplier == item.name
            );

            let supp_raw_mat = supplier.raw_materials.find(
                (item) => item.id == material.id
            );

            if (supp_raw_mat == undefined) {
                return true;
            }
            else if (!supp_raw_mat.pivot.is_available) {
                return true;
            }

            return false;
        },
    },
    methods: {
        commandModal() {
            this.commandItem.material = this.materials == null ? "" : this.materials.length > 0 ? this.materials[0].name : "";
            this.commandItem.supplier = this.suppliers == null ? "" : this.suppliers.length > 0 ? this.suppliers[0].name : "";
            this.commandItem.quantity = 1;

            this.show_add_modal = true;
            this.getSuppRawMat(true);
        },

        addRow() {
            let command = {
                material: this.commandItem.material,
                supplier: this.commandItem.supplier,
                quantity: this.commandItem.quantity,
                time_to_ship: this.commandItem.time_to_ship,
                price: this.materialPrice,
                total_price: this.totalPrice,
                item_id: this.num_commands,
            };

            let cmd_id = this.commands.findIndex(
                (item) => item.material == command.material && item.supplier == command.supplier
            );

            if (cmd_id == -1) {
                this.commands.push(command);
                this.num_commands += 1;
            }
            else {
                this.commands[cmd_id].quantity = parseInt(this.commands[cmd_id].quantity) + parseInt(command.quantity);
                this.commands[cmd_id].total_price = parseInt(this.commands[cmd_id].total_price) + parseInt(command.total_price);
            }

            this.show_add_modal = false;
        },

        sendCommand() {
            this.show_error = false;
            this.show_success = false;
            this.command_sent = true;
            var total = 0;
            this.commands.forEach((item) => {
                total += item.total_price;
            });
            if (total > this.caisse) {
                this.show_error = true;
                this.message =
                    "Vos disponibilités ne suffisent pas pour payer cette commande";
                return "";
            }
            axios
                .post("/api/command/create", {
                    commands: this.commands,
                    entreprise_id: this.user.id,
                })
                .then((resp) => {
                    this.command_sent = false;
                    this.commands = [];

                    if (resp.data.success) {
                        this.show_success = true;
                        this.show_error = false;
                    } else {
                        this.show_success = false;
                        this.show_error = true;
                    }

                    this.message = resp.data.message;
                })
                .catch((e) => {
                    this.command_sent = false;
                    this.commands = [];

                    this.show_error = true;
                    this.message = "Une erreur s'est produite";
                });
        },

        deleteRow(index) {
            this.commands.splice(index, 1);
        },

        editRow(index, save=false) {
            if (!save) {
                this.commandItem.material = this.commands[index].material;
                this.commandItem.supplier = this.commands[index].supplier;
                this.commandItem.quantity = this.commands[index].quantity;

                this.editing_command_id = index;
                this.show_add_modal = true;
            }
            else {
                let command = {
                    material: this.commandItem.material,
                    supplier: this.commandItem.supplier,
                    quantity: this.commandItem.quantity,
                    time_to_ship: this.commandItem.time_to_ship,
                    price: this.materialPrice,
                    total_price: this.totalPrice,
                    item_id: this.commands[index].num_commands,
                };
                this.commands[index] = command;

                this.editing_command_id = null;
                this.show_add_modal = false;
            }
        },

        getSuppRawMat() {
            this.supp_raw_mat_updated = false;
            axios
            .get("/api/supp_raw_mats", {
                params: {
                },
            })
            .then((resp) => {
                this.materials = resp.data["materials"];
                this.suppliers = resp.data["suppliers"];

                this.supp_raw_mat_updated = true;

                if (this.show_add_modal) {
                    if (this.commandItem.material == "") {
                        this.commandItem.material = this.materials.length > 0 ? this.materials[0].name : "";
                    }
                    if (this.commandItem.supplier == "") {
                        this.commandItem.supplier = this.suppliers.length > 0 ? this.suppliers[0].name : "";
                    }
                }
            });
        },
    },
    created() {
        this.getSuppRawMat();
    },
    mounted() {
        window.Echo.channel("entreprise_" + this.user.id)
            .listen("NewNotification", (e) => {
                if (e.notification.type == "SupplierUpdate") {
                    this.getSuppRawMat();
                    this.$forceUpdate();
                }
                if (e.notification.type == "RawMatUpdate") {
                    this.getSuppRawMat();
                    this.$forceUpdate();
                }
            });
    },
};
</script>
