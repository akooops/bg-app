require('./bootstrap');

import Vue from "vue"

Vue.component('departmentcard', require('./components/DepartmentCard.vue').default);
Vue.component('entrepriseloanlisting', require('./components/entreprise/LoanListing.vue').default);
Vue.component('notification', require('./components/Notification.vue').default);
Vue.component('marketing', require('./components/entreprise/Marketing.vue').default);

//Banker components
Vue.component('loanlisting', require('./components/banker/LoanListing.vue').default);

const app = new Vue({
   el: '#app',
});