package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

import com.fssa.freshtime.exceptions.InvalidInputException;
import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Task;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.TaskService;
import com.fssa.freshtime.utils.Logger;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		TaskService taskservice = new TaskService();

//		String action = request.getParameter("action");
		String startDateStr = request.getParameter("startdate");
		String endDateStr= request.getParameter("enddate");
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate today = LocalDate.now();
		

		try {
			
			User currentUser = (User) session.getAttribute("user");
			
			List<Task> tasks = taskservice.readAllTaskByUser(currentUser.getUserId());

			LocalDate startDate = null;
			LocalDate endDate = null;
			
			if(startDateStr == null && endDateStr == null) {
				startDate =  today.minusDays(6);
				endDate = today;
			}
			else {
		        startDate = LocalDate.parse(startDateStr, formatter);
		        endDate = LocalDate.parse(endDateStr, formatter);
			}

	        int dateRange = (int) ChronoUnit.DAYS.between(startDate, endDate)+1;
	        int[] totalTask = new int[dateRange];
	        int[] completedTask = new int[dateRange];
	        
	        int todoCount = 0;
	        int completedTaskCount = 0;
	        int inprogressTaskCount = 0;
	        int overdueTaskCount = 0;
	        int blockedTaskCount = 0;
	        

	        for (Task task : tasks) {
	            LocalDate taskStartDate = task.getStartDate().toLocalDate();
	            LocalDate taskEndDate = task.getEndDate().toLocalDate();
	            String taskStatus = task.getStatus().toString();

	            for (int i = 0; i < dateRange; i++) {
	                LocalDate currentDate = startDate.plusDays(i);
	                if ((currentDate.isEqual(taskStartDate) || currentDate.isEqual(taskEndDate))) {
	                    totalTask[i]++;
	                    
	                    if ("TODO".equals(taskStatus)) todoCount++;
	                    if ("INPROGRESS".equals(taskStatus)) inprogressTaskCount++;
	                    if ("COMPLETED".equals(taskStatus)) {
	                        completedTask[i]++;
	                        completedTaskCount++;
	                    }
	                    if ("OVERDUE".equals(taskStatus)) overdueTaskCount++;
	                    if ("BLOCKER".equals(taskStatus)) blockedTaskCount++;
	                    
	                }
	            }
	        }

	        System.out.println("Total Task = " + Arrays.toString(totalTask));
	        System.out.println("Completed Task = " + Arrays.toString(completedTask));
	        
	        JSONArray completedTaskArray = new JSONArray(completedTask);
	        JSONArray totalTaskArray = new JSONArray(totalTask);
	        
	        request.setAttribute("startdate", startDate.toString());
	        request.setAttribute("enddate", endDate.toString());
	        request.setAttribute("totalTask", totalTaskArray);
	        request.setAttribute("completedTask", completedTaskArray);
	        
	        request.setAttribute("todoCount", todoCount);
	        request.setAttribute("completedTaskCount", completedTaskCount);
	        request.setAttribute("inprogressTaskCount", inprogressTaskCount);
	        request.setAttribute("overdueTaskCount", overdueTaskCount);
	        request.setAttribute("blockedTaskCount", blockedTaskCount);
	        
	        request.getRequestDispatcher("report.jsp").forward(request, response);

		} catch (ServiceException | InvalidInputException e) {

			Logger.info(e.getMessage());
			e.printStackTrace();
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
