<template>
  <div v-if="new_notification" class="shadow-lg rounded-lg bg-white m-8 p-4 notification-box mx-16 flex">
    <i class="fas fa-info-circle mt-1 mr-3 fa-2x"></i>
    <div class="w-full"> 
        <div class="text-sm pb-2 font-bold">
          {{notification.title}}
          <span class="float-right" @click="new_notification=null">
            <svg
              class="fill-current text-gray-600"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              width="22"
              height="22"
            >
              <path
                class="heroicon-ui"
                d="M16.24 14.83a1 1 0 0 1-1.41 1.41L12 13.41l-2.83 2.83a1 1 0 0 1-1.41-1.41L10.59 12 7.76 9.17a1 1 0 0 1 1.41-1.41L12 10.59l2.83-2.83a1 1 0 0 1 1.41 1.41L13.41 12l2.83 2.83z"
              />
            </svg>
          </span>
        </div>
        <div class="text-sm text-gray-600  tracking-tight ">
          {{notification.message}}
        </div>
    </div>
  </div>
</template>

<script>
export default {
  name:'Notification',
  props:['user'],
  data(){
    return{
      notification:null,
      new_notification:false,
    }
  },
  mounted(){
    if(this.user.type=="entreprise"){
      window.Echo.channel("entreprise_"+this.user.id)
    .listen('NewNotification', (e) => {
      this.new_notification = true
      this.notification = e.notification
    })
    }
    
  }
}
</script>

<style>

</style>