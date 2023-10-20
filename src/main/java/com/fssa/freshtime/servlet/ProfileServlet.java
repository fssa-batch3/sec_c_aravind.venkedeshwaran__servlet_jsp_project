package com.fssa.freshtime.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.UserService;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	
	
	private static final long serialVersionUID = 1L;
	
	UserService userService = new UserService();       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 HttpSession session = request.getSession();
	        User currentUser = (User) session.getAttribute("user");
	        
	        String email = currentUser.getEmailId();
	        
	        if (email != null) {
	                
	            session.setAttribute("username", currentUser.getUserName());// used to easily import the name which show in the task page
	            
	            session.setAttribute("user", currentUser);
	            
	            request.setAttribute("success", "Logged In Success");
	                
	            request.getRequestDispatcher("/profile.jsp").forward(request, response);
	                
	            
	        } else {
	            System.out.println("email is null");
	        }
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
