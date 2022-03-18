require("./bootstrap");

import Vue from "vue";
import VCalendar from "v-calendar";

axios.defaults.withCredentials = false;
let local_url = "http://10.42.0.1:8000";
let localhost = "http://localhost:8000";
axios.defaults.baseURL = localhost;

Vue.component(
    "departmentcard",
    require("./components/DepartmentCard.vue").default
);
// Departments
Vue.component(
    "approvdepartment",
    require("./components/departments/ApprovDepartment.vue").default
);
Vue.component(
    "productiondepartment",
    require("./components/departments/ProductionDepartment.vue").default
);

Vue.component(
    "commandmaker",
    require("./components/departments/ui/CommandMaker.vue").default
);
Vue.component(
    "stock",
    require("./components/departments/ui/Stock.vue").default
);
Vue.component(
    "entrepriseloanlisting",
    require("./components/entreprise/LoanListing.vue").default
);
Vue.component("notification", require("./components/Notification.vue").default);
Vue.component(
    "marketing",
    require("./components/departments/Marketing.vue").default
);

Vue.component(
    "finance",
    require("./components/departments/Finance.vue").default
);

Vue.component(
    "humanressource",
    require("./components/departments/HumanRessource.vue").default
);

//Banker components
Vue.component(
    "loanlisting",
    require("./components/banker/LoanListing.vue").default
);
// Supplier components
Vue.component(
    "allcommands",
    require("./components/supplier/AllCommands.vue").default
);
Vue.component(
    "singlecommand",
    require("./components/supplier/SingleCommand.vue").default
);

//Simulation Time
Vue.component(
    "simulationtime",
    require("./components/SimulationTime.vue").default
);

//Leaderboard
Vue.component("leaderboard", require("./components/Leaderboard.vue").default);

Vue.component(
    "disponibility",
    require("./components/Disponibility.vue").default
);

Vue.component("calendar", require("./components/Calendar.vue").default);

Vue.use(VCalendar, {
    componentPrefix: "vc", // Use <vc-calendar /> instead of <v-calendar />
});

const app = new Vue({
    el: "#app",
});
