// index.htmlから呼ばれるjavascript

require("@rails/ujs").start();
require("@rails/activestorage").start();
require("channels");

import Vue from "vue";
import App from "../app.vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import router from '@/router'
Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    vuetify,
    router,
    render: (h) => h(App),
  }).$mount();
  document.body.appendChild(app.$el);

  console.log(app);
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
