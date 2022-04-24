<template>
    <tr class="h-24" v-if="show">

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.code }}
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            {{ item.name }}
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <input
                v-if="item.type == 'float'"
                :type="'number'"
                v-model.number="value"
                :step="0.01"
                class="w-4/5 text-center"
            >

            <input
                v-else-if="item.type == 'int'"
                :type="'number'"
                v-model.number="value"
                :step="1"
                class="w-4/5 text-center"
            >

            <input
                v-else-if="item.type == 'bool'"
                :type="'number'"
                v-model.number="value"
                :step="1"
                min="0"
                max="1"
                class="w-4/5 text-center"
            >
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <button
                @click="show_apply_modal = true;"
                class="p-1 px-2 rounded-full text-black"
                :class="
                    new_changes ? 'bg-green-600' : sending_changes ? 'bg-blue-200' : 'bg-gray-400'
                "
                :disabled="!new_changes || sending_changes"
            >
                Appliquer changement
            </button>
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <button
                @click="show_cancel_modal = true;"
                class="p-1 px-2 rounded-full text-black"
                :class="
                    new_changes ? 'bg-red-600' : 'bg-gray-400'
                "
                :disabled="!new_changes || sending_changes"
            >
                Annuler changement
            </button>
        </td>

        <td
            class="lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
        >
            <button
                @click="show_reset_modal = true;"
                class="p-1 px-2 rounded-full text-white"
                :class="
                    sending_changes ? 'bg-blue-200' : 'bg-red-800'
                "
            >
                Réinitialiser paramètre
            </button>
        </td>

        <Modal v-if="show_apply_modal" class="pt-44">
            <template v-slot:content>
                <div class="flex flex-col gap-2">
                    <p>Appliquer les changements ?</p>
                    <div class="flex gap-5 justify-center">
                        <button @click="apply_changes" class="bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white">
                            Confirmer
                        </button>
                        <button @click="show_apply_modal = false;" class="bg-white border-vert border-2 rounded-md px-3 py-1 text-black">
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>

        <Modal v-if="show_cancel_modal" class="pt-44">
            <template v-slot:content>
                <div class="flex flex-col gap-2">
                    <p>Annuler les changements ?</p>
                    <div class="flex gap-5 justify-center">
                        <button @click="cancel_changes" class="bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white">
                            Confirmer
                        </button>
                        <button @click="show_cancel_modal = false;" class="bg-white border-vert border-2 rounded-md px-3 py-1 text-black">
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>

        <Modal v-if="show_reset_modal" class="pt-44">
            <template v-slot:content>
                <div class="flex flex-col gap-2">
                    <p>Réinitialiser les paramètres ?</p>
                    <input type="text" placeholder="Mot de passe" v-model="password">
                    <div class="flex gap-5 justify-center">
                        <button @click="reset_params" v-if="password == correct_password" class="bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white">
                            Confirmer
                        </button>
                        <button @click="show_reset_modal = false;" class="bg-white border-vert border-2 rounded-md px-3 py-1 text-black">
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>

    </tr>
</template>

<script type="text/javascript">
import Modal from "./Modal";
export default {
    name: "StockProdItem",

    props: ["item", "show"],

    components: { Modal },

    data() {
        return {
            new_changes: false,

            sending_changes: false,

            value: this.item.value,

            show_apply_modal: false,
            show_cancel_modal: false,
            show_reset_modal: false,

            password: "",
            correct_password: "moncef_somnef_iec",
        };
    },

    methods: {
        apply_changes() {
            if (this.new_changes) {
                this.new_changes = false;
                this.sending_changes = true;

                this.item.value = this.value;

                let data = {
                    code: this.item.code,
                    value: this.value,
                };

                this.show_apply_modal = false;

                Nova.request()
                    .post("/nova-vendor/indicator-updater/set-setting", data)
                    .then((resp) => {
                        this.sending_changes = false;
                    });
            }
        },

        cancel_changes() {
            if (this.new_changes) {
                this.value = this.item.value;

                this.show_cancel_modal = false;
            }
        },

        reset_params() {
            this.new_changes = false;
            this.sending_changes = true;

            let data = {
                code: this.item.code,
            };

            this.show_reset_modal = false;

            Nova.request()
                .post("/nova-vendor/indicator-updater/reset-setting", data)
                .then((resp) => {
                    this.sending_changes = false;

                    this.$parent.getSettings();
                });
        },
    },

    watch: {
        'value': function () {
            if (this.item.type == 'float') {

            }
            else if (this.item.type == 'int') {
                this.value = Math.round(this.value);
            }
            else if (this.item.type == 'bool') {
                this.value = Math.round(this.value);
                if (this.value <= 0) {
                    this.value = 0;
                }
                else if (this.value >= 1)
                {
                    this.value = 1;
                }
            }

            if (this.value == this.item.value) {
                this.new_changes = false;
            }
            else {
                this.new_changes = true;
            }
        },

        'item': function() {
            this.value = this.item.value;
        }
    },

    mounted() {
    },
};
</script>
