require('./bootstrap');

import Vue from "vue"

Vue.component('test', require('./components/Test.vue').default);

const app = new Vue({
   el: '#app',
});