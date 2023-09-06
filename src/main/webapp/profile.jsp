<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@ page import="com.fssa.freshtime.models.User"%>
<%@ page import="org.json.JSONString"%>
<%@ page import="java.util.*"%>
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
		
			<!-- Notify Alert -->
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

			<jsp:include page="sidebar.jsp"></jsp:include>

			<!-- profile left starts -->
			<div class="profile-left">

				<!-- profile card starts -->
				<div class="profile-card">
					<img src="assets/images/profile.jpg" alt="profile" id="profilePic">
					<h2>Profile:</h2>

					<form method="post" id="profileform">

						<%
						User currentUser = (User) request.getAttribute("user");
						%>

						<label for="name"> 
						<input type="text" id="name"
							placeholder="Name" name="username"
							value="<%=(currentUser != null) ? currentUser.getUserName() : ""%>"
							disabled> 
							<span id="edit" onclick="enableEdit()">Edit</span>
						</label> 
						
						<label for="phone number"> <input type="text"
							id="phonenumber" 
							name="phonenum"
							placeholder="Phone Number"> <span
							id="edit">Edit</span>
						</label>
						
						<br> 
						
						
						<input type="email"
							id="email" 
							name="userEmail"
							placeholder="Email"
							value="<%=(currentUser != null) ? currentUser.getEmailId() : ""%>"
							disabled> 
						
						
						<label for="password"> 
						
						<input type="password"
							id="password" 
							name="userPassword"
							value="<%=(currentUser != null) ? currentUser.getPassword() : ""%>"
							placeholder="Change Password" disabled> 
							
							<span id="edit" onclick="enableEdit()">Edit</span>
						</label>


						<div class="tag-line">
							<h2>Statistics:</h2>
							<button>
								<i class="fa fa-fire" style="font-size: 18px; color: red"></i>
								&nbsp; 21 Day Streak
							</button>
							<button>
								<i class="fa fa-bolt" style="font-size: 18px; color: gold;"></i>
								1500 Total XP
							</button>
							<br>
							<button>
								<i class="fa fa-shield" style="font-size: 18px; color: gold"></i>&nbsp;
								Gold League
							</button>
							<button>
								<i class="fa fa-trophy" style="font-size: 18px; color: red"></i>&nbsp;
								5 Times in Top 3's
							</button>
						</div>

						<div class="savendel">
							<button class="save" onclick="setFormAction('update')">Save</button>
							<a class="save" href="index.jsp" style="text-decoration: none;">LogOut</a>
							<button class="save" onclick="setFormAction('delete')">Sign
								Out</button>
						</div>

					</form>

				</div>
				<!-- profile card ends -->
			</div>
			<!-- profile left ends -->
			<div class="profile-right">
				<div class="bio">
					<h3>Your Bio:</h3>
					<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
						Voluptatum dignissimos consequuntur molestias sequi obcaecati
						totam eveniet autem omnis corporis, consectetur voluptas aperiam,
						dolores cum? Itaque sequi ducimus quam veritatis sed!</p>
				</div>

				<div class="personality">
					<h2>Personality:</h2>
					<div class="tag">
						<p>Introvert</p>
						<p>Extrovert</p>
					</div>
					<progress id="progress" value="25" max="100"> 65% </progress>
					<div class="tag">
						<p>Analytical</p>
						<p>Creative</p>
					</div>
					<progress id="progress" value="80" max="100"> 65% </progress>
					<div class="tag">
						<p>Loyal</p>
						<p>Fickle</p>
					</div>
					<progress id="progress" value="50" max="100"> 65% </progress>
					<div class="tag">
						<p>Passive</p>
						<p>Active</p>
					</div>
					<progress id="progress" value="65" max="100"> 65% </progress>
				</div>
				<div class="progress">
					<h3>Acheived Task</h3>
					<div class="achieved">
						<p>
							All Time <br> 100 Task
						</p>
						<p>
							This Week <br> 10 Task
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

</html>