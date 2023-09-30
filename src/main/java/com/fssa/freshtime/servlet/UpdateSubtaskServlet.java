package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Subtask;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.models.enums.TaskPriority;
import com.fssa.freshtime.models.enums.TaskStatus;
import com.fssa.freshtime.services.TaskService;
import com.fssa.freshtime.utils.Logger;

/**
 * Servlet implementation class UpdateSubtaskServlet
 */
public class UpdateSubtaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		TaskService taskservice = new TaskService();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		
		// Get parameters from the form
		int subtaskId = Integer.parseInt(request.getParameter("subtaskId"));
        String subtaskName = request.getParameter("taskname");
        String subtaskDescription = request.getParameter("taskdescription");
        String notes = request.getParameter("notes");
        
        
        LocalDateTime startDate = null;
        TaskPriority priority = null;
        TaskStatus status = null;
        LocalDateTime reminder = null;
        
        try {
            String startDateParam = request.getParameter("startDate");
            String priorityParam = request.getParameter("priority");
            String statusParam = request.getParameter("status");
            String reminderParam = request.getParameter("reminder");
            
            if (startDateParam != null && !startDateParam.isEmpty()) {
                startDate = LocalDateTime.parse(startDateParam, formatter);
            }
            
            if (priorityParam != null && !priorityParam.isEmpty()) {
                priority = TaskPriority.valueOf(priorityParam);
            }
            
            if (statusParam != null && !statusParam.isEmpty()) {
                status = TaskStatus.valueOf(statusParam);
            }
            
            if (reminderParam != null && !reminderParam.isEmpty()) {
                reminder = LocalDateTime.parse(reminderParam, formatter);
            }
        }
        
        catch (DateTimeParseException | IllegalArgumentException e) {
            Logger.info(e.getMessage());
        }
        
        
        //Setting the subtask Object
        
        Subtask subtask = new Subtask();
        
        subtask.setSubtaskId(subtaskId);
        subtask.setSubtaskName(subtaskName);
        subtask.setStartDate(startDate);
        subtask.setPriority(priority);
        subtask.setStatus(status);
        subtask.setNotes(notes);
        subtask.setReminder(reminder);
        
        Logger.info(subtask);
        
        try {
        	taskservice.updateSubtask(subtask);
        	
        	request.setAttribute("success", subtask.getSubtaskName()+" Task Updated Successfully!");
        	
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
