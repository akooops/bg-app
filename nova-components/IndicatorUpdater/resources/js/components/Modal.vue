<template>
    <div
        class="fixed z-50 inset-0 h-full bg-gray-50 bg-opacity-50 overflow-auto rounded-sm m-auto w-full"
        v-bind:class="description ? 'w-1/2' : 'w-full'"
    >
        <div class="flex h-full">
            <!-- <div class="z-10" aria-hidden="true">
                <div class="absolute inset-0 bg-gray-100 opacity-75"></div>
            </div> -->

            <!-- This element is to trick the browser into centering the modal contents. -->

            <transition
                enter-active-class="transition ease-out duration-300 transform"
                enter-class="opacity-0 translate-y-4 md:translate-y-0 md:scale-95"
                enter-to-class="opacity-100 translate-y-0 md:scale-100"
                leave-active-class="transition ease-in duration-200 transform"
                leave-class="opacity-100 translate-y-0 md:scale-100"
                leave-to-class="opacity-0 translate-y-4 md:translate-y-0 md:scale-95"
            >
                <div
                    class="flex px-4 py-6 mx-auto my-auto bg-[#FAEEDE] rounded-md " style="box-shadow : 2px 6px 47px 4px rgba(0,0,0,0.25)
"
                    role="dialog"
                    aria-modal="true"
                    aria-labelledby="modal-headline"
                >
                    <slot name="content"></slot>
                </div>
            </transition>
        </div>
    </div>
</template>

<script type="text/javascript">
export default {
    name: "Modal",
    props: ["custom_css", "description"],
    data() {
        return {};
    },
    mounted() {
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
</style>
