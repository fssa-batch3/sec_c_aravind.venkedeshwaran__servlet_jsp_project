package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Subtask;
import com.fssa.freshtime.services.TaskService;

/**
 * Servlet implementation class AddSubtaskServlet
 */
public class AddSubtaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	TaskService taskservice = new TaskService();
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		
		int taskId = Integer.parseInt(request.getParameter("taskId"));
		String subtaskName = request.getParameter("subtaskName");
		
		Subtask subtask = new Subtask();
		
		subtask.setTaskId(taskId);
		subtask.setSubtaskName(subtaskName);
		
		try {
			taskservice.createSubtask(subtask);
			
			request.setAttribute("success", subtask.getSubtaskName()+" Subtask Added Successfully!");
        	
        	request.setAttribute("path", "TaskServlet");
        	
        	rd = request.getRequestDispatcher("TaskServlet");
        	
		}	
	    catch(ServiceException e) {
	    	
	    	System.out.println(e.getMessage());
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
