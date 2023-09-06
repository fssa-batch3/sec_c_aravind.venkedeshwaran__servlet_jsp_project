const loginForm = document.getElementById("login");
const registerForm = document.getElementById("register");
const btn = document.getElementById("btn");

function register() {
  loginForm.style.left = "-400px";
  registerForm.style.left = "50px";
  btn.style.left = "110px";
}

function login() {
  loginForm.style.left = "50px";
  registerForm.style.left = "450px";
  btn.style.left = "0";
}