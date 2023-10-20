package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.InvalidInputException;
import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Subtask;
import com.fssa.freshtime.models.Task;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.TaskService;
import com.fssa.freshtime.utils.Logger;

/**
 * Servlet implementation class TaskServlet
 */

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String VIEW_TASKS_PAGE = "/readTask.jsp";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		TaskService taskservice = new TaskService();

		String action = request.getParameter("action");

		try {

			User currentUser = (User) session.getAttribute("user");

			List<Task> listTask = taskservice.readAllTaskByUser(currentUser.getUserId());

			System.out.println("Hi List " + listTask);

			request.setAttribute("listTask", listTask);

		} catch (ServiceException | InvalidInputException e) {

			Logger.info(e.getMessage());
			e.printStackTrace();
		}

		if ("edit".equals(action)) {

			String taskIdStr = request.getParameter("taskId");

			int taskId = Integer.parseInt(taskIdStr);

			try {
				Task task = taskservice.readTaskByTaskId(taskId);

				request.setAttribute("uptTask", task);

			} catch (ServiceException | InvalidInputException e) {
				Logger.info(e.getMessage());
				e.printStackTrace();
			}
		}

		if ("editsubtask".equals(action)) {

			int subtaskId = Integer.parseInt(request.getParameter("subtaskId"));

			try {
				Subtask subtask = taskservice.readSubTaskById(subtaskId);

				request.setAttribute("edSubtask", subtask);

			} catch (ServiceException | InvalidInputException e) {
				Logger.info(e.getMessage());
				e.printStackTrace();
			}
		}

		RequestDispatcher rd = request.getRequestDispatcher(VIEW_TASKS_PAGE);
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
