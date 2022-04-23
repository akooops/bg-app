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

        <Modal v-if="loan_modal" class="align-center">
            <template v-slot:content>
                <div class="flex flex-col text-vN p-4">
                    <h1 class="font-semibold text-3xl text-center">
                        Demande d'endettement
                    </h1>

                    <h2 for="amount" class="font-semibold mt-5 text-xl my-1">
                        Motant à endetter
                    </h2>
                    <input
                        type="number"
                        id="amount"
                        name="amount"
                        v-model="amount"
                        class="w-1/2"
                        min="0"
                        step="1000"
                    />

                    <h2 for="deadline" class="font-semibold mt-5 text-xl my-1">
                        Durée du prêt (Semaines)
                    </h2>
                    <input
                        type="number"
                        id="deadline"
                        name="deadline"
                        v-model="deadline"
                        class="w-1/2"
                        min="0"
                    />

                    <p v-if="ratio != null">
                        Le ratio d'endettement sera de:
                        {{ ratio }}%
                    </p>

                    <div class="mt-6 flex items-center">
                        <input
                            type="checkbox"
                            @change="checkboxChanged"
                            :checked="accept"
                            class="focus:ring-gray-500 h-4 w-4 text-gray-600 border-gray-150 rounded"
                        />
                        <label class="text-yellow-500 ml-2"
                            >Je veillerai, moi le representant de l'entreprise
                            <span class="font-bold">{{ entreprise.name }}</span>
                            à honorer les termes du contrat.</label
                        >
                    </div>

                    <div class="mt-6 flex items-center">
                        <p v-if="create_message != ''" class="text-green-500">
                            {{ create_message }}
                        </p>
                        <p v-if="create_error_message != ''" class="text-red-600">
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
                </div>
            </template>
        </Modal>

        <Modal v-if="pay_loan_modal" class="align-center">
            <template v-slot:content>
                <div class="flex flex-col text-vN py-4 px-6">
                    <h1 class="font-semibold text-2xl text-vert">
                        Remboursement de detttes
                    </h1>
                    <h2 class="mt-3 font-semibold text-xl py-2">
                        Montant restant
                    </h2>
                    <p
                        class="text-yellow-600 border-2 border-gray-200 py-2 pl-2 w-max pr-6"
                    >
                        {{ parseInt(selected_loan.remaining_amount) }} DA
                    </p>

                    <label
                        for="refund_amount"
                        class="mt-3 text-xl py-2 font-semibold"
                    >
                        Montant à rembourser
                    </label>
                    <input
                        id="refund_amount"
                        type="number"
                        name="refund_amount"
                        v-model="refund_amount"
                        class="w-full rounded-sm text-vert border-gray-200"
                        :max="selected_loan.remaining_amount"
                        :min="0"
                        :step="
                            selected_loan.remaining_amount - refund_amount >=
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

                    <h2 class="font-semibold mt-3 text-xl py-2">
                        Motant restant après payment
                    </h2>
                    <p class="border-2 border-gray-200 py-2 pl-2">
                        {{ selected_loan.remaining_amount - refund_amount }} UM
                    </p>

                    <p v-if="pay_message != ''" class="text-green-500">
                        {{ pay_message }}
                    </p>
                    <p v-if="pay_error_message != ''" class="text-red-600">
                        {{ pay_error_message }}
                    </p>

                    <div class="flex flex-row mt-9 gap-2 ml-auto">
                        <button
                            class="text-lg font-semibold  px-4 py-2 rounded-xl "
                            :class="
                                can_pay
                                    ? 'hover:bg-gray-200'
                                    : 'hover:bg-white opacity-50'
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
                            class="text-lg font-semibold opacity-80 hover:bg-gray-200 px-4 py-2 rounded-xl"
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
                <h1 class="text-vN font-semibold text-2xl my-auto">
                    Liste des demandes d'endettement :
                </h1>
                <button
                    v-if="loans.length > 0"
                    class="text-vN rounded-3xl px-5 py-2 font-semibold"
                    @click="openModal"
                    style="background: linear-gradient(180deg, rgba(178, 208, 107, 0.09) 0%, rgba(178, 208, 107, 0.33) 100%);  "
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
                    class="text-vN rounded-3xl px-5 py-2 font-semibold mt-5"
                    @click="openModal"
                    style="background: linear-gradient(180deg, rgba(178, 208, 107, 0.09) 0%, rgba(178, 208, 107, 0.33) 100%);  "
                >
                    Créer votre premier endettement
                </button>
            </div>



            <div v-else class="mt-4">
               <div  class="w-full bg-transparent shadow-md rounded mt-5  overflow-y-scroll" style="height : 50vh; ">

                <table
                    class="w-full table-auto bg-white"
                >
                    <thead
                        class="sticky top-0 border-b bg-white font-semibold text-vN"
                    >
                        <tr>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            >
                                Banque
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            >
                                Montant prêté
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            >
                                Semaine du prêt
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            >
                                Semaine de remise (prévue)
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            >
                                Taux d'interets
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            >
                                Montant à rendre restant
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            >
                                Payé ?
                            </th>
                            <th
                                class="p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                            >
                                Action
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="loan in loans"
                            v-bind:key="loan.loan_id"
                            class="flex lg:table-row flex-row lg:flex-row flex-wrap lg:flex-no-wrap lg:mb-0 border-b border-gray text-vN font-light text-sm h-14"
                        >
                            <td
                                class="p-1 text-center block lg:table-cell relative lg:static"
                            >
                                B locale
                            </td>
                            <td
                                class="w-full lg:w-auto p-1 text-center  lg:table-cell relative lg:static"
                            >
                                {{ loan.amount }}
                            </td>
                            <td
                                class="w-full lg:w-auto p-1 text-center  lg:table-cell relative lg:static"
                            >
                                {{ loan.loan_creation }}
                            </td>

                            <td
                                class="w-full lg:w-auto p-1 text-center  lg:table-cell relative lg:static"
                            >
                                {{ loan.days }}
                            </td>

                            <td
                                class="w-full lg:w-auto p-1 text-center  lg:table-cell relative lg:static"
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
                                        ? 'text-green-500'
                                        : ''
                                "
                            >
                                {{ loan.payment_status == 1 ? "Payé" : "Non" }}
                            </td>
                            <td
                                class="w-full lg:w-auto p-1 text-center block lg:table-cell relative lg:static pl-4"
                            >
                                <button
                                    v-if="
                                        loan.status ==
                                        'Acceptée/Partiellement acceptée'
                                    "
                                    @click="openPayModal(loan)"
                                    class="rounded-3xl font-semibold px-3 py-2 bg-vert"
                                    :disabled="loan.payment_status == 1"
                                    :class="
                                        loan.payment_status != 1
                                            ? 'hover:bg-opacity-50'
                                            : ''
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

            let rat = Math.sqrt(x / 2) * Math.pow( t / (Math.pow(2 * x, 1.11) * 4 * 6), 0.6);

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
    watch: {},
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
        getCa() {
            axios
                .get("/api/entreprise/indicators", {
                    params: {
                        entreprise_id: this.entreprise.id,
                        indicators: ['ca'],
                    },
                })
                .then((response) => {
                    this.ca = response.data['ca'].value;
                })
        },
        openPayModal(loan) {
            this.selected_loan = loan;
            this.pay_loan_modal = true;
        },
        closePayModal() {
            this.refund_amount = 0;
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
