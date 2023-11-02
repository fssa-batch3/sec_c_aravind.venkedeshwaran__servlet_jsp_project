package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

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
		String selectedDate = request.getParameter("selectedDate");
		
		List<Task> listTask =  null;

		try {

			User currentUser = (User) session.getAttribute("user");

			listTask = taskservice.readAllTaskByUser(currentUser.getUserId());
			
			request.setAttribute("listTask", listTask);
			
			List<Task> completedTasks = listTask.stream()
			        .filter(task -> !"COMPLETED".equals(task.getStatus().toString()))
			        .collect(Collectors.toList());
			
			request.setAttribute("todoTaskCount", completedTasks.size());
			

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
		
		if ("sort".equals(action)) {
			
		    String sort = request.getParameter("order");
		    String attribute = request.getParameter("attribute");

		    if ("ascending".equals(sort)) {
		        if ("taskname".equals(attribute)) {
		            Collections.sort(listTask, new Comparator<Task>() {
		                @Override
		                public int compare(Task task1, Task task2) {
		                    return task1.getTaskName().toLowerCase().compareTo(task2.getTaskName().toLowerCase());
		                }
		            });
		        } else if ("startdate".equals(attribute)) {
		        	Collections.sort(listTask, new Comparator<Task>() {
		        	    @Override
		        	    public int compare(Task task1, Task task2) {
		        	        LocalDateTime startDate1 = task1.getStartDate();
		        	        LocalDateTime startDate2 = task2.getStartDate();
		        	        
		        	        // Handle null values
		        	        if (startDate1 == null && startDate2 == null) {
		        	            return 0;
		        	        } else if (startDate1 == null) {
		        	            return 1; // Consider null as greater (move to the end)
		        	        } else if (startDate2 == null) {
		        	            return -1; // Consider null as greater (move to the end)
		        	        } else {
		        	            return startDate1.compareTo(startDate2);
		        	        }
		        	    }
		        	});

		        } else if ("enddate".equals(attribute)) {
		        	Collections.sort(listTask, new Comparator<Task>() {
		        	    @Override
		        	    public int compare(Task task1, Task task2) {
		        	        LocalDateTime endDate1 = task1.getEndDate();
		        	        LocalDateTime endDate2 = task2.getEndDate();
		        	        
		        	        // Handle null values
		        	        if (endDate1 == null && endDate2 == null) {
		        	            return 0;
		        	        } else if (endDate1 == null) {
		        	            return 1; // Consider null as greater (move to the end)
		        	        } else if (endDate2 == null) {
		        	            return -1; // Consider null as greater (move to the end)
		        	        } else {
		        	            return endDate1.compareTo(endDate2);
		        	        }
		        	    }
		        	});
		        } else if ("priority".equals(attribute)) {
		        	
		        	Collections.sort(listTask, new Comparator<Task>() {
		        	    @Override
		        	    public int compare(Task task1, Task task2) {
		        	        String priority1 = task1.getPriority() != null ? task1.getPriority().toString() : null;
		        	        String priority2 = task2.getPriority() != null ? task2.getPriority().toString() : null;

		        	        // Handle null values
		        	        if (priority1 == null && priority2 == null) {
		        	            return 0;
		        	        } else if (priority1 == null) {
		        	            return 1; // Consider null as greater (move to the end)
		        	        } else if (priority2 == null) {
		        	            return -1; // Consider null as greater (move to the end)
		        	        } else {
		        	            // Define a priority order
		        	            int priorityOrder1 = getPriorityOrder(priority1);
		        	            int priorityOrder2 = getPriorityOrder(priority2);

		        	            // Compare based on the priority order
		        	            return Integer.compare(priorityOrder1, priorityOrder2);
		        	        }
		        	    }

		        	    private int getPriorityOrder(String priority) {
		        	        switch (priority) {
		        	            case "LOW":
		        	                return 1;
		        	            case "MID":
		        	                return 2;
		        	            case "HIGH":
		        	                return 3;
		        	            default:
		        	                return 0; // Handle unknown priorities (if any)
		        	        }
		        	    }
		        	});

		        	
		        }
		    } else if ("descending".equals(sort)) {
		        if ("taskname".equals(attribute)) {
		            Collections.sort(listTask, new Comparator<Task>() {
		                @Override
		                public int compare(Task task1, Task task2) {
		                    return task2.getTaskName().toLowerCase().compareTo(task1.getTaskName().toLowerCase());
		                }
		            });
		        } else if ("startdate".equals(attribute)) {
		        	Collections.sort(listTask, new Comparator<Task>() {
		        	    @Override
		        	    public int compare(Task task1, Task task2) {
		        	        LocalDateTime startDate1 = task1.getStartDate();
		        	        LocalDateTime startDate2 = task2.getStartDate();
		        	        
		        	        // Handle null values
		        	        if (startDate1 == null && startDate2 == null) {
		        	            return 0;
		        	        } else if (startDate1 == null) {
		        	            return 1; // Consider null as greater (move to the end)
		        	        } else if (startDate2 == null) {
		        	            return -1; // Consider null as greater (move to the end)
		        	        } else {
		        	            return startDate2.compareTo(startDate1);
		        	        }
		        	    }
		        	});
		        } else if ("enddate".equals(attribute)) {
		        	
		        	Collections.sort(listTask, new Comparator<Task>() {
		        	    @Override
		        	    public int compare(Task task1, Task task2) {
		        	        LocalDateTime endDate1 = task1.getEndDate();
		        	        LocalDateTime endDate2 = task2.getEndDate();
		        	        
		        	        // Handle null values
		        	        if (endDate1 == null && endDate2 == null) {
		        	            return 0;
		        	        } else if (endDate1 == null) {
		        	            return 1; // Consider null as greater (move to the end)
		        	        } else if (endDate2 == null) {
		        	            return -1; // Consider null as greater (move to the end)
		        	        } else {
		        	            return endDate2.compareTo(endDate1);
		        	        }
		        	    }
		        	});
		        	
		        } else if ("priority".equals(attribute)) {
		            
		        	Collections.sort(listTask, new Comparator<Task>() {
		        	    @Override
		        	    public int compare(Task task1, Task task2) {
		        	        String priority1 = task1.getPriority() != null ? task1.getPriority().toString() : null;
		        	        String priority2 = task2.getPriority() != null ? task2.getPriority().toString() : null;

		        	        // Handle null values
		        	        if (priority1 == null && priority2 == null) {
		        	            return 0;
		        	        } else if (priority1 == null) {
		        	            return 1; // Consider null as greater (move to the end)
		        	        } else if (priority2 == null) {
		        	            return -1; // Consider null as greater (move to the end)
		        	        } else {
		        	            // Define a priority order
		        	            int priorityOrder1 = getPriorityOrder(priority1);
		        	            int priorityOrder2 = getPriorityOrder(priority2);

		        	            // Compare based on the priority order
		        	            return Integer.compare(priorityOrder2, priorityOrder1);
		        	        }
		        	    }

		        	    private int getPriorityOrder(String priority) {
		        	        switch (priority) {
		        	            case "LOW":
		        	                return 1;
		        	            case "MID":
		        	                return 2;
		        	            case "HIGH":
		        	                return 3;
		        	            default:
		        	                return 0; // Handle unknown priorities (if any)
		        	        }
		        	    }
		        	});
		        	
		        }
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
