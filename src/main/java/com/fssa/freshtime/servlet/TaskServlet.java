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
import com.fssa.freshtime.models.Task;
import com.fssa.freshtime.services.TaskService;

/**
 * Servlet implementation class TaskServlet
 */

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String VIEW_TASKS_PAGE = "/readTask.jsp";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		TaskService taskservice = new TaskService();

		String action = request.getParameter("action");
		String emailId = (String) session.getAttribute("Logedinemail");

		try {

			List<Task> listTask = taskservice.readAllTaskByUser(emailId);

			request.setAttribute("listTask", listTask);

		} catch (ServiceException | InvalidInputException e) {

			System.out.println(e.getMessage());
			out.println(e.getMessage());
			e.printStackTrace();
		}

		if ("edit".equals(action)) {

			String taskIdStr = request.getParameter("taskId");

			int taskId = Integer.parseInt(taskIdStr);

			try {
				Task task = taskservice.readAllTaskByTaskId(taskId);

				System.out.println(task);

				request.setAttribute("uptTask", task);

			} catch (ServiceException | InvalidInputException e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}

		RequestDispatcher rd = request.getRequestDispatcher(VIEW_TASKS_PAGE);
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
