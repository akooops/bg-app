<template>
<div class="bg-white flex">
    <img src="/assets/icons/warn.png" alt="" class="bg-vN rounded-xl w-11 h-11 p-2 content-start">
    <div class="flex flex-col flex-wrap px-3 w-5/6">
      
        <div class="text-base text-vN font-semibold mr-auto ">{{title}}</div>
        <div v-if="show" class="text-sm text-vN text-left " >{{text}}</div>
        <div v-if="!show" class="text-gray-400 text-sm text-left">{{timeConvert(actual_time - time)}} • production department</div>
         
    </div>
    <button @click="show = !show"    ><img src="/assets/icons/chevron-down.svg" alt="chev" class="h-4 w-4" style="transition : 0.2s" :class=" show == true ? 'rotate' : '' "></button>

    

</div>
  
</template>

<script type="text/javascript">
export default {
    name: "NotificationItem",
    props: ["title", "text", "time", "actual_time", "type"],
    data() {
        return {
             show : false,
        };
    },
    methods: {
        getHour(time) {
            return (new Date(time).getUTCHours() + "h" + new Date(time).getUTCMinutes());
        },
        
         timeConvert(temps) { 
             var num = temps;
             var hours = (num / 60);
             var rhours = Math. floor(hours); 
             var minutes = (hours - rhours) * 60; 
             var rminutes = Math. round(minutes); 
             if (rhours > 0){
                 return rhours + "h ago" 
             }
             else {
                 return rminutes + " min ago"
             }
               
             }
    },
    created() {

    },
};
</script>
