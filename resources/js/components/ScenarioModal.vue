<template>
    <transition name="modal">
        <div
            class="fixed z-[9999] inset-0 h-3/4 bg-opacity-50 overflow-auto rounded-2xl m-auto w-3/5 text-vN"
        >
            <!-- <div class="z-10" aria-hidden="true">
                <div class="absolute inset-0 bg-gray-100 opacity-75"></div>
            </div> -->

            <!-- This element is to trick the browser into centering the modal contents. -->

            <div
                class="relative flex gap-x-8 pr-8 items-center mx-auto my-auto bg-white rounded-2xl h-full w-full"
                style="box-shadow: 2px 6px 47px 4px rgba(0, 0, 0, 0.25)"
                role="dialog"
                aria-modal="true"
                aria-labelledby="modal-headline"
            >
                <img
                    src="/assets/news.png"
                    alt="Breaking news"
                    class="absolute top-5 left-5"
                />
                <div class="h-full w-full">
                    <img
                        :src="'/assets/events/' + currentEvent.img"
                        class="h-full w-full object-cover object-right"
                    />
                </div>
                <p class="absolute top-10 right-10 font-serif">Business Game</p>
                <div class="flex gap-8 flex-col items-start w-full">
                    <p class="text-4xl text-vert font-serif">
                        {{ currentEvent.title }}
                    </p>
                    <p class="text-lg font-semibold">
                        {{ currentEvent.description }}
                    </p>

                    <button
                        class="font-serif absolute right-10 bottom-10"
                        @click="close"
                    >
                        Skip
                    </button>
                </div>
            </div>
        </div>
    </transition>
</template>

<script type="text/javascript">
export default {
    name: "ScenarioModal",
    props: ["custom_css", "event"],
    data() {
        return {
            currentEvent: {
                title: "",
                description: "",
            },
            show_changes: false,
            events: {
                incendies: {
                    title: "Incendies",
                    description:
                        "Un incendie a eu lieu, qui a divers conséquences qui peuvent vous toucher À cet imprévu,quelle stratégie adopteriez-vous ? à noter aussi que votre entreprise sera  onfrontée à un début d’absentéisme (les  employées ont été affectées par cet incendie).",
                    img: "fires.png",
                },
                finances: {
                    title: "Loi des finances",
                    description:
                        "Le hasard fait bien les choses et une nouvelle loi de finance est apparue: un relèvement de taxes et une entrave de subventions de matières premières.  Comment allez-vous vous exempter de cette réglementation ?",
                    img: "finance.png",
                },
                cacao: {
                    title: "Crise cacao",
                    description:
                        "Une crise diplomatique vient s’emmêler,  votre premier fournisseur de matières premières en termes de Cacao Ghana décide de couper les ponts avec votre pays, l’arrêt de l’importation de Cacao s’ensuit. La production des cookies, sandwichs glacée et céréales est enrayée, par conséquent des clients de taille vous seront désavantagés. Allez-vous céder à vos concurrents une partie de l’avance que vous avez sur eux ou gardez vous votre pour chercher une alternative ?",
                    img: "cacao.png",
                },
                war_1: {
                    title: "Debut de la Guerre",
                    description:
                        "La guerre frôle les portes, une guerre aux portes de l’Europe, un manichéisme qui va vous  faire oublier le boire et le manger, vous assistez mes chers joueurs à une hausse  vertigineuse du prix de blé de sucre et d’avoine principalement, de machines, de taxes et  un déclin démesurée de la demande portée sur les produits de luxe et la vitesse de  diminution du facteur RH est à perdre haleine ! La question épineuse  est : est-ce que vous allez décider de prendre le taureau par les cornes pour en finir une  bonne fois pour toutes avec ces problèmes ou allez-vous plutôt laisser tomber cette  entreprise ?",
                    img: "war_1.png",
                },
                war_2: {
                    title: "La guerre avance ! La situation empire…",
                    description:
                        "Comment allez-vous procéder face à la hausse des prix de maintenance des machines, de la vitesse de descente du  facteur RH et des intérêts des banques qui entrent en jeu ? comment agiriez-vous et  quelle stratégie prévoyez-vous face à l’abâtardissement de la demande des glaces,  cookies et céréales ? La scène vous offre de nombreuses possibilités, et à ce stade-là vous êtes amenées à faire une  pub afin de fidéliser vos clients, votre entreprise est toujours élue par vos clients qui vous  feront remporter la partie !",
                    img: "war_2.png",
                },
                war_3: {
                    title: "Fin de la Guerre",
                    description:
                        "Place à la fin de la guerre ! Le camp de réfugiés est au centre de beaucoup de tensions, à cet effet la population fourmille et la demande sue pas mal de produits augmente à  l’identique, qu’allez-vous faire ?",
                    img: "war_3.png",
                },
            },
        };
    },
    methods: {
        close() {
            this.$emit("close");
        },
    },
    mounted() {
        this.currentEvent = this.events[this.event];
        //remove scroll bar
        document.body.style.overflow = "hidden";
    },
    beforeDestroy() {
        //remove scroll bar
        document.body.style.overflow = "auto";
    },
};
</script>

<style>
.z-index-999 {
    z-index: 9999;
}

.modal-leave-active {
    animation: closeBox 0.25s;
}

@keyframes closeBox {
    0% {
        transform: scale(1);
    }

    100% {
        transform: scale(0);
    }
}
</style>
