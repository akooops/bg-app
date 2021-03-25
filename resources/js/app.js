require('./bootstrap');

import Vue from "vue"

Vue.component('departmentcard', require('./components/DepartmentCard.vue').default);
Vue.component('approvdepartment', require('./components/departments/ApprovDepartment.vue').default);

const app = new Vue({
   el: '#app',
});