package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Subtask;
import com.fssa.freshtime.models.enums.TaskPriority;
import com.fssa.freshtime.models.enums.TaskStatus;
import com.fssa.freshtime.services.TaskService;
import com.fssa.freshtime.utils.Logger;

/**
 * Servlet implementation class UpdateSubtaskServlet
 */
@WebServlet("/UpdateSubtaskServlet")
public class UpdateSubtaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		TaskService taskservice = new TaskService();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		

		int subtaskId = Integer.parseInt(request.getParameter("subtaskId"));
        String subtaskName = request.getParameter("taskname");
        
        
        LocalDateTime startDate = null;
		String startDateParam = request.getParameter("startDate");
		if (startDateParam != null && !startDateParam.isEmpty()) {
			startDate = LocalDateTime.parse(startDateParam, formatter);
		}

		LocalDateTime endDate = null;
		String endDateParam = request.getParameter("endDate");
		if (endDateParam != null && !endDateParam.isEmpty()) {
			endDate = LocalDateTime.parse(endDateParam, formatter);
		}

		TaskPriority priority = null;
		String priorityParam = request.getParameter("priority");
		if (priorityParam != null && !priorityParam.isEmpty()) {
			priority = TaskPriority.valueOf(priorityParam);
		}

		TaskStatus status = null;
		String statusParam = request.getParameter("status");
		if (statusParam != null && !statusParam.isEmpty()) {
			status = TaskStatus.valueOf(statusParam);
		}
		else {
			status = TaskStatus.TODO;
		}

		LocalDateTime reminder = null;
		String reminderParam = request.getParameter("reminder");
		if (reminderParam != null && !reminderParam.isEmpty()) {
			reminder = LocalDateTime.parse(reminderParam, formatter);
		}

		String notes = request.getParameter("notes");
		
		if(startDate != null && endDate == null) {
			endDate = startDate.plusDays(1);
		}
        
        
        //Setting the subtask Object
        
        Subtask subtask = new Subtask();
        
        subtask.setSubtaskId(subtaskId);
        subtask.setSubtaskName(subtaskName);
        subtask.setStartDate(startDate);
        subtask.setEndDate(endDate);
        subtask.setPriority(priority);
        subtask.setStatus(status);
        subtask.setReminder(reminder);
        subtask.setNotes(notes);
        
        
        Logger.info(subtask);
        
        try {
        	taskservice.updateSubtask(subtask);
        	
        	request.setAttribute("success", subtask.getSubtaskName()+" Task Updated Successfully!");
        	
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

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
