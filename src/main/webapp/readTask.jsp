<%@page import="com.fssa.freshtime.utils.Logger"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="com.fssa.freshtime.models.*"%>
<%@ page import="com.fssa.freshtime.services.*"%>
<%@ page import="com.fssa.freshtime.exceptions.*"%>
<%@ page import="org.json.JSONString"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- CSS files linked -->
<link rel="stylesheet" href="assets/css/task.css">
<link rel="stylesheet" href="assets/css/sidebar.css">
<link rel="stylesheet" href="assets/css/calendar.css">

<!-- Adding favicon and title -->
<link rel="icon" type="image/x-icon" sizes="16x16 32x32"
	href="assets/images/favicon.png">
<title>FreshTime | To Do's</title>

<!-- Ubuntu font link added -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Ubuntu&display=swap');
</style>

<!-- Bootstrap for adding icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://kit.fontawesome.com/ee40c53027.js" crossorigin="anonymous" integrity=""></script>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">

<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css'
	rel='stylesheet'>
	

</head>
<body>
	<div class="main">
		<div class="taskpage">

			<jsp:include page="sidebar.jsp"></jsp:include>

			<!-- Adding Task Alert -->
			<jsp:include page="alert.jsp"></jsp:include>

			<%User user = (User) session.getAttribute("user");%>

			<%
			List<Task> listTask = (List<Task>) request.getAttribute("listTask");
			%>
			<div class="taskcol">
				<div class="dailyheader">
					<div>
						<p class="Todayschedule">Today's Schedule</p>
						<p class="totalTask">
							You've Got <span id="tottask"><%=listTask != null ? listTask.size() : 0%>
								Task</span> To Do
						</p>
						<div class="datentime">
							<p id="date"></p>
							<p id="timenow"></p>
						</div>
					</div>
					
				</div>

				<div id="taskandsubtask">
					<%
					if (listTask != null) {
						for (Task task : listTask) {
							LocalDate dueDate = task.getDueDate();
							LocalDate today = LocalDate.now();
							LocalDate yesterday = today.minusDays(1);
							LocalDate tomorrow = today.plusDays(1);

							String priority = task.getPriority().toString().toUpperCase();
							String status = task.getStatus().toString().toUpperCase();
					%>
					<div id="tasklist">
						<div class="taskli">
							<label><input type="checkbox" /><span class="checkbox"></span></label>
							<i class="fa-solid fa-chevron-right toggle-chevron"></i> <a
								class="taskName"
								href="<%=request.getContextPath()%>/TaskServlet?action=edit&taskId=<%=task.getTaskId()%>">
								<%=task != null ? task.getTaskName() : ""%>
							</a>

							<p class="taskDueDate">
								<%
								if (dueDate.equals(today)) {
								%>
								Today
								<%
								} else if (dueDate.equals(yesterday)) {
								%>
								Yesterday
								<%
								} else if (dueDate.equals(tomorrow)) {
								%>
								Tomorrow
								<%
								} else {
								%>
								<%=dueDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>
								<%
								}
								%>
							</p>

							<%
							if ("LOW".equals(priority)) {
							%>
							<img src="assets/images/greencircle.png" alt="green circle"
								id="greencircle" />
							<p class="taskPriority"><%=priority%></p>
							<%
							} else if ("MEDIUM".equals(priority)) {
							%>
							<img src="assets/images/yellowcircle.png" alt="yellow circle"
								id="yellowcircle" />
							<p class="taskPriority">MID</p>
							<%
							} else if ("HIGH".equals(priority)) {
							%>
							<img src="assets/images/redcircle.png" alt="red circle"
								id="redcircle" />
							<p class="taskPriority"><%=priority%></p>
							<%
							}
							%>

							<p class="<%=status.toLowerCase()%> taskStatus"><%=status%></p>
						</div>

						<div class="subtasklist">
							<%
							TaskService taskService = new TaskService();
							List<Subtask> subtaskList = null;
							try {
								subtaskList = taskService.readAllSubTaskByTaskId(task.getTaskId());
							} catch (ServiceException | InvalidInputException e) {
								System.out.println("Couldn't get subtask" + e.getMessage());
								e.printStackTrace();
							}

							if (subtaskList != null) {
								for (Subtask subtask : subtaskList) {
									LocalDate subtaskDueDate = subtask.getDueDate();
									String subtaskPriority = subtask.getPriority() != null ? subtask.getPriority().toString().toUpperCase() : "";
									String subtaskStatus = subtask.getStatus() != null ? subtask.getStatus().toString().toUpperCase() : "";
							%>
							<div class="subtaskli">
								<label><input type="checkbox" /><span class="checkbox"></span></label>
								<a
									href="<%=request.getContextPath()%>/TaskServlet?action=editsubtask&subtaskId=<%=subtask.getSubtaskId()%>"
									class="subtaskName"> <%=subtask != null ? subtask.getSubtaskName() : ""%>
								</a>

								<p class="subtaskDueDate">
									<%if (subtaskDueDate != null) {%>
										<%if (subtaskDueDate.equals(today)) {%> Today
										<%} else if (subtaskDueDate.equals(yesterday)) {%> Yesterday
										<%} else if (subtaskDueDate.equals(tomorrow)) {%> Tomorrow
										<%} else {%>
											<%=subtaskDueDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>
										<%}%>
									<%}%>
								</p>

								<%
								if ("LOW".equals(subtaskPriority)) {
								%>
								<img src="assets/images/greencircle.png" alt="green circle"
									id="greencircle" />
								<p class="subtaskpriority"><%=subtaskPriority%></p>
								<%
								} else if ("MEDIUM".equals(subtaskPriority)) {
								%>
								<img src="assets/images/yellowcircle.png" alt="yellow circle"
									id="yellowcircle" />
								<p class="subtaskpriority">MID</p>
								<%
								} else if ("HIGH".equals(subtaskPriority)) {
								%>
								<img src="assets/images/redcircle.png" alt="red circle"
									id="redcircle" />
								<p class="subtaskpriority"><%=subtaskPriority%></p>
								<%
								}
								%>

								<p class="<%=subtaskStatus.toLowerCase()%> subtaskStatus"><%=subtaskStatus%></p>
							</div>
							<%
							}
							} else {
							%>
							<p>No SubTask Found</p>
							<%
							}
							%>

							<form id="addsubtask"
								action="<%=request.getContextPath()%>/AddSubtaskServlet"
								method="post">
								<input type="hidden" name="taskId" value="<%=task.getTaskId()%>">
								<input type="text" name="subtaskName" class="subtaskName"
									placeholder="+ Add Subtask">
								<button type="submit" class="addsubtaskbtn">Add</button>
							</form>
						</div>
					</div>
					<%
					}
					} else {
					%>
					<img alt="no task img" src="assets/images/notask.png">
					<%
					}
					%>
				</div>


				<form action="<%=request.getContextPath()%>/AddTaskServlet" method="post" id="addtaskform">
					
					<input type="hidden" value=<%=user.getUserId()%> name="userId">
					<input type="text" id="addtaskbar" placeholder="+ Add Task" name="taskname">
					<button id="addtaskplus"><i class="fa-solid fa-arrow-up"></i></button>
	
				</form>

			</div>
			<div class="profilecol">
				<div class="profilesection">
					<div class="nameset">
						<p id="username"><%=(String) session.getAttribute("username")%></p>
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
		
			<p id="cancel"><i class="fa-solid fa-x"></i></p>

			<div class="taskheader">
				<div class="design">
					<p></p>
				</div>
				<div>
					<h3 class="taskheading">Update Task</h3>
					<p class="taskquote">Tackle your goals in daily doses</p>
				</div>
			</div>
			
			<%
			Task uptTask = (Task) request.getAttribute("uptTask");
			Subtask edsubtask = (Subtask) request.getAttribute("edSubtask");

			String taskNameField = "";
			String descField = "";
			LocalDate dueDateField = null;
			String priorityField = "";
			String statusField = "";
			LocalDateTime reminderField = null;
			String notesField = null;

			if (uptTask != null) {
				taskNameField = uptTask.getTaskName();
				descField = uptTask.getDescription() != null ? uptTask.getDescription() : "";
				dueDateField = uptTask.getDueDate();
				priorityField = uptTask.getPriority() != null ? uptTask.getPriority().toString() : "";
				statusField = uptTask.getStatus() != null ? uptTask.getStatus().toString() : "";
				reminderField = uptTask.getReminder();
				if (uptTask.getNotes() != null) {
					notesField = uptTask.getNotes();
				}
			} else if (edsubtask != null) {
				taskNameField = edsubtask.getSubtaskName();
				descField = edsubtask.getDescription() != null ? edsubtask.getDescription() : "";
				dueDateField = edsubtask.getDueDate();
				priorityField = edsubtask.getPriority() != null ? edsubtask.getPriority().toString() : "";
				statusField = edsubtask.getStatus() != null ? edsubtask.getStatus().toString() : "";
				reminderField = edsubtask.getReminder();
				if (edsubtask.getNotes() != null) {
					notesField = edsubtask.getNotes();
				}
			}
			%>
			<form id="addtaskform" method="get">

				<input type="hidden" id="taskId"
					value="<%=(uptTask != null) ? uptTask.getTaskId() : ""%>">

				<input type="hidden" id="subtaskId"
					value="<%=(edsubtask != null) ? edsubtask.getSubtaskId() : ""%>">

				
				 <jsp:include page="taskstatus.jsp"></jsp:include>

				<input type="text" id="taskname" name="taskname"
					value="<%=taskNameField%>" placeholder="Add Task" required>

				<br> 
				
				<jsp:include page="duedate.jsp"></jsp:include>

				<br> 
				
				<jsp:include page="priorityDropdown.jsp"></jsp:include>
				
				<br> 
				
				<jsp:include page="reminder.jsp"></jsp:include>
					
				<br>
				
				<div class="notesContainer">
					<p class="notesHeading"><span><i class="fa-regular fa-note-sticky"></i></span>  Notes:</p>
					<textarea rows="5" cols="40" id="notesFeild" placeholder="Insert Your Thoughts Here"></textarea>
                 </div>


				<button type="submit" id="deletebtn" 
					onclick="setFormAction('delete')">
					<i class="fa-solid fa-trash"></i> Delete
				</button>
				
				<button type="submit" id="updatetask"
					onclick="setFormAction('update')"><i class="fa-solid fa-pen"></i> Update</button>
			</form>
		</div>
	</div>
</body>

<script type="text/javascript" src="assets/js/calendar.js"></script>
<script type="text/javascript" src="assets/js/task.js"></script>

</html>
