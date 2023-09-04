<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@ page import="com.fssa.freshtime.models.Task"%>
<%@ page import="org.json.JSONString"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- css file linked -->
<link rel="stylesheet" href="assets/css/task.css">
<link rel="stylesheet" href="assets/css/sidebar.css">
<link rel="stylesheet" href="assets/css/calendar.css">


<!-- adding favicon and title -->
<link rel="icon" type="image/x-icon" sizes="16x16 32x32"
	href="assets/images/favicon.png">
<title>FreshTime | To Do's</title>

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
<script src="https://kit.fontawesome.com/ee40c53027.js"
	crossorigin="anonymous" integrity="">
	
</script>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">

<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css'
	rel='stylesheet'>


<link rel="stylesheet" href="assets/css/notify.css">
<script
	src="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.js">
	
</script>


</head>
<body>

<!-- Login in alert -->
	<%
	String loginSuccess = (String) request.getAttribute("loginSuccess");
	String loginError = (String) request.getAttribute("loginError");
	%>


	<%if (loginError != null) {%>
		<script>
		    let loginError = "<%=loginError%>";
		    Notify.error(loginError);
		</script>
	<%}%>

	<%if (loginSuccess != null) {%>
		<script>
	    	let loginSuccess = "<%=loginSuccess%>";
			Notify.success(loginSuccess);
		</script>
	<%}%>
	
	
<!-- Add Task Alert -->

	<%
	String addTaskSuccess = (String) request.getAttribute("addTaskSuccess");
	String addTaskError = (String) request.getAttribute("addTaskError");
	%>


	<%if (addTaskError != null) {%>
		<script>
		    let addTaskError = "<%=addTaskError%>";
		    Notify.error(addTaskError);
		</script>
	<%}%>

	<%if (addTaskSuccess != null) {%>
		<script>
	    	let addTaskSuccess = "<%=addTaskSuccess%>";
			Notify.success(addTaskSuccess);
		</script>
	<%}%>
	
<!-- Updated Task Alert -->

	<%
	String updateSuccess = (String) request.getAttribute("updateSuccess");
	String updateError = (String) request.getAttribute("updateError");
	%>


	<%if (updateError != null) {%>
		<script>
		    let updateError = "<%=updateError%>";
		    Notify.error(updateError);
		</script>
	<%}%>

	<%if (updateSuccess != null) {%>
		<script>
	    	let updateSuccess = "<%=updateSuccess%>";
			Notify.success(updateSuccess);
		</script>
	<%}%>
	
