<template>
    <transition name="modal">
        <div
            class="fixed z-50 inset-0 h-full bg-opacity-50 overflow-auto rounded-sm m-auto w-screen"
        >
            <div class="flex h-full">
                <!-- <div class="z-10" aria-hidden="true">
                <div class="absolute inset-0 bg-gray-100 opacity-75"></div>
            </div> -->

                <!-- This element is to trick the browser into centering the modal contents. -->

                <div
                    class="flex px-4 py-6 mx-auto my-auto bg-white rounded-md"
                    v-bind:class="description ? 'w-1/2' : 'w-fit'"
                    style="box-shadow: 2px 6px 47px 4px rgba(0, 0, 0, 0.25)"
                    role="dialog"
                    aria-modal="true"
                    aria-labelledby="modal-headline"
                >
                    <slot name="content"></slot>
                </div>
            </div>
        </div>
    </transition>
</template>

<script type="text/javascript">
export default {
    name: "Modal",
    props: ["custom_css", "description"],
    data() {
        return {};
    },
    // mounted() {
    //     //remove scroll bar
    //     document.body.style.overflow = "hidden";
    // },
    // beforeDestroy() {
    //     //remove scroll bar
    //     document.body.style.overflow = "auto";
    // },
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
