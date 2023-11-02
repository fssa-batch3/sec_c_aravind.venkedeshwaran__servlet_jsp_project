package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.InvalidInputException;
import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Task;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.TaskService;
import com.fssa.freshtime.services.UserService;
import com.fssa.freshtime.utils.Logger;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	
	
	private static final long serialVersionUID = 1L;
	
	UserService userService = new UserService();
	TaskService taskservice = new TaskService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 HttpSession session = request.getSession();
	        User currentUser = (User) session.getAttribute("user");
	        
	        String email = currentUser.getEmailId();
	        
	        if (email != null) {
				List<Task> listTask = null;
				try {
					listTask = taskservice.readAllTaskByUser(currentUser.getUserId());
				} catch (ServiceException | InvalidInputException e) {
					Logger.info(e.getMessage());
					e.printStackTrace();
				}
				
				int totalTask = listTask.size();
				int todoTask = 0;
				int completedTask = 0;
				int overdueTask = 0;
				int inprogressTask = 0;
				
				for(Task task : listTask) {
					if(task.getStatus().toString().equals("TODO")) todoTask++;
					if(task.getStatus().toString().equals("INPROGRESS")) inprogressTask++;
					if(task.getStatus().toString().equals("COMPLETED")) completedTask++;
					if(task.getStatus().toString().equals("OVERDUE")) overdueTask++;
				}
	                
	            session.setAttribute("username", currentUser.getUserName());
	            session.setAttribute("user", currentUser);
	            
	            request.setAttribute("totalTask", totalTask);
	            request.setAttribute("todoTask", todoTask);
	            request.setAttribute("completedTask", completedTask);
	            request.setAttribute("overdueTask", overdueTask);
	            request.setAttribute("inprogressTask", inprogressTask);
	            
	            request.getRequestDispatcher("/profile.jsp").forward(request, response);
	                
	            
	        } else {
	            System.out.println("email is null");
	        }
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
