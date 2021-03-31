require('./bootstrap');

import Vue from "vue"

Vue.component('departmentcard', require('./components/DepartmentCard.vue').default);
// Departments
Vue.component('approvdepartment', require('./components/departments/ApprovDepartment.vue').default);
Vue.component('productiondepartment', require('./components/departments/ProductionDepartment.vue').default);

Vue.component('commandmaker', require('./components/departments/ui/CommandMaker.vue').default);
Vue.component('stock', require('./components/departments/ui/Stock.vue').default);
Vue.component('entrepriseloanlisting', require('./components/entreprise/LoanListing.vue').default);
Vue.component('notification', require('./components/Notification.vue').default);
Vue.component('marketing', require('./components/entreprise/Marketing.vue').default);

//Banker components
Vue.component('loanlisting', require('./components/banker/LoanListing.vue').default);
// Supplier components
Vue.component('allcommands', require('./components/supplier/AllCommands.vue').default)
Vue.component('singlecommand', require('./components/supplier/SingleCommand.vue').default);
const app = new Vue({
   el: '#app',
});