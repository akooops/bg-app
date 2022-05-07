<template>
    <div>
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
        <Modal v-if="loan_modal" class="align-center openmodal">
            <template v-slot:content>
                <div class="flex flex-col mx-4">
                    <h1 class="font-bold text-2xl text-vert">
                        Demande d'endettement
                    </h1>

                    <div class="flex flex-row mt-4">
                        <div class="flex flex-col w-1/2">
                            <h2
                                for="amount"
                                class="text-vN text-lg font-heading font-medium"
                            >
                                Motant à endetter
                            </h2>
                            <input
                                type="number"
                                id="amount"
                                name="amount"
                                v-model="amount"
                                class="ring-1 w-full ring-tableBorder border-0 focus-within:ring-vert"
                                min="0"
                                step="1000"
                            />
                            <h2
                                for="deadline"
                                class="text-vN text-lg font-heading font-medium mt-2"
                            >
                                Durée du prêt (Semaines)
                            </h2>
                            <input
                                type="number"
                                id="deadline"
                                name="deadline"
                                v-model="deadline"
                                class="ring-1 w-full ring-tableBorder border-0 focus-within:ring-vert"
                                min="0"
                            />

                            <p v-if="ratio != null">
                                Le ratio d'endettement sera de:
                                {{ ratio }}%
                            </p>
                        </div>
                        <img
                            src="/assets/icons/signing.png"
                            class="w-36 h-36 mx-auto"
                            alt="sdfsf"
                        />
                    </div>

                    <div class="mt-8 flex items-center rounded-md px-2 py-2">
                        <input
                            type="checkbox"
                            @change="checkboxChanged"
                            :checked="accept"
                            class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"
                        />
                        <label class="text-vN ml-2 underline"
                            >Je veillerai, moi le representant de l'entreprise
                            <span class="font-bold">{{ entreprise.name }}</span>
                            à honorer les termes du contrat.</label
                        >
                    </div>

                    <!-- <div class="mt-6 flex items-center">
                        <p v-if="create_message != ''" class="text-green-500">
                            {{ create_message }}
                        </p>
                        <p
                            v-if="create_error_message != ''"
                            class="text-red-500"
                        >
                            {{ create_error_message }}
                        </p>
                    </div> -->

                    <div class="flex flex-row mt-9 gap-5 ml-auto text-vN">
                        <button
                            class="text-vN font-normal px-3 py-2 rounded"
                            :class="
                                can_create == true
                                    ? 'hover:text-vert'
                                    : 'bg-gray-100 text-opacity-50'
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
                            class="hover:text-black text-vN text-opacity-80 px-3 py-2 rounded"
                            @click="closeModal"
                        >
                            Annuler
                        </button>
                    </div>
                </div>

                <!-- <div class="flex flex-col text-vN p-4 gap-3">
                    <div class="flex flex-col">

                    </div>
                    <div>

                    </div>
                    
                    <div>
                        <h2
                            for="amount"
                            class="text-vN text-lg font-heading font-medium"
                        >
                            Motant à endetter
                        </h2>
                        <input
                            type="number"
                            id="amount"
                            name="amount"
                            v-model="amount"
                            class="ring-1 ring-tableBorder border-0 focus-within:ring-vert w-1/3"
                            min="0"
                            step="1000"
                        />
                    </div>
                    <div>
                        <h2
                            for="deadline"
                            class="text-vN text-lg font-heading font-medium"
                        >
                            Durée du prêt (Semaines)
                        </h2>
                        <input
                            type="number"
                            id="deadline"
                            name="deadline"
                            v-model="deadline"
                            class="ring-1 ring-tableBorder border-0 focus-within:ring-vert w-1/3"
                            min="0"
                        />

                        <p v-if="ratio != null">
                            Le ratio d'endettement sera de:
                            {{ ratio }}%
                        </p>
                    </div>

                    <div class="mt-6 flex items-center">
                        <input
                            type="checkbox"
                            @change="checkboxChanged"
                            :checked="accept"
                            class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"
                        />
                        <label class="text-jaune ml-2"
                            >Je veillerai, moi le representant de l'entreprise
                            <span class="font-bold">{{ entreprise.name }}</span>
                            à honorer les termes du contrat.</label
                        >
                    </div>

                    <div class="mt-6 flex items-center">
                        <p v-if="create_message != ''" class="text-green-500">
                            {{ create_message }}
                        </p>
                        <p
                            v-if="create_error_message != ''"
                            class="text-red-500"
                        >
                            {{ create_error_message }}
                        </p>
                    </div>

                    <div class="flex flex-row mt-9 gap-5 ml-auto">
                        <button
                            class="text-lg font-semibold px-4 py-2 rounded-xl"
                            :class="
                                can_create == true
                                    ? 'hover:bg-gray-200'
                                    : 'hover:bg-white opacity-50'
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
                            class="text-lg font-semibold opacity-80 hover:bg-gray-200 px-4 py-2 rounded-xl"
                            @click="closeModal"
                        >
                            Annuler
                        </button>
                    </div>
                </div> -->
            </template>
        </Modal>

        <Modal v-if="pay_loan_modal" class="openmodal">
            <template v-slot:content>
                <div class="flex flex-col text-vN py-4 px-6 gap-6">
                    <h1
                        class="font-bold text-2xl text-vN font-heading text-center"
                    >
                        Remboursement de detttes
                    </h1>
                    <div>
                        <h2 class="text-vN text-lg font-heading font-medium">
                            Montant restant
                        </h2>
                        <p
                            class="border w-full h-10 flex items-center pl-4 border-tableBorder text-jaune"
                        >
                            {{ parseInt(selected_loan.remaining_amount) }} DA
                        </p>
                    </div>
                    <div>
                        <h2
                            for="refund_amount"
                            class="text-vN text-lg font-heading font-medium"
                        >
                            Montant à rembourser
                        </h2>
                        <input
                            id="refund_amount"
                            type="number"
                            name="refund_amount"
                            v-model="refund_amount"
                            :disabled="full"
                            class="ring-1 ring-tableBorder border-0 focus-within:ring-vert"
                            :max="selected_loan.remaining_amount"
                            :min="0"
                            :step="
                                selected_loan.remaining_amount -
                                    refund_amount >=
                                10000
                                    ? 10000
                                    : selected_loan.remaining_amount -
                                          refund_amount >=
                                      1000
                                    ? 1000
                                    : selected_loan.remaining_amount -
                                          refund_amount >=
                                      100
                                    ? 100
                                    : selected_loan.remaining_amount -
                                          refund_amount >=
                                      10
                                    ? 10
                                    : 1
                            "
                        />
                    </div>
                    <div class="flex items-center rounded-md px-2 py-2">
                        <input
                            type="checkbox"
                            @change="payFull"
                            :checked="full"
                            class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"
                        />
                        <label class="text-vN ml-2"
                            >Payer la dette en entier</label
                        >
                    </div>
                    <div>
                        <h2 class="text-vN text-lg font-heading font-medium">
                            Motant restant après payment
                        </h2>
                        <p
                            class="border w-full h-10 flex items-center pl-4 text-vert border-tableBorder"
                        >
                            {{ selected_loan.remaining_amount - refund_amount }}
                            DA
                        </p>

                        <p v-if="pay_message != ''" class="text-green-500">
                            {{ pay_message }}
                        </p>
                        <p v-if="pay_error_message != ''" class="text-red-500">
                            {{ pay_error_message }}
                        </p>
                    </div>

                    <div class="flex flex-row mt-9 gap-2 ml-auto">
                        <button
                            class="text-vN font-normal px-3 py-2 rounded"
                            :class="
                                can_pay
                                    ? 'hover:text-vert'
                                    : 'bg-gray-100 text-opacity-50'
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
                            class="hover:text-black text-vN text-opacity-80 px-3 py-2 rounded"
                            @click="closePayModal"
                        >
                            Annuler
                        </button>
                    </div>
                </div>
            </template>
        </Modal>

        <div class="w-full" v-if="loans_loaded">
            <div class="flex flex-row justify-between mt-5">
                <h1 class="text-vN font-semibold text-2xl my-auto font-heading">
                    Liste des demandes d'endettement :
                </h1>
                <button
                    v-if="loans.length > 0"
                    class="bg-gradient-to-t from-lightVert to-lighterVert hover:opacity-80 text-vN px-4 py-2 shadow-lg rounded-full text-center font-semibold"
                    @click="openModal"
                >
                    Créer une demande d'endettement
                </button>
            </div>

            <div v-if="loans.length == 0" class="text-center mt-12">
                <p>
                    Il semble que vous n'aviez pas encore créer votre première
                    demande d'endettement
                </p>
                <button
                    class="bg-gradient-to-t from-lightVert to-lighterVert hover:opacity-80 text-vN px-4 py-2 shadow-lg rounded-full text-center font-semibold mt-5"
                    @click="openModal"
                >
                    Créer votre premier endettement
                </button>
            </div>

            <div v-else class="mt-4">
                <div
                    class="w-full bg-white shadow-md rounded mt-5 overflow-y-scroll"
                    style="max-height: 60vh"
                >
                    <table class="border-collapse w-full table-auto">
                        <thead
                            class="sticky top-0 border-b bg-white font-semibold text-vN"
                        >
                            <tr>
                                <th class="p-3 text-sm table-cell select-none">
                                    Banque
                                </th>
                                <th
                                    class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                    @click="sort('amount')"
                                >
                                    Montant prêté
                                </th>
                                <th
                                    class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                    @click="sort('loan_creation')"
                                >
                                    Semaine du prêt
                                </th>
                                <th
                                    class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                    @click="sort('days')"
                                >
                                    Semaine de remise (prévue)
                                </th>
                                <th
                                    class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                    @click="sort('ratio')"
                                >
                                    Taux d'interets
                                </th>
                                <th
                                    class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                    @click="sort('remaining_amount')"
                                >
                                    Montant à rendre restant
                                </th>
                                <th
                                    class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                                    @click="sort('payment_status')"
                                >
                                    Payé ?
                                </th>
                                <th class="p-3 text-sm table-cell select-none">
                                    Action
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr
                                v-for="loan in loans"
                                v-bind:key="loan.loan_id"
                                class="bg-white flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-gray text-vN font-light text-sm h-14"
                            >
                                <td
                                    class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                >
                                    B locale
                                </td>
                                <td
                                    class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                >
                                    {{ loan.amount }}
                                </td>
                                <td
                                    class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                >
                                    {{ loan.loan_creation }}
                                </td>

                                <td
                                    class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                >
                                    {{ loan.days }}
                                </td>

                                <td
                                    class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                >
                                    {{ loan.ratio ? loan.ratio : "0" }} %
                                </td>

                                <td
                                    class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                >
                                    {{ parseInt(loan.remaining_amount) }}
                                </td>
                                <td
                                    class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                    :class="
                                        loan.payment_status == 1
                                            ? 'text-vert'
                                            : 'text-vN'
                                    "
                                >
                                    {{
                                        loan.payment_status == 1
                                            ? "Payé"
                                            : "Non"
                                    }}
                                </td>
                                <td
                                    class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
                                >
                                    <button
                                        v-if="
                                            loan.status ==
                                            'Acceptée/Partiellement acceptée'
                                        "
                                        @click="openPayModal(loan)"
                                        class="rounded-3xl font-semibold px-3 py-2 text-white"
                                        :disabled="loan.payment_status == 1"
                                        :class="
                                            loan.payment_status != 1
                                                ? 'bg-vert hover:bg-opacity-50'
                                                : 'bg-vN bg-opacity-70'
                                        "
                                    >
                                        {{
                                            loan.payment_status == 1
                                                ? "Compte reglé"
                                                : "Payer la dette"
                                        }}
                                    </button>

                                    <button
                                        v-else
                                        @click="openPayModal(loan)"
                                        class="bg-gray-300 font-semibold text-vN rounded-3xl px-3 py-2"
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
        <div v-else class="flex flex-col items-center mt-16">
            <img class="w-16 h-16 load" src="/assets/logo/bg_logo.svg" alt="" />
            <div class="text-vN pt-2 font-semibold">
                Veuillez attendre svp...
            </div>
        </div>
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
            full: false,
            loans: [],
            loans_loaded: false,

            loan_modal: false,
            pay_loan_modal: false,

            amount: 0,
            deadline: 0,

            create_message: "",
            create_error_message: "",

            accept: false,
            selected_loan: {
                remaining_amount: 0,
            },
            refund_amount: 0,

            pay_error_message: "",
            pay_message: "",

            sent_create: false,
            sent_payment: false,

            show_success: false,
            show_error: false,

            caisse: 0,
            ca: 0,
        };
    },
    computed: {
        ratio() {
            if (this.amount == 0 || this.deadline == 0) {
                return null;
            }

            let x = this.amount / this.ca;
            let t = this.deadline;

            let rat =
                Math.sqrt(x / 2) *
                Math.pow(t / (Math.pow(2 * x, 1.11) * 4 * 6), 0.6);

            return Math.round(rat * 1000) / 100;
        },

        can_create() {
            this.create_error_message = "";

            if (this.amount <= 0 && this.deadline <= 0) {
                this.create_error_message =
                    "La somme et la durée doivent être positifs";
                return false;
            } else if (this.amount <= 0) {
                this.create_error_message = "La somme doit être positive";
                return false;
            } else if (this.deadline <= 0) {
                this.create_error_message = "La durée doit être positive";
                return false;
            }

            if (this.accept == false) {
                this.create_error_message =
                    "Veuillez cocher la case pour accepter les termes du contrat";
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
                this.pay_error_message =
                    "Le montant à rembourser doit être inferieur aux dettes restantes";
                return false;
            }
            if (this.refund_amount <= 0) {
                this.pay_error_message =
                    "Le montant à rembourser doit être positif";
                return false;
            }
            if (this.caisse < this.refund_amount) {
                this.pay_error_message =
                    "Vos disponibilités ne suffisent pas pour rembourser le montant saisi";
                return false;
            }

            return true;
        },
    },
    watch: {
        refund_amount: function (n) {
            if (n > this.selected_loan.remaining_amount) {
                this.refund_amount = this.selected_loan.remaining_amount;
                this.full = true;
            }
        },
        amount: function (n) {
            if (n < 0) {
                this.amount = 0;
            }
        },
        deadline: function (n) {
            if (n < 0) {
                this.deadline = 0;
            }
        },
    },
    methods: {
        payFull() {
            this.full = !this.full;
            this.refund_amount = this.selected_loan.remaining_amount;
        },
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
        getCa() {
            axios
                .get("/api/entreprise/indicators", {
                    params: {
                        entreprise_id: this.entreprise.id,
                        indicators: ["ca"],
                    },
                })
                .then((response) => {
                    this.ca = response.data["ca"].value;
                });
        },
        openPayModal(loan) {
            this.selected_loan = loan;
            this.pay_loan_modal = true;
        },
        closePayModal() {
            this.refund_amount = 0;
            this.selected_loan = {};
            this.pay_loan_modal = false;
            this.pay_error_message = "";
            this.pay_message = "";
            this.full = false;
        },
        openModal() {
            this.loan_modal = true;
            this.full = false;
        },
        closeModal() {
            this.loan_modal = false;
            this.amount = 0;
            this.deadline = 0;
            this.create_message = "";
            this.errr_messsage = "";
            this.full = false;
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
            this.full = false;
        },
        sort(key) {
            this.reverse = !this.reverse;
            this.loans.sort((a, b) => {
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

        this.getCa();
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
                if (e.notification.type == "AdminNotif") {
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