<!-- Delete Task Alert -->

	<%
	String delTaskSuccess = (String) request.getAttribute("delTaskSuccess");
	String delTaskError = (String) request.getAttribute("delTaskError");
	%>


	<%if (delTaskError != null) {%>
		<script>
		    let delTaskError = "<%=delTaskError%>";
		    Notify.error(delTaskError);
		</script>
	<%}%>

	<%if (delTaskSuccess != null) {%>
		<script>
	    	let delTaskSuccess = "<%=delTaskSuccess%>";
			Notify.success(delTaskSuccess);
		</script>
	<%}%>

	<div class="main">
		<div class="taskpage">

			<script type="text/javascript" src="assets/js/sidebar.js"></script>

			<div class="dailycol">
				<div class="dailyheader">
					<div>
						<p class="Todayschedule">Today's Schedule</p>
						<div class="datentime">
							<p id="date"></p>
							<p id="timenow"></p>
						</div>
					</div>
					<p id="addtaskplus">
						<i class="fa fa-plus"></i>
					</p>
				</div>

				<div id="tasklist">

					<%
					List<Task> listTask = (List<Task>) request.getAttribute("listTask");
					if (listTask != null) {
						for (Task task : listTask) {
					%>

					<a class="taskli"
						href="<%=request.getContextPath()%>/TaskServlet?action=edit&taskId=<%=task.getTaskId()%>">
						<label> <input type="checkbox" /> <span class="checkbox"></span>
					</label>
						<p><%=task != null ? task.getTaskName() : ""%></p>
						<p><%=task != null ? task.getPriority() : ""%></p>
						<p><%=task != null ? task.getStatus() : ""%></p>
						<p><%=task != null ? task.getDueDate() : ""%></p>

					</a>
					<%
					}
					%>
					<%
					} else {
					%>
					<p>No Task Found</p>

					<%
					}
					%>
				</div>
			</div>
			<div class="taskaddcol">
				<div class="profilesection">
					<div class="nameset">
						<p id="username">Aravind</p>
						<P id="setting">My Settings</P>
					</div>
					<img src="assets/images/profile.jpg" alt="">
				</div>
				<div class="music">
					<iframe style="border-radius: 12px"
						src="https://open.spotify.com/embed/playlist/7wvGLBPv18q23xCfUfVTDv?utm_source=generator"
						width="100%" height="100px" frameBorder="0" allowfullscreen=""
						allow="autoplay; 
                        clipboard-write; 
                        encrypted-media; 
                        fullscreen; 
                        picture-in-picture"
						loading="lazy"> </iframe>
				</div>
				<div class="calender">
					<div class="wrapper">
						<header>
							<p class="current-date"></p>
							<div class="icons">
								<span id="prev" class="material-symbols-rounded">chevron_left</span>
								<span id="next" class="material-symbols-rounded">chevron_right</span>
							</div>
						</header>
						<div class="calendar">
							<ul class="weeks">
								<li>Sun</li>
								<li>Mon</li>
								<li>Tue</li>
								<li>Wed</li>
								<li>Thu</li>
								<li>Fri</li>
								<li>Sat</li>
							</ul>
							<ul class="days"></ul>
						</div>
					</div>
				</div>
				<div class="quotes">
					<h3 id="quotenow"></h3>
					<!-- <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iste ea sint praesentium </p> -->
					<!-- <div>
                        <img src="../assets/Images/boy with mobile.png" alt="" height="150px" width="150px" id="lastimg">
                        <p><i class="fa fa-plus" id="taskaddcolplus"></i></p>
                    </div> -->
				</div>
			</div>
		</div>


		<!--  Add Task Card -->

		<div class="addtaskpopup">

			<img src="assets/images/pencilicon.png" id="editButton">
			<button type="submit" onclick="setFormAction('delete')">
				<img src="assets/images/delete.png" id="deletebtn">
			</button>

			<div class="taskheader">
				<div class="design">
					<p></p>
				</div>
				<div>
					<h3 class="taskheading">Add Habit</h3>
					<p class="taskquote">Tackle your goals in daily doses</p>
				</div>
			</div>

			<%
			Task uptTask = (Task) request.getAttribute("uptTask");
			%>
			<form id="addtaskform" method="post">

				<input type="hidden" id="taskId"
					value="<%=(uptTask != null) ? uptTask.getTaskId() : ""%>">

				<input type="text" id="taskname" name="taskname"
					value="<%=(uptTask != null) ? uptTask.getTaskName() : ""%>"
					placeholder="Add Task" required> <br> <input
					name="taskdescription" type="text" id="taskdescription"
					placeholder="Add Description"
					value="<%=(uptTask != null) ? uptTask.getDescription() : ""%>"
					required> <br> <label for="duedate" id="duedatelabel"><i
					class='far fa-calendar-check'></i> Due Date</label> <input name="duedate"
					type="date" id="duedate"
					value="<%=(uptTask != null) ? uptTask.getDueDate() : ""%>">
				<br> <label for="priority" id="prioritylabel"><i
					class="fa fa-warning"></i> Priority</label> <select name="priority"
					id="priority"
					value="<%=(uptTask != null) ? uptTask.getPriority() : ""%>">
					<option value="HIGH">High Priority</option>
					<option value="MEDIUM">Mid Priority</option>
					<option value="LESS">Less Priority</option>
				</select> <br> <label for="status" id="statuslabel"><i
					class="fa fa-warning"></i> Status</label> <select name="status" id="status"
					value="<%=(uptTask != null) ? uptTask.getStatus() : ""%>">
					<option value="NOTSTARTED">Not Started</option>
					<option value="SCHEDULED">Scheduled</option>
					<option value="INPROGRESS">In Progress</option>
					<option value="COMPLETED">Completed</option>
					<option value="OVERDUE">Overdue</option>
				</select> <br> <label for="reminder" id="reminderlabel"><i
					class='far fa-calendar-check'></i> Reminder: </label> <input
					name="reminder" type="datetime-local" id="reminder"
					value="<%=(uptTask != null) ? uptTask.getReminder() : ""%>">
				<br>

				<h3 id="notesh3">Notes:</h3>
				<textarea name="notes" placeholder="Insert Your Notes Here"
					id="notes" rows="3" cols="45"><%=(uptTask != null) ? uptTask.getNotes() : ""%></textarea>



				<p id="cancel">Cancel</p>
				<button type="submit" id="savetask" onclick="setFormAction('save')">Save</button>
				<button type="submit" id="updatetask"
					onclick="setFormAction('update')">Update</button>
			</form>
		</div>
</body>

<script type="text/javascript" src="assets/js/calendar.js"></script>
<script type="text/javascript" src="assets/js/task.js"></script>
</html>