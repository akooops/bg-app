<template>
    <div>
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

        <Modal v-if="loan_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Demande d'endettement</h3>
                <p v-if="create_message != ''" class="text-green-500">{{ create_message }}</p>
                <p v-if="create_error_message != ''" class="text-red-600">
                    {{ create_error_message }}
                </p>
                <div class="relative h-10 input-component mb-5">
                    <label
                        for="amount"
                        class="left-2 transition-all bg-white px-1"
                    >
                        Montant à endetter
                    </label>
                    <input
                        id="amount"
                        type="number"
                        name="amount"
                        v-model="amount"
                        class="h-full w-full rounded-sm"
                        min="0"
                        step="1000"
                    />

                    <label
                        for="deadline"
                        class="left-2 transition-all bg-white px-1"
                    >
                        Durée du prêt (Semaines)
                    </label>
                    <input
                        id="deadline"
                        type="number"
                        name="deadline"
                        v-model="deadline"
                        class="h-full w-full rounded-sm"
                        min="0"
                    />
                </div>
                <div class="mt-12">
                    <p v-if="ratio != null">
                        Le ratio d'endettement sera de:
                        {{
                            Math.round(ratio * 100) / 100
                        }}%
                    </p>
                    <input
                        type="checkbox"
                        @change="checkboxChanged"
                        :checked="accept"
                        class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"
                    />
                    <label
                        >Je veillerai, moi le representant de l'entreprise
                        <span class="font-bold">{{ entreprise.name }}</span> à
                        honorer les termes du contrat.</label
                    >
                </div>
                <div class="flex">
                    <button
                        class="text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"
                        :class="
                            can_create == true
                                ? 'bg-green-400 hover:bg-green-800'
                                : 'bg-red-400'
                        "
                        :disabled="!can_create"
                        @click="
                            createLoan();
                            closeModal();
                        "
                    >
                        S'endetter
                    </button>
                    <button
                        class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4"
                        @click="closeModal"
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>
        <Modal v-if="pay_loan_modal" class="align-center" custom_css="w-1/3">
            <template v-slot:content>
                <h3 class="text-2xl font-bold mb-4">Remboursement de dettes</h3>
                <p v-if="pay_message != ''" class="text-green-500">
                    {{ pay_message }}
                </p>
                <p v-if="pay_error_message != ''" class="text-red-600">
                    {{ pay_error_message }}
                </p>
                <p class="mt-1">
                    Le montant restant est de
                    <span class="text-yellow-600">
                        {{
                            selected_loan.remaining_amount
                        }}DA
                    </span>
                </p>
                <div class="relative h-10 input-component mb-5">
                    <label
                        for="refund_amount"
                        class="left-2 transition-all bg-white px-1"
                    >
                        Montant à rembourser
                    </label>
                    <input
                        id="refund_amount"
                        type="number"
                        name="refund_amount"
                        v-model="refund_amount"
                        class="h-full w-full rounded-sm"
                        :max="selected_loan.remaining_amount"
                        :min="0"
                        :step="
                            selected_loan.remaining_amount - refund_amount >= 10000 ? 10000 :
                            selected_loan.remaining_amount - refund_amount >= 1000 ? 1000 :
                            selected_loan.remaining_amount - refund_amount >= 100 ? 100 :
                            selected_loan.remaining_amount - refund_amount >= 10 ? 10 :
                            1
                        "
                    />
                </div>
                <div class="mt-12">
                    <p>
                        Le montant restant après le paiement de
                        <span class="text-green-600">{{ refund_amount }}</span>
                        est {{ selected_loan.remaining_amount - refund_amount }}
                    </p>
                </div>
                <div class="flex">
                    <button
                        class="text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"
                        :class="
                            can_pay
                                ? 'bg-green-400 hover:bg-green-800'
                                : 'bg-gray-800 '
                        "
                        :disabled="!can_pay"
                        @click="
                            payLoan();
                            closePayModal();
                        "
                    >
                        Payer
                    </button>
                    <button
                        class="bg-gray-200 active:bg-gray-600 hover:bg-gray-400 text-back px-3 py-2 rounded w-1/2 mt-4"
                        @click="closePayModal"
                    >
                        Annuler
                    </button>
                </div>
            </template>
        </Modal>
        <div v-if="loans_loaded">
            <div class="py-12">
                <div
                    class="max-w-7xl mx-auto sm:px-6 lg:px-8 bg-white overflow-hidden shadow-sm sm:rounded-lg p-6 bg-white border-b border-gray-200"
                >
                    <div v-if="loans.length == 0" class="text-center">
                        <p>
                            Il semble que vous n'aviez pas encore créer votre
                            première demande d'endettement
                        </p>
                        <button
                            class="bg-green-400 hover:bg-green-800 text-white px-3 py-2 rounded w-1/2 mt-4 mr-2"
                            @click="openModal"
                        >
                            Créer une demande d'endettement
                        </button>
                    </div>
                    <div v-else>
                        <div class="text-right mb-2">
                            <button
                                class="bg-green-400 hover:bg-green-800 text-white px-3 py-2 rounded text-right"
                                @click="openModal"
                            >
                                Créer une demande d'endettement
                            </button>
                        </div>
                        <table class="border-collapse w-full">
                            <thead>
                                <tr>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Banque
                                    </th>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Montant/ Montant accepté
                                    </th>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Date de creation
                                    </th>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Statut
                                    </th>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Taux d'interet
                                    </th>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Delai en jours
                                    </th>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Payé?
                                    </th>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Montant restant
                                    </th>
                                    <th
                                        class="p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 hidden lg:table-cell"
                                    >
                                        Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="loan in loans"
                                    v-bind:key="loan.loan_id"
                                    class="bg-white lg:hover:bg-gray-100 flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap mb-10 lg:mb-0"
                                >
                                    <td
                                        class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static"
                                    >
                                        Banque locale
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-3 font-bold text-gray-800 text-center border border-b block lg:table-cell relative lg:static"
                                    >
                                        {{ loan.amount }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static"
                                    >
                                        {{ loan.loan_creation }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-3 font-bold text-center border border-b block lg:table-cell relative lg:static"
                                        :class="
                                            loan.status == 'En attente'
                                                ? 'text-yellow-600'
                                                : loan.status == 'Rejettée'
                                                ? ' text-red-700'
                                                : 'text-green-600'
                                        "
                                    >
                                        {{ loan.status }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static"
                                    >
                                        {{ loan.ratio }} %
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static"
                                    >
                                        {{ loan.deadline }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static"
                                    >
                                        {{
                                            loan.payment_status == 1
                                                ? "Payé"
                                                : "Non"
                                        }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static"
                                    >
                                        {{ loan.remaining_amount }}
                                    </td>
                                    <td
                                        class="w-full lg:w-auto p-3 text-gray-800 text-center border border-b block lg:table-cell relative lg:static"
                                    >
                                        <button
                                            v-if="
                                                loan.status ==
                                                'Acceptée/Partiellement acceptée'
                                            "
                                            @click="openPayModal(loan)"
                                            class="rounded text-white"
                                            :class="
                                                loan.payment_status == 1
                                                    ? 'bg-gray-600'
                                                    : 'bg-green-400 hover:bg-green-800'
                                            "
                                            :disabled="loan.payment_status == 1"
                                        >
                                            Payer la dette
                                        </button>
                                        <button
                                            v-else
                                            @click="openPayModal(loan)"
                                            class="bg-gray-600 rounded text-white"
                                            :disabled="true"
                                        >
                                            Payer la dette
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div v-else>Veillez attendre svp...</div>
    </div>
</template>

<script>
import Modal from "../Modal.vue";

export default {
    props: ["entreprise"],
    components: { Modal },
    name: "EntrepriseLoanListing",
    data() {
        return {
            loans: [],
            loans_loaded: false,

            loan_modal: false,
            pay_loan_modal: false,

            amount: 0,
            deadline: 0,

            create_message: "",
            create_error_message: "",

            accept: false,
            selected_loan: null,
            refund_amount: 0,

            pay_error_message: "",
            pay_message: "",

            sent_create: false,
            sent_payment: false,

            show_success: false,
            show_error: false,

            caisse: 0,
        };
    },
    computed: {
        ratio() {
            if (this.amount == 0 || this.deadline == 0) {
                return null;
            }

            return Math.max(100 * this.deadline / (this.deadline + this.amount / 1000), 0.1);
        },

        can_create() {
            this.create_error_message = "";

            if (this.amount <= 0 && this.deadline <= 0) {
                this.create_error_message = "La somme et la durée doivent être positifs";
                return false;
            }
            else if (this.amount <= 0) {
                this.create_error_message = "La somme doit être positive";
                return false;
            }
            else if (this.deadline <= 0) {
                this.create_error_message = "La durée doit être positive";
                return false;
            }

            if (this.accept == false) {
                this.create_error_message = "Veuillez cocher la case pour accepter les termes du contrat";
                return false;
            }

            return true;
        },

        can_pay() {
            this.pay_error_message = "";

            if (this.selected_loan == null) {
                return false;
            }

            if (this.refund_amount > this.selected_loan.remaining_amount) {
                this.pay_error_message = "Le montant à rembourser doit être inferieur aux dettes restantes";
                return false;
            }
            if (this.refund_amount <= 0) {
                this.pay_error_message = "Le montant à rembourser doit être positif";
                return false;
            }
            if (this.caisse < this.refund_amount) {
                this.pay_error_message = "Vos disponibilités ne suffisent pas pour rembourser le montant saisi";
                return false;
            }

            return true;
        },
    },
    watch: {
    },
    methods: {
        getLoans() {
            axios
                .get("/api/loan/get", {
                    params: { entreprise_id: this.entreprise.id },
                })
                .then((response) => {
                    this.loans = response.data;
                    this.loans_loaded = true;
                })
                .catch(function (error) {});
        },
        openPayModal(loan) {
            this.selected_loan = loan;
            this.pay_loan_modal = true;
        },
        closePayModal() {
            this.refund_amount = 0
            this.selected_loan = null;
            this.pay_loan_modal = false;
            this.pay_error_message = "";
            this.pay_message = "";
        },
        openModal() {
            this.loan_modal = true;
        },
        closeModal() {
            this.loan_modal = false;
            this.amount = 0;
            this.deadline = 0;
            this.create_message = "";
            this.errr_messsage = "";
        },
        checkboxChanged() {
            this.accept = !this.accept;
        },
        createLoan() {
            if (this.can_create) {
                this.sent_create = true;
                axios
                    .post("/api/loan/create", {
                        entreprise_id: this.entreprise.id,
                        amount: this.amount,
                        deadline: this.deadline,
                        ratio: this.ratio,
                    })
                    .then((resp) => {
                        this.sent_create = false;

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
        payLoan() {
            if (this.can_pay) {
                this.sent_payment = true;
                axios
                    .post("/api/loan/pay", {
                        entreprise_id: this.entreprise.id,
                        loan_id: this.selected_loan.loan_id,
                        refund_amount: this.refund_amount,
                    })
                    .then((resp) => {
                        this.sent_payment = false;

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
    },
    created() {
        axios
            .get("/api/navbar", {
                params: {
                    entreprise_id: this.entreprise.id,
                    type: this.entreprise.type,
                },
            })
            .then((resp) => {
                this.caisse = resp.data["caisse"];
            });
    },
    mounted() {
        this.getLoans();
        window.Echo.channel("entreprise_" + this.entreprise.id)
            .listen("NewNotification", (e) => {
                if (e.notification.type == "LoanStatusChanged") {
                    this.getLoans();
                }
                if (e.notification.type == "LoansUpdate") {
                    this.getLoans();
                }
            })
            .listen("NavbarDataChanged", (e) => {
                this.caisse = e.caisse;
            });
    },
};
</script>

<style></style>
