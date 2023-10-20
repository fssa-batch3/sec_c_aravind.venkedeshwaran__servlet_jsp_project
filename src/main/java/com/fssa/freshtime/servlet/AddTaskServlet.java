package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.TaskService;
import com.fssa.freshtime.utils.Logger;

/**
 * Servlet implementation class addtask
 */
@WebServlet("/AddTaskServlet") 
public class AddTaskServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	
	
	TaskService taskservice = new TaskService();
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		
		HttpSession session = request.getSession(false);
        try {
            
            User currentUser = (User) session.getAttribute("user");

            int userId = currentUser.getUserId();
            String taskName = request.getParameter("taskNameInput");

        	taskservice.addTask(userId, taskName);
        	
        	request.setAttribute("success", taskName +" Task Added Successfully!");
        	
        	request.setAttribute("path", "TaskServlet");
        	
        	rd = request.getRequestDispatcher("TaskServlet");
			
        }	
        catch(ServiceException e) {
        	
        	Logger.info(e.getMessage());
        	e.printStackTrace();
        	
		    request.setAttribute("error", e.getMessage());
		    
		    request.setAttribute("path", "TaskServlet");
			
			rd = request.getRequestDispatcher("TaskServlet");
            
        }
        finally {
        	 
        	rd.forward(request, response);
        }
        
	}

}
