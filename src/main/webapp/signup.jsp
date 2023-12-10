<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">


<!-- page title added -->
<title>FRESHTIME | Registration Form</title>

<!-- fontawesome icon link -->

<!-- linking css -->
<link rel="stylesheet" href="assets/css/signup.css">


<!-- adding favicon -->
<link rel="icon" type="image/x-icon" sizes="16x16 32x32"
	href="assets/images/favicon.png">

<!-- ubuntu font link added -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
	rel="stylesheet">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Ubuntu&display=swap');
</style>

<!-- bootstrap for adding icon  -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/ee40c53027.js" integrity=""
	crossorigin="anonymous">
		
	</script>


<link rel="stylesheet" href="assets/css/notify.css">
<script
	src="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.js">
		
	</script>

</head>

<body>


	<!-- Sign Up Alerts -->
	<%
	String success = (String) request.getAttribute("success");
	String error = (String) request.getAttribute("error");
	%>


	<%
	if (error != null) {
	%>
	<script>
		    let error = "<%=error%>";
		    Notify.error(error);
		</script>
	<%
	}
	%>

	<%
	if (success != null) {
	%>
	<script>
	    let success = "<%=success%>";
		Notify.success(success);
	</script>
	<%
	}
	%>



	<img src="assets/images/signupgif1.gif" alt="Sign up Gif"
		id="signupgif" width="600px">

	<!-- sign in form starts  -->
	<div class="form-box">

		<h1>
			Welcome to <br> <span class="title">FRESHTIME</span>
		</h1>
		<p class="tagline">Unlock Your Full Potential</p>

		<div class="button-box">
			<div id="btn"></div>
			<button type="button" class="toggle-btn" onclick="login()">Log
				In</button>
			<button type="button" class="toggle-btn" onclick="register()">Register</button>
		</div>

		<!-- Registeration form starts  -->
		<form action="<%=request.getContextPath()%>/SignUpServlet"
			method="post" id="register" class="input-group">
			<input type="name" name="username" id="name" class="input-field"
				placeholder="Name" pattern="[A-Za-z]+"
				title="Username doesn't contain spaces or number" required>
			<input type="email" name="emailId" id="email" class="input-field"
				placeholder="Email" required> <input type="password"
				name="password" id="password" class="input-field"
				placeholder="Password"
				pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-]).{8,32}$"
				title="Password Should be Atleast 8 Characters and Should Contain Atleast One Uppercase, One LowerCase, One Number and One Special Charecter"
				required> <input type="checkbox" class="check-box" required>
			<span>I agree to the terms & conditions</span>
			<button type="submit" class="submit-btn">Register</button>
		</form>

		<!-- log in form starts  -->

		<form action="<%=request.getContextPath()%>/LoginServlet"
			method="post" id="login" class="input-group">
			<input 
				type="text" 
				name="emaillogin" 
				id="emaillogin"
				class="input-field" 
				placeholder="Email"
				required
			> 
			<input
				type="password" 
				name="passwordlogin" 
				id="passwordlogin"
				class="input-field" 
				placeholder="Password" 
				required
			> 
				
			<input
				type="checkbox" 
				class="check-box"
			> 
			<span>
				Remember
				Password
			</span>
			<button type="submit" class="submit-btn">Log In</button>
		</form>

		<!-- sign in form ends -->

		<p class="or">---(or)---</p>

		<div class="other-signin">
			<button id="gsign">
				<img src="assets/images/googleicon.png" alt="Google Icon"
					id="googleicon"> Sign In With Google
			</button>


		</div>
	</div>
	
	<script>
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
	</script>

</body>


</html>