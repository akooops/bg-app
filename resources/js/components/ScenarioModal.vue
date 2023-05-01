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
                climat: {
                    title: "Changement climatique",  //agg
                    description: //description
                        "Cette année 2023 a été  marquée  par  un  décalage saisonnier impromptu et particulièrement dans la région  méditerranéenne où les températures moyennes sont les plus élevées, l'été est donc arrivé  assez tôt.  Ce changement soudain de température a créé plusieurs conséquences sur l’industrie du textile notamment un changement prompt de la demande des produits saisonniers  ainsi que quelques matières premières.",
                    img: "climat.jpg",  //les images
                },
                influenceur: {
                    title: "Un post dun influenceur",
                    description: //agg
                        "Place aux Marketeurs,Suite à une story faite par un personnage public en vogue ou elle divulguait les méfaits et réels  dégâts écologiques résultant de certaine mouvance de marques, une grosse vague de soutien s’est formée autour de cette cause. Comment comptez-vous faire face à cette crise ?",
                    img: "influenceur.jpg", //agg
                },
                rh: {
                    title: "Reglement RH", //agg
                    description: //agg
                        "Un nouveau règlement gouvernemental imposant aux entreprises d’utiliser des machines qui respectent quelques exigences, de ce fait les acteurs de cette industrie n’auront plus le droit d’utiliser certains types de machines non conformes à cette loi, aussi ils seront amenés à améliorer les conditions du travail afin de garder la motivation du personnel.",
                    img: "rh.jpg", //agg
                },
                turquie: {
                    title: "Tremblement de terre Turquie",
                    description:
                        "Un séisme ravageur d'une magnitude de 7,7 a frappé le sud-est de la Turquie aux premières heures du 6 février, suivi de plusieurs répliques, faisant des milliers de morts et de blessés dans la région. Ce dernier a causé des dommages aux infrastructures pouvant affecter la production et l'approvisionnement en matières premières ainsi que d’autres dommages contraignant les entreprises à adopter divers changements.",
                    img: "turquie.jpg",
                },
                guerre: {
                    title: "Les repercusions de la guerre",
                    description:
                        "La guerre en Ukraine a eu de nombreuses répercussions sur la géopolitique, tant à l'échelle régionale qu'internationale. Notamment avec l’apparition d’une nouvelle carte politique, créant un impacte sur le marché d’énergie.",
                    img: "guerre.jpg",
                },
                chine: {
                    title: "Les crises geopolitiques",
                    description:
                        "Au cours des dernières années, une crise géopolitique a éclaté dans le monde, touchant plusieurs pays et ayant un impact significatif sur le marché mondial du textile. Cette crise a commencé par une série de conflits commerciaux entre plusieurs parties prenantes dans cette industrie, cela a fait changer les prix de quelques matières premières, qui a son tour a engendré un retard dans les délais de livraison de ces derniers.",
                    img: "chine.jpg",
                },
                banque: {
                    title: "Crise banque et inflations",
                    description:
                        "Les nombreux enjeux géopolitiques ont déclenché une crise bancaire, mettant en danger la santé financière de nombreuses entreprises du secteur. Les banques ont commencé à limiter les prêts, rendant difficile l'obtention de financement pour les investissements nécessaires, de ce fait, un fort impact est apparu sur les intérêts et les taxes.",
                    img: "banque.jpg",
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
