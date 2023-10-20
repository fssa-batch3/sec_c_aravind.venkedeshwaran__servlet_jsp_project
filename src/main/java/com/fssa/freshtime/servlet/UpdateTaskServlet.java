package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Task;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.models.enums.TaskPriority;
import com.fssa.freshtime.models.enums.TaskStatus;
import com.fssa.freshtime.services.TaskService;

/**
 * Servlet implementation class UpdateTaskServlet
 */
@WebServlet("/UpdateTaskServlet")
public class UpdateTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	TaskService taskservice = new TaskService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		HttpSession session = request.getSession(false);

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

		User currentUser = (User) session.getAttribute("user");

		int taskId = Integer.parseInt(request.getParameter("taskId"));
		int userId = currentUser.getUserId();

		String taskName = request.getParameter("taskname");
		if (taskName == null || taskName.isEmpty()) {
			System.out.println("taskname is null or empty");
		}

		LocalDateTime startDate = null;
		String startDateParam = request.getParameter("startDate");
		if (startDateParam != null && !startDateParam.isEmpty()) {
			startDate = LocalDateTime.parse(startDateParam, formatter);
		}

		System.out.println("StartDate= " + startDate);

		LocalDateTime endDate = null;
		String endDateParam = request.getParameter("endDate");
		System.out.println(endDateParam);

		if (endDateParam != null && !endDateParam.isEmpty()) {
			endDate = LocalDateTime.parse(endDateParam, formatter);
		}

		System.out.println("EndDate" + endDate);

		TaskPriority priority = null;
		String priorityParam = request.getParameter("priority");
		if (priorityParam != null && !priorityParam.isEmpty()) {
			priority = TaskPriority.valueOf(priorityParam);
		}

		TaskStatus status = null;
		String statusParam = request.getParameter("status");
		if (statusParam != null && !statusParam.isEmpty()) {
			status = TaskStatus.valueOf(statusParam);
		} else {
			status = TaskStatus.TODO;
		}

		LocalDateTime reminder = null;
		String reminderParam = request.getParameter("reminder");
		if (reminderParam != null && !reminderParam.isEmpty()) {
			reminder = LocalDateTime.parse(reminderParam, formatter);
		}

		String notes = request.getParameter("notes");
		String strnote;

		if (!(notes == null)) {

			strnote = notes.trim();
		} else {

			strnote = null;
		}

		if (startDate != null && endDate == null) {
			endDate = startDate.plusDays(1);
		}

		try {

			Task task = new Task();

			task.setTaskId(taskId);
			task.setUserId(userId);
			task.setTaskName(taskName);
			task.setStartDate(startDate);
			task.setEndDate(endDate);
			task.setPriority(priority);
			task.setStatus(status);
			task.setNotes(strnote);
			task.setReminder(reminder);

			System.out.println(task);

			taskservice.updateTask(task);

			request.setAttribute("success", task.getTaskName() + " Task Updated Successfully!");

			request.setAttribute("path", "TaskServlet");

			rd = request.getRequestDispatcher("TaskServlet");

		} catch (ServiceException e) {

			System.out.println(e.getMessage());
			e.printStackTrace();

			request.setAttribute("error", e.getMessage());

			request.setAttribute("path", "TaskServlet");

			rd = request.getRequestDispatcher("TaskServlet");

		} finally {

			rd.forward(request, response);
		}
	}

}
