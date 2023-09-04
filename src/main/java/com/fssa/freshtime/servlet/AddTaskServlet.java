package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.fssa.freshtime.models.Task;
import com.fssa.freshtime.models.enums.TaskPriority;
import com.fssa.freshtime.models.enums.TaskStatus;
import com.fssa.freshtime.services.TaskService;
import com.fssa.freshtime.exceptions.*;

/**
 * Servlet implementation class addtask
 */
@WebServlet("/AddTaskServlet") 
public class AddTaskServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	
	
	TaskService taskservice = new TaskService();
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		
		PrintWriter out = response.getWriter();
		
		// Get parameters from the form
        String taskName = request.getParameter("taskname");
        String taskDescription = request.getParameter("taskdescription");
        String dueDateStr = request.getParameter("duedate");
        String priorityStr = request.getParameter("priority");
        String statusStr = request.getParameter("status");
        String reminderStr = request.getParameter("reminder");
        String notes = request.getParameter("notes");
        
        System.out.println(taskName);
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate dueDate = LocalDate.parse(dueDateStr, formatter);
        
        TaskPriority priority = TaskPriority.valueOf(priorityStr);
        
        TaskStatus status = TaskStatus.valueOf(statusStr);
        
        
        DateTimeFormatter reminderformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime reminder = LocalDateTime.parse(reminderStr , reminderformatter);
        

        
        try {
            HttpSession session = request.getSession();
            String emailId = (String) session.getAttribute("Logedinemail");

            int userId = taskservice.getUserIdByEmail(emailId);
        	
            Task task = new Task();
            
            task.setUserId(userId);
            task.setTaskName(taskName);
            task.setDescription(taskDescription);
            task.setDueDate(dueDate);
            task.setPriority(priority);
            task.setStatus(status);
            task.setNotes(notes);
            task.setReminder(reminder);
        	
        	
        	taskservice.addTask(task);
        	
        	request.setAttribute("addTaskSuccess", task.getTaskName()+"Task Added Successfully!");
			
			rd = request.getRequestDispatcher("TaskServlet");
        }
        catch(ServiceException e) {
        	
        	System.out.println(e.getMessage());
        	e.printStackTrace();
        	
		    request.setAttribute("addTaskError", e.getMessage());
			
			rd = request.getRequestDispatcher("TaskServlet");
            
        }
        finally {
        	 
        	rd.forward(request, response);
        }
        
	}

}