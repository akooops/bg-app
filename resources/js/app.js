require('./bootstrap');

import Vue from "vue"

Vue.component('departmentcard', require('./components/DepartmentCard.vue').default);

const app = new Vue({
   el: '#app',
});