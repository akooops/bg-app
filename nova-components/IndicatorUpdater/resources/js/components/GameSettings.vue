<template>
    <div class="mt-5 w-4/5">
        <button
            @click="getSettings()"
            class="p-1 px-2 rounded-md text-black bg-blue-500 mb-3"
        >
            Refresh
        </button>
        <table class="border-collapse w-full table-auto">
            <thead class="sticky top-0 border-b bg-white font-semibold text-black">
                <tr>
                    <th
                        class="text-sm table-cell cursor-pointer select-none"
                    >
                        <input
                            type="text"
                            v-model="code_search"
                            placeholder="Filtrer par code"
                            class="text-center w-full bg-gray-100"
                        >
                    </th>

                    <th
                        class="text-sm table-cell cursor-pointer select-none"
                    >
                        <input
                            type="text"
                            v-model="name_search"
                            placeholder="Filtrer par nom"
                            class="text-center w-full bg-gray-100"
                        >
                    </th>

                    <th>
                    </th>

                    <th>
                    </th>

                    <th>
                    </th>

                    <th>
                    </th>
                </tr>

                <tr>
                    <th
                        class="text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Code
                    </th>

                    <th
                        class="text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Paramètre
                    </th>

                    <th
                        class="text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >
                        Valeur
                    </th>

                    <th
                        class="text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >

                        <button
                            @click="show_apply_modal = true;"
                            class="p-1 px-2 rounded-full text-black"
                            :class="
                                new_changes ? 'bg-green-600' : 'bg-gray-400'
                            "
                            :disabled="!new_changes"
                        >
                            Appliquer changements pour tous
                        </button>

                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >

                        <button
                            @click="show_cancel_modal = true;"
                            class="p-1 px-2 rounded-full text-black"
                            :class="
                                new_changes ? 'bg-red-600' : 'bg-gray-400'
                            "
                            :disabled="!new_changes"
                        >
                            Annuler changements pour tous
                        </button>

                    </th>

                    <th
                        class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                    >

                        <button
                            @click="show_reset_modal = true;"
                            class="p-1 px-2 rounded-full text-white bg-red-800"
                        >
                            Réinitialiser paramètres pour tous
                        </button>

                    </th>
                </tr>
            </thead>
            <tbody v-if="settings.length > 0">
                <tr
                    v-for="(item, key) in settings"
                    v-bind:key="key"
                    is="GameSettingsItem"
                    :item="item"
                    :show="rows[key]"
                    ref="items"
                >
                </tr>
            </tbody>
        </table>

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

    </div>
</template>

<script>
import Modal from "./Modal";
import GameSettingsItem from "./GameSettingsItem";
export default {
    name: "GameSettings",

    components: {
        Modal, GameSettingsItem
    },

    refs: ['items'],

    props: [],

    data() {
        return {
            settings: [],

            code_search: "",
            name_search: "",

            getting_settings: false,
            sending_changes: false,

            show_apply_modal: false,
            show_cancel_modal: false,
            show_reset_modal: false,

            password: "",
            correct_password: "moncef_somnef_iec",
        };
    },

    methods: {
        getSettings() {
            if (this.getting_settings) {
                return;
            }

            this.getting_settings = true;

            Nova.request()
                .get("/nova-vendor/indicator-updater/get-settings")
                .then((response) => {
                    this.settings = response.data["settings"];
                    this.getting_settings = false;
                })
                .catch(function (error) {});
        },

        apply_changes() {

            if (this.new_changes) {
                this.$refs.items.forEach(x => x.apply_changes());

                this.show_apply_modal = false;
            }

        },

        cancel_changes() {
            if (this.new_changes) {
                this.$refs.items.forEach(x => x.cancel_changes());

                this.show_cancel_modal = false;
            }
        },

        reset_params() {
            this.$refs.items.forEach(x => x.reset_params());

            this.show_reset_modal = false;

            this.getSettings();
        }
    },

    computed: {
        rows() {
            let result = [];
            if (this.code_search != "") {
                result.push(...this.settings.filter(x => x.code.toLowerCase().includes(this.code_search.toLowerCase())).map(x => x.code));
            }

            if (this.name_search != "") {
                result.push(...this.settings.filter(x => x.name.toLowerCase().includes(this.name_search.toLowerCase())).map(x => x.code));
            }

            if (this.code_search == "" && this.name_search == "") {
                result = this.settings.map(x => x.code);
            }

            result = [...new Set(result)];

            let show = this.settings.map(x => result.includes(x.code));

            return show;
        },

        new_changes() {
            if (this.$refs.items == undefined) {
                return false;
            }

            return this.$refs.items.some(x => x.new_changes == true);
        }
    },

    watch: {
        // 'settings': function() {
        // }
    },

    mounted() {
        this.getSettings();
    },

    created() {

    }
};
</script>
