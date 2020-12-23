
let name_field = document.getElementById("name");
let hidden_name = document.getElementById("hidden_name");
let hidden_name_2 = document.getElementById("hidden_name_2");
name_field.onchange = (focus) => {
  hidden_name.value = focus.target.value;
  hidden_name_2.value = focus.target.value;
}
let password = document.getElementById('password');
let hidden_password = document.getElementById('hidden_password');
password.onchange = (focus) => {
  hidden_password.value = focus.target.value;
}
let password_confirmation = document.getElementById('password_confirmation');
let hidden_password_confirmation = document.getElementById('hidden_password_confirmation');
password_confirmation.onchange = (focus) => {
  hidden_password_confirmation.value = focus.target.value;
}
let current_password = document.getElementById('current_password');
let hidden_current_password= document.getElementById('hidden_current_password');
current_password.onchange = (focus) => {
  hidden_current_password.value = focus.target.value;
}
current_password.onload = (focus) => {
  hidden_current_password.value = focus.target.value;
}
name_field.onkeypress = (e) => {
  if (e.keyCode === 13) e.preventDefault();
}
hidden_current_password.value = current_password.value;


import Vue from 'vue'
import UserEdit from '../../components/users/edit.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(UserEdit)
  }).$mount()
  document.body.appendChild(app.$el)
  console.log(UserEdit)

  console.log(app)
  console.log(app.$el)
})