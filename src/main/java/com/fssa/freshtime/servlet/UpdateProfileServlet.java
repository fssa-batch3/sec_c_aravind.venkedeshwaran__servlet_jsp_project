package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.UserService;
import com.mysql.cj.Session;

/**
 * Servlet implementation class UpdateProfileServlet
 */
public class UpdateProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
        // Retrieve form data
		String email = (String) session.getAttribute("Logedinemail");
        String userName = request.getParameter("username");
        String password = request.getParameter("userPassword");
        
        System.out.println(email);
        System.out.println(userName);
        System.out.println(password);
        
        
        // Create a User object with updated profile information
        User updatedUser = new User();
        updatedUser.setUserName(userName);
        updatedUser.setPassword(password);
        updatedUser.setEmailId(email);
        
        // Update the user profile using the UserService
        UserService userService = new UserService();
        try {
            boolean updated = userService.updateUserProfile(updatedUser);
            if (updated) {
                request.setAttribute("success", "Profile updated successfully");
            } else {
                request.setAttribute("error", "Failed to update profile");
            }
        } catch (ServiceException e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("ProfileServlet").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
