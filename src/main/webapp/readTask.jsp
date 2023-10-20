<%@page import="java.text.DateFormat"%>
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
<link
	href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
	rel="stylesheet">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Ubuntu&display=swap');
</style>

<!-- Bootstrap for adding icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://kit.fontawesome.com/ee40c53027.js"
	crossorigin="anonymous" integrity=""></script>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">

<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css'
	rel='stylesheet'>

<link rel="stylesheet" type="text/css"
	href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">


</head>
<body>
	<div class="main">
		<div class="taskpage">

			<jsp:include page="sidebar.jsp"></jsp:include>

			<!-- Adding Task Alert -->
			<jsp:include page="alert.jsp"></jsp:include>

			<%
			User user = (User) session.getAttribute("user");
			%>

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
				
					<div class="TaskListHeader">
						<p class="statusheader">Status  <span><i class="fa-solid fa-arrow-up"></i></span> </p>
						<p class="tasknameheader">Task Name  <span><i class="fa-solid fa-arrow-up"></i></span></p>
						<p class="startdateheader" >Start Date  <span><i class="fa-solid fa-arrow-up"></i></span></p>
						<p class="enddateheader">End Date  <span><i class="fa-solid fa-arrow-up"></i></span></p>
						<p class="priorityheader">Priority  <span><i class="fa-solid fa-arrow-up"></i></span></p>
					</div>
					
					<p class="taskheaderhr"></p>
					<%
					if (listTask != null && !listTask.isEmpty()) {
						for (Task task : listTask) {

							LocalDateTime today = LocalDateTime.now();
							LocalDateTime yesterday = today.minusDays(1);
							LocalDateTime tomorrow = today.plusDays(1);

							LocalDateTime endDate = task.getEndDate() != null ? task.getEndDate() : null;
							LocalDateTime startDate = task.getStartDate() != null ? task.getStartDate() : null;

							if (startDate == null && endDate != null) {
						startDate = LocalDateTime.now();
							}

							String priority = task.getPriority() != null ? task.getPriority().toString().toUpperCase() : null;
							String status = task.getStatus() != null ? task.getStatus().toString().toUpperCase() : null;
					%>
					
					<div id="tasklist">
						<div class="taskli">

							<p class="taskStatus">
								<%
								if (status == "TODO") {
								%><i class="fa-regular fa-square"></i>
								<%
								}
								%>
								<%
								if (status == "INPROGRESS") {
								%><i class="fa-solid fa-play"></i>
								<%
								}
								%>
								<%
								if (status == "COMPLETED") {
								%><i class="fa-regular fa-circle-check"></i>
								<%
								}
								%>
								<%
								if (status == "BLOCKER") {
								%><i class="fa-solid fa-circle-exclamation"></i>
								<%
								}
								%>
								<%
								if (status == "OVERDUE") {
								%><i class="fa-solid fa-triangle-exclamation"></i>
								<%
								}
								%>
							</p>


							<i class="fa-solid fa-chevron-right toggle-chevron"></i> <a
								onclick="getDates()" class="taskName"
								href="<%=request.getContextPath()%>/TaskServlet?action=edit&taskId=<%=task.getTaskId()%>">
								<%=task != null ? task.getTaskName() : ""%>
							</a>


							<%
							if (startDate != null) {
							%>
							<p class="taskStartDate">
								<svg xmlns="http://www.w3.org/2000/svg" width="48"
									viewBox="0 0 48 50" style="width: 18px;">
									<path data-name="Calendar Date"
										d="M40 50H8a8 8 0 01-8-8V14a8 8 0 018-8h4V1.5A1.5 1.5 0 0113.5 0h3A1.5 1.5 0 0118 1.5V6h12V1.5A1.5 1.5 0 0131.5 0h3A1.5 1.5 0 0136 1.5V6h4a8 8 0 018 8v28a8 8 0 01-8 8zm2-36a2 2 0 00-2-2H8a2 2 0 00-2 2v28a2 2 0 002 2h32a2 2 0 002-2V14zM20.5 28h-7a1.5 1.5 0 01-1.5-1.5v-7a1.5 1.5 0 011.5-1.5h7a1.5 1.5 0 011.5 1.5v7a1.5 1.5 0 01-1.5 1.5z"
										fill-rule="evenodd"></path></svg>
								<%
								if (startDate.equals(today)) {
								%>Today
								<%
								} else if (startDate.equals(yesterday)) {
								%>Yesterday
								<%
								} else if (startDate.equals(tomorrow)) {
								%>Tomorrow
								<%
								} else {
								%>
								<%=startDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))%>
								<%
								}
								%>
							</p>
							<%
							}
							%>




							<%
							if (endDate != null) {
							%>
							<p class="taskEndDate">
								<span><svg xmlns="http://www.w3.org/2000/svg" width="48"
										viewBox="0 0 48 50" style="width: 18px;">
										<path data-name="Calendar End Date"
											d="M40 50H8a8 8 0 01-8-8V14a8 8 0 018-8h4V1.5A1.5 1.5 0 0113.5 0h3A1.5 1.5 0 0118 1.5V6h12V1.5A1.5 1.5 0 0131.5 0h3A1.5 1.5 0 0136 1.5V6h4a8 8 0 018 8v28a8 8 0 01-8 8zm2-36a2 2 0 00-2-2H8a2 2 0 00-2 2v28a2 2 0 002 2h32a2 2 0 002-2V14zm-7.5 24h-7a1.5 1.5 0 01-1.5-1.5v-7a1.5 1.5 0 011.5-1.5h7a1.5 1.5 0 011.5 1.5v7a1.5 1.5 0 01-1.5 1.5z"
											fill-rule="evenodd"></path></svg> </span>
								<%
								if (endDate.equals(today)) {
								%>Today
								<%
								} else if (endDate.equals(yesterday)) {
								%>Yesterday
								<%
								} else if (endDate.equals(tomorrow)) {
								%>Tomorrow
								<%
								} else {
								%>
								<%=endDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))%>
								<%
								}
								%>
							</p>
							<%
							}
							%>



							<%
							if (priority != null) {
							%>
							<p class="taskPriority">
								<%
								if (priority == "HIGH") {
								%><span class="circle red-circle"></span> High Priority
								<%
								}
								%>
								<%
								if (priority == "MID") {
								%><span class="circle orange-circle"></span> Medium Priority
								<%
								}
								%>
								<%
								if (priority == "LOW") {
								%><span class="circle green-circle"></span> Low Priority
								<%
								}
								%>
							</p>
							<%
							}
							%>

						</div>

						<div class="subtasklist">


							<%
							TaskService taskService = new TaskService();
							List<Subtask> subtaskList = null;
							try {
								subtaskList = taskService.readAllSubTaskByTaskId(task.getTaskId());
							} catch (ServiceException | InvalidInputException e) {
								Logger.info("Couldn't get subtask" + e.getMessage());
								e.printStackTrace();
							}

							if (subtaskList != null) {
								for (Subtask subtask : subtaskList) {

									String subtaskPriority = subtask.getPriority() != null ? subtask.getPriority().toString().toUpperCase() : "";
									String subtaskStatus = subtask.getStatus() != null ? subtask.getStatus().toString().toUpperCase() : "";

									LocalDateTime subtaskEndDate = subtask.getEndDate() != null ? subtask.getEndDate() : null;
									LocalDateTime subtaskStartDate = subtask.getStartDate() != null ? subtask.getStartDate() : null;

									if (subtaskStartDate == null && subtaskEndDate != null) {
								subtaskStartDate = LocalDateTime.now();
									}
							%>


							<div class="subtaskli">

								<p class="subtaskStatus">
									<%
									if (subtaskStatus == "TODO") {
									%><i class="fa-regular fa-square"></i>
									<%
									}
									%>
									<%
									if (subtaskStatus == "INPROGRESS") {
									%><i class="fa-solid fa-play"></i>
									<%
									}
									%>
									<%
									if (subtaskStatus == "COMPLETED") {
									%><i class="fa-regular fa-circle-check"></i>
									<%
									}
									%>
									<%
									if (subtaskStatus == "BLOCKER") {
									%><i class="fa-solid fa-circle-exclamation"></i>
									<%
									}
									%>
									<%
									if (subtaskStatus == "OVERDUE") {
									%><i class="fa-solid fa-triangle-exclamation"></i>
									<%
									}
									%>
								</p>


								<a class="subtaskName"
									href="<%=request.getContextPath()%>/TaskServlet?action=editsubtask&subtaskId=<%=subtask.getSubtaskId()%>">
									<%=subtask != null ? subtask.getSubtaskName() : ""%>
								</a>

								<%
								if (subtaskStartDate != null) {
								%>
								<p class="subtaskStartDate">
									<span><svg xmlns="http://www.w3.org/2000/svg" width="48"
											viewBox="0 0 48 50" style="width: 18px;">
											<path data-name="Calendar Date"
												d="M40 50H8a8 8 0 01-8-8V14a8 8 0 018-8h4V1.5A1.5 1.5 0 0113.5 0h3A1.5 1.5 0 0118 1.5V6h12V1.5A1.5 1.5 0 0131.5 0h3A1.5 1.5 0 0136 1.5V6h4a8 8 0 018 8v28a8 8 0 01-8 8zm2-36a2 2 0 00-2-2H8a2 2 0 00-2 2v28a2 2 0 002 2h32a2 2 0 002-2V14zM20.5 28h-7a1.5 1.5 0 01-1.5-1.5v-7a1.5 1.5 0 011.5-1.5h7a1.5 1.5 0 011.5 1.5v7a1.5 1.5 0 01-1.5 1.5z"
												fill-rule="evenodd"></path></svg></span>
									<%
									if (subtaskStartDate.equals(today)) {
									%>Today
									<%
									} else if (subtaskStartDate.equals(yesterday)) {
									%>Yesterday
									<%
									} else if (subtaskStartDate.equals(tomorrow)) {
									%>Tomorrow
									<%
									} else {
									%>
									<%=subtaskStartDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))%>
									<%
									}
									%>
								</p>
								<%
								}
								%>

								<%
								if (subtaskEndDate != null) {
								%>
								<p class="subtaskEndDate">
									<span><svg xmlns="http://www.w3.org/2000/svg" width="48"
											viewBox="0 0 48 50" style="width: 18px;">
											<path data-name="Calendar End Date"
												d="M40 50H8a8 8 0 01-8-8V14a8 8 0 018-8h4V1.5A1.5 1.5 0 0113.5 0h3A1.5 1.5 0 0118 1.5V6h12V1.5A1.5 1.5 0 0131.5 0h3A1.5 1.5 0 0136 1.5V6h4a8 8 0 018 8v28a8 8 0 01-8 8zm2-36a2 2 0 00-2-2H8a2 2 0 00-2 2v28a2 2 0 002 2h32a2 2 0 002-2V14zm-7.5 24h-7a1.5 1.5 0 01-1.5-1.5v-7a1.5 1.5 0 011.5-1.5h7a1.5 1.5 0 011.5 1.5v7a1.5 1.5 0 01-1.5 1.5z"
												fill-rule="evenodd"></path></svg> </span>
									<%
									if (subtaskEndDate.equals(today)) {
									%>Today
									<%
									} else if (subtaskEndDate.equals(yesterday)) {
									%>Yesterday
									<%
									} else if (subtaskEndDate.equals(tomorrow)) {
									%>Tomorrow
									<%
									} else {
									%>
									<%=subtaskEndDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))%>
									<%
									}
									%>
								</p>
								<%
								}
								%>



								<%
								if (subtaskPriority != null) {
								%>
								<p class="subtaskPriority">
									<%
									if (subtaskPriority == "HIGH") {
									%><span class="circle red-circle"></span> High Priority
									<%
									}
									%>
									<%
									if (subtaskPriority == "MID") {
									%><span class="circle orange-circle"></span> Medium Priority
									<%
									}
									%>
									<%
									if (subtaskPriority == "LOW") {
									%><span class="circle green-circle"></span> Low Priority
									<%
									}
									%>
								</p>
								<%
								}
								%>


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
								<input type="text" name="subtaskName" class="subtaskNameInput"
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


				<form action="<%=request.getContextPath()%>/AddTaskServlet"
					method="post" id="addtaskform">

					<input type="hidden" value=<%=user.getUserId()%> name="userId">
					<input type="text" id="addtaskbar" placeholder="+ Add Task"
						name="taskNameInput">
					<button id="addtaskplus">
						<i class="fa-solid fa-arrow-up"></i>
					</button>

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

			<p id="cancel">
				<i class="fa-solid fa-x"></i>
			</p>

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
			LocalDateTime startDateField = null;
			LocalDateTime endDateField = null;
			String priorityField = "";
			String statusField = "";
			LocalDateTime reminderField = null;
			String notesField = null;

			if (uptTask != null) {

				taskNameField = uptTask.getTaskName().trim();

				startDateField = uptTask.getStartDate() != null ? uptTask.getStartDate() : null;
				endDateField = uptTask.getEndDate() != null ? uptTask.getEndDate() : null;
				priorityField = uptTask.getPriority() != null ? uptTask.getPriority().toString() : "";
				statusField = uptTask.getStatus() != null ? uptTask.getStatus().toString() : "";
				reminderField = uptTask.getReminder() != null ? uptTask.getReminder() : null;

				if (uptTask.getNotes() != null) {
					notesField = uptTask.getNotes().trim();
				}

			} else if (edsubtask != null) {

				taskNameField = edsubtask.getSubtaskName().trim();

				startDateField = edsubtask.getStartDate() != null ? edsubtask.getStartDate() : null;
				endDateField = edsubtask.getEndDate() != null ? edsubtask.getEndDate() : null;
				priorityField = edsubtask.getPriority() != null ? edsubtask.getPriority().toString() : "";
				statusField = edsubtask.getStatus() != null ? edsubtask.getStatus().toString() : "";
				reminderField = edsubtask.getReminder() != null ? edsubtask.getReminder() : null;

				if (edsubtask.getNotes() != null) {
					notesField = edsubtask.getNotes().trim();
				}
			}

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

			String startDateFormatted = null;
			if (startDateField != null) {
				startDateFormatted = startDateField.format(formatter);
			}

			String endDateFormatted = null;
			if (endDateField != null) {
				endDateFormatted = endDateField.format(formatter);
			}
			String reminderFormatted = null;
			if (reminderField != null) {
				reminderFormatted = reminderField.format(formatter);
			}
			%>

			<script>
			    let startDate = '<%=startDateFormatted%>';
			    let endDate = '<%=endDateFormatted%>';
			    let reminderDate = '<%=reminderFormatted%>';

				console.log(startDate, endDate, reminderDate);
			</script>

			<form id="updatetaskform" method="get">


				<input type="hidden" id="taskId" name="taskId"
					value="<%=(uptTask != null) ? uptTask.getTaskId() : ""%>">

				<input type="hidden" id="subtaskId" name="subtaskId"
					value="<%=(edsubtask != null) ? edsubtask.getSubtaskId() : ""%>">

				<div class="status-dropdown">
					<input type="hidden" id="statusInput" name="status"
						value="<%=statusField%>">
					<div class="selected-option">


						<%
						if (statusField == "TODO")
						%>
						<i class="fa-regular fa-square"></i>
						<%
						if (statusField == "INPROGRESS")
						%>
						<i class="fa-solid fa-play"></i>
						<%
						if (statusField == "COMPLETED")
						%>
						<i class="fa-regular fa-circle-check"></i>
						<%
						if (statusField == "BLOCKER")
						%>
						<i class="fa-solid fa-circle-exclamation"></i>
						<%
						if (statusField == "OVERDUE")
						%>
						<i class="fa-solid fa-triangle-exclamation"></i>


					</div>
					<ul class="dropdown-list">
						<li data-value="TODO"><i class="fa-regular fa-square"></i>To
							Do</li>
						<li data-value="INPROGRESS"><i class="fa-solid fa-play"></i>
							In Progress</li>
						<li data-value="COMPLETED"><i
							class="fa-regular fa-circle-check"></i> Completed</li>
						<li data-value="BLOCKER"><i
							class="fa-solid fa-circle-exclamation"></i> Blocker</li>
						<li data-value="OVERDUE"><i
							class="fa-solid fa-triangle-exclamation"></i> Overdue</li>
					</ul>
				</div>

				<input type="text" id="taskname" name="taskname"
					placeholder="Task Name"
					value="<%if (taskNameField != null) {%><%=taskNameField.trim()%><%}%>"
					required> <br>

				<div class="dueDateBox">

					<div class="startDate-group">
						<label for="startDate" id="startDateLabel"> <svg
								xmlns="http://www.w3.org/2000/svg" width="48"
								viewBox="0 0 48 50" style="width: 18px;">
								<path data-name="Calendar Date"
									d="M40 50H8a8 8 0 01-8-8V14a8 8 0 018-8h4V1.5A1.5 1.5 0 0113.5 0h3A1.5 1.5 0 0118 1.5V6h12V1.5A1.5 1.5 0 0131.5 0h3A1.5 1.5 0 0136 1.5V6h4a8 8 0 018 8v28a8 8 0 01-8 8zm2-36a2 2 0 00-2-2H8a2 2 0 00-2 2v28a2 2 0 002 2h32a2 2 0 002-2V14zM20.5 28h-7a1.5 1.5 0 01-1.5-1.5v-7a1.5 1.5 0 011.5-1.5h7a1.5 1.5 0 011.5 1.5v7a1.5 1.5 0 01-1.5 1.5z"
									fill-rule="evenodd"></path></svg>
						</label> <input id="startDate" name="startDate" type="datetime-local"
							placeholder="Set Start Date"
							value="<%if (startDateFormatted != null) {%><%=startDateFormatted%><%}%>" />

					</div>

					<p id="line"></p>

					<div class="endDate-group">
						<label for="endDate"> <svg
								xmlns="http://www.w3.org/2000/svg" width="48"
								viewBox="0 0 48 50" style="width: 18px;">
								<path data-name="Calendar End Date"
									d="M40 50H8a8 8 0 01-8-8V14a8 8 0 018-8h4V1.5A1.5 1.5 0 0113.5 0h3A1.5 1.5 0 0118 1.5V6h12V1.5A1.5 1.5 0 0131.5 0h3A1.5 1.5 0 0136 1.5V6h4a8 8 0 018 8v28a8 8 0 01-8 8zm2-36a2 2 0 00-2-2H8a2 2 0 00-2 2v28a2 2 0 002 2h32a2 2 0 002-2V14zm-7.5 24h-7a1.5 1.5 0 01-1.5-1.5v-7a1.5 1.5 0 011.5-1.5h7a1.5 1.5 0 011.5 1.5v7a1.5 1.5 0 01-1.5 1.5z"
									fill-rule="evenodd"></path></svg>
						</label> <input id="endDate" name="endDate" type="datetime-local"
							placeholder="Set End Date"
							value="<%if (endDateFormatted != null) {%><%=endDateFormatted%><%}%>">
					</div>
				</div>

				<br>

				<div class="priority-dropdown">

					<div class="priorityBox">
						<label class="priorityLabel"><i class="fa-solid fa-bolt"></i>
						</label>
						<p class="selected-priority">
							<%
							if (priorityField == "HIGH") {
							%>
							<span class="circle red-circle"></span> High Priority
							<%
							} else if (priorityField == "MID") {
							%>
							<span class="circle orange-circle"></span> Mid Priority
							<%
							} else if (priorityField == "LOW") {
							%>
							<span class="circle green-circle"></span> Low Priority
							<%
							} else {
							%>
							Add Priority
							<%
							}
							%>
						</p>

						<input type="hidden" id="priorityInput" name="priority"
							value="<%=priorityField%>">
					</div>
					<ul class="priority-dropdown-list">
						<li data-value="HIGH" class="high-priority"><span
							class="circle red-circle"></span> High Priority</li>
						<li data-value="MID" class="mid-priority"><span
							class="circle orange-circle"></span> Mid Priority</li>
						<li data-value="LOW" class="low-priority"><span
							class="circle green-circle"></span> Low Priority</li>
					</ul>

				</div>

				<br>

				<div class="reminderBox">
					<label><i class="fa-solid fa-bell"></i></label> <input
						id="reminderInput" name="reminder" type="datetime-local"
						placeholder="Set Reminder"
						value="<%if (reminderFormatted != null) {%><%=reminderFormatted%><%}%>" />
				</div>

				<br>

				<div class="notesContainer">
					<p class="notesHeading">
						<span><i class="fa-regular fa-note-sticky"></i></span> Notes:
					</p>
					<textarea rows="5" cols="40" id="notesFeild" name="notes"><%if (notesField != null) {%><%=notesField.trim()%><%}%></textarea>
				</div>


				<p onclick="setFormAction('delete')" id="deletebtn">
					<i class="fa-solid fa-trash"></i> Delete
				</p>

				<p onclick="setFormAction('update')" class="updatetask">
					<i class="fa-solid fa-pen"></i> Update
				</p>
			</form>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script>
	
		// Get a reference to the parent element with class "TaskListHeader"
		var taskListHeader = document.querySelector(".TaskListHeader");
	
		// Get a NodeList of all <p> elements within the parent element
		var headerParagraphs = taskListHeader.querySelectorAll("p");
	
		// Loop through each <p> element
		for (var i = 0; i < headerParagraphs.length; i++) {
		    var pElement = headerParagraphs[i];
		    
		    // Attach a click event to each <p> element
		    pElement.onclick = function() {
		        var attribute = this.getAttribute("data-attribute");
		        window.location.href = "TaskServlet?action=sort&order=ascending&attribute=" + attribute;
		    };
		    
		    // Set the "data-attribute" attribute based on the class name
		    var className = pElement.className;
		    if (className === "statusheader") {
		        pElement.setAttribute("data-attribute", "status");
		    } else if (className === "tasknameheader") {
		        pElement.setAttribute("data-attribute", "taskname");
		    } else if (className === "startdateheader") {
		        pElement.setAttribute("data-attribute", "startdate");
		    } else if (className === "enddateheader") {
		        pElement.setAttribute("data-attribute", "enddate");
		    } else if (className === "priorityheader") {
		        pElement.setAttribute("data-attribute", "priority");
		    }
		}
		
		// Get the attribute and order values from the URL
		var urlParams = new URLSearchParams(window.location.search);
		var attributeName = urlParams.get("attribute");
		var order = urlParams.get("order");

		// Get the parent element with class "tasknameheader"
		var taskNameHeader = document.querySelector(".tasknameheader");

		// Get the <i> element inside the <span>
		var icon = taskNameHeader.querySelector("span i");

		// Check if the attribute is "taskname" and the order is "descending"
		if (attributeName === "taskname" && order === "descending") {
		    // Change the class of the <i> element to "fa-arrow-down"
		    icon.classList.remove("fa-arrow-up");
		    icon.classList.add("fa-arrow-down");
		}

		
	</script>
		
	<script>
	
		// Setting values to flatpikcr inputs
		let startDateValue = document.getElementById("startDate");
		let endDateValue = document.getElementById("endDate");
		let reminderValue = document.getElementById("reminderInput");

		startDateValue.value = datetimeLocal(startDate);
		endDateValue.value = datetimeLocal(endDate);
		reminderValue.value = datetimeLocal(reminderDate);

		function datetimeLocal(datetime) {
			const dt = new Date(datetime);
			dt.setMinutes(dt.getMinutes() - dt.getTimezoneOffset());
			return dt.toISOString().slice(0, 16);
		}


		function setFormAction(formaction) {

			let form = document.getElementById("updatetaskform");
			let taskId = document.getElementById("taskId").value;
			let subtaskId = document.getElementById("subtaskId").value;

			form.method = "post";

			if (formaction === 'update') {
				if (action === "editsubtask") {
					form.action = `UpdateSubtaskServlet?subtaskId=${subtaskId}`;
				} else {
					form.action = `UpdateTaskServlet`;
				}
			} else if (formaction === 'delete') {
				if (action === "editsubtask") {
					form.action = `DeleteSubtaskServlet?subtaskId=${subtaskId}`;
				} else {
					form.action = `DeleteTaskServlet?taskId=${taskId}`;
				}
			}

			form.submit();
		}
		

	</script>
	<script type="text/javascript" src="assets/js/calendar.js"></script>
	<script type="text/javascript" src="assets/js/task.js"></script>

</body>
</html>
