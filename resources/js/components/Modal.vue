<template>
    <div  class="fixed z-1200 inset-0">
    <div   class="flex  justify-center ">
      
    <div  class=" inset-0 transition-opacity" aria-hidden="true">
      <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
    </div>
       
    <!-- This element is to trick the browser into centering the modal contents. -->
    <span class="" aria-hidden="true">&#8203;</span>
    <transition
      enter-active-class="transition ease-out duration-300 transform"
      enter-class="opacity-0 translate-y-4 md:translate-y-0 md:scale-95"
      enter-to-class="opacity-100 translate-y-0 md:scale-100"
      leave-active-class="transition ease-in duration-200 transform"
      leave-class="opacity-100 translate-y-0 md:scale-100"
      leave-to-class="opacity-0 translate-y-4 md:translate-y-0 md:scale-95"
    >
      <div class="h-96 md:my-8  mx-0 bg-white md:rounded text-left shadow-xl transform transition-all align-bottom"
      :class="custom_css?custom_css:'w-full md:w-2/3'" 
      role="dialog" aria-modal="true" aria-labelledby="modal-headline">
          <div class=" w-full p-5">
              <slot name="content"></slot>
          </div>
      </div>
  </transition>
  </div>
</div>
</template>
<script type="text/javascript">
export default{
		name: "Modal",
    props:['custom_css'],
		data(){
			return {

			}
		},
	}
</script>