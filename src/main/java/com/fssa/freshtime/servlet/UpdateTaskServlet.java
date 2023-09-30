package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		
		
		System.out.println("came to update task servlet");
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		
		// Get parameters from the form
		int taskId = Integer.parseInt(request.getParameter("taskId"));
		System.out.println(taskId);
		
        String taskName = request.getParameter("taskname");
        System.out.println(taskName);
        
        LocalDateTime startDate = LocalDateTime.parse(request.getParameter("startDate"), formatter);
        System.out.println(startDate);
        
        LocalDateTime endDate = LocalDateTime.parse(request.getParameter("endDate"), formatter);
        System.out.println(endDate);
        
        TaskPriority priority = TaskPriority.valueOf(request.getParameter("priority"));
        System.out.println(priority);
        
        TaskStatus status = TaskStatus.valueOf(request.getParameter("status"));
        System.out.println(status);
        
        LocalDateTime reminder = LocalDateTime.parse(request.getParameter("reminder") , formatter);
        System.out.println(reminder);
        
        String notes = request.getParameter("notes");
        System.out.println(notes);

//        try {
//            HttpSession session = request.getSession();
//            User currentUser = (User)session.getAttribute("user");
//            
//            
//            Task task = new Task();
//            
//            task.setTaskId(taskId);
//            task.setUserId(currentUser.getUserId());
//            task.setTaskName(taskName);
//            task.setDescription(taskDescription);
//            task.setDueDate(dueDate);
//            task.setPriority(priority);
//            task.setStatus(status);
//            task.setNotes(notes);
//            task.setReminder(reminder);
//        	
//        	
//        	taskservice.updateTask(task);
//        	
//        	request.setAttribute("success", task.getTaskName()+" Task Updated Successfully!");
//        	
//        	request.setAttribute("path", "TaskServlet");
//        	
//        	rd = request.getRequestDispatcher("TaskServlet");
//			
//        }	
//        catch(ServiceException e) {
//        	
//        	System.out.println(e.getMessage());
//        	e.printStackTrace();
//        	
//		    request.setAttribute("error", e.getMessage());
//		    
//		    request.setAttribute("path", "TaskServlet");
//			
//			rd = request.getRequestDispatcher("TaskServlet");
//            
//        }
//        finally {
//        	 
//        	rd.forward(request, response);
//        }
        
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
