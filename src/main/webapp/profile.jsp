<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@ page import="com.fssa.freshtime.models.*"%>
<%@ page import="org.json.JSONString"%>
<%@ page import="java.util.*"%>
<%@ page import="com.fssa.freshtime.services.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>


<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- google sign in meta tag -->

<title>Freshtime | Profile</title>

<link rel="stylesheet" href="assets/css/profile.css">
<link rel="stylesheet" href="assets/css/sidebar.css">


<!-- adding favicon -->
<link rel="icon" type="image/x-icon" sizes="16x16 32x32"
	href="../assets/Images/favicon.png">

<!-- Ubuntu Font Link -->
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
<script src="https://kit.fontawesome.com/ee40c53027.js"
	crossorigin="anonymous" integrity="">
	
</script>

<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css'
	rel='stylesheet'>
</head>

<link rel="stylesheet" href="assets/css/notify.css">
<script
	src="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.js">
</script>
<body>
	<div class="main">
		<!--The Total Page starts-->
		<!-- profile starts -->
		<div class="profile">

			<!-- Adding Task Alert -->
			<jsp:include page="alert.jsp"></jsp:include>

			<jsp:include page="sidebar.jsp"></jsp:include>

			<!-- profile left starts -->
			<div class="profile-left">

				<!-- profile card starts -->
				<div class="profile-card">
					<img src="assets/images/profile.jpg" alt="profile" id="profilePic">
					<h2>Profile:</h2>

					<form method="post" id="profileform">

						<%
						UserService userService = new UserService();
						User user = (User) session.getAttribute("user");
						User currentUser = userService.getUserByEmail(user.getEmailId());
						%>

						<label for="name"> User Name: 
							<input type="text" id="name"
								placeholder="Name" name="username"
								value="<%=(currentUser != null) ? currentUser.getUserName() : ""%>"
								disabled> 
								<span id="edit" onclick="enableEdit()">Edit</span>
								<span id="saveUserName" onclick="setFormAction('changename')">Save</span>
						</label>
						
						<br>

						<label> Email Id: 
							<input type="email" id="email" name="userEmail"
							placeholder="Email"
							value="<%=(currentUser != null) ? currentUser.getEmailId() : ""%>"
							disabled> 
						</label>
						
						<br>
							
						<label for="password"> Password: 
							<input placeholder="Old Password" id="oldpass" required="required">	
							<input placeholder="New Password" id="newpass" required="required">		
							<span id="changepass" onclick="revealNewPassInput()">Change Password</span>
							<button id="changebtn" onclick="setFormAction('changepass')">Change</button>
						</label>

					</form>

				</div>
				<!-- profile card ends -->
			</div>
			<!-- profile left ends -->
			
			
			<%
				int totalTask = (int) request.getAttribute("totalTask");
				int todoTask = (int) request.getAttribute("todoTask");
				int inprogressTask = (int) request.getAttribute("inprogressTask");
				int completedTask = (int) request.getAttribute("completedTask");
				int overdueTask = (int) request.getAttribute("overdueTask");
				
				int todoTaskPercent = (int)((double)todoTask / totalTask * 100);
				int inprogressTaskPercent = (int)((double)inprogressTask/totalTask *100);
				int completedTaskPercent = (int)((double)completedTask/totalTask *100);
				int overdueTaskPercent = (int)((double)overdueTask/totalTask *100);
			%>
			
			<div class="profile-right">


				<div class="personality">
					<h2>Task Overview:</h2>
					<div class="tag">
						<p>To Do Task</p>
					</div>
					<progress id="progress" value="<%= todoTaskPercent %>" max="100"><%= todoTaskPercent %>%</progress>					<div class="tag">
						<p>In Progress</p>
					</div>
					<progress id="progress" value="<%= inprogressTaskPercent %>" max="100"><%= inprogressTaskPercent %>%</progress>
					<div class="tag">
						<p>Completed</p>
					</div>
					<progress id="progress" value="<%= completedTaskPercent %>" max="100"><%= completedTaskPercent %>%</progress>
					<div class="tag">
						<p>Overdue</p>
					</div>
					<progress id="progress" value="<%= overdueTaskPercent %>" max="100"><%= overdueTaskPercent %>%</progress>
				</div>
				<div class="progress">
					<h3>Acheived Task</h3>
					<div class="achieved">
						<p>
							All Time <br> <%=totalTask%> Task
						</p>
						<p>
							This Week <br> 1 Task
						</p>
						<p>
							Today <br> 1 Task
						</p>
					</div>
				</div>
			</div>
		</div>
		<!-- profile ends -->
	</div>

	<script src="assets/js/profile.js"></script>
</body>
<script>

let usernameInput = document.getElementById("name");
let newpassElement = document.getElementById("newpass");
let oldpassElement = document.getElementById("oldpass");
let changepassElement = document.getElementById("changepass");
let changebtn = document.getElementById("changebtn");
let editspan = document.getElementById("edit");


function revealNewPassInput() {
    newpassElement.style.display = "block";
    oldpassElement.style.display = "block";
    changebtn.style.display = "block";
    changepassElement.style.display = "none"; 
};

	
	function enableEdit() {
		usernameInput.disabled = false;
		editspan.style.display = "none";
		document.getElementById("saveUserName").style.display = "block";
	}

	function setFormAction(action) {
		var form = document.getElementById("profileform");

		if (action === 'changename') {
			form.action = `UpdateProfileServlet?action=changename&username=${usernameInput.value}`;
		} 
		if (action === 'changepass') {
			form.action = `UpdateProfileServlet?action=changepass&oldpass=${oldpassElement.value}&newpass=${newpassElement.value}`;
		} 

		// Submit the form
		form.submit();
	}

	function logout() {
		window.location.href = "index.jsp";
	}
	


	
</script>
</html>