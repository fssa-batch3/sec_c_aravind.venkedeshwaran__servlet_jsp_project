package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

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
		
		RequestDispatcher rd = null;
		HttpSession session = request.getSession();
		
        // Retrieve form data
		User curUser = (User) session.getAttribute("user");
		
		String email = curUser.getEmailId();
		
		String action = request.getParameter("action");
        String userName = request.getParameter("username");
        String oldpass = "";
        String newpass = "";

        if (oldpass != null || !oldpass.isEmpty()) {
        	oldpass = request.getParameter("oldpass");
        }

        if (newpass != null || !newpass.isEmpty()) {
        	newpass = request.getParameter("newpass");
        }
        
        System.out.println(email);
        System.out.println(userName);
        System.out.println(oldpass);
        System.out.println(newpass);
        
        
        // Create a User object with updated profile information
        User updatedUser = new User();
        updatedUser.setUserName(userName);
        updatedUser.setPassword(newpass);
        updatedUser.setEmailId(email);
        
        // Update the user profile using the UserService
        UserService userService = new UserService();
        try {
            if(action.equals("changename")) {
            	boolean updated = userService.changeUserName(email, userName);
            	
            	if(updated) {
					request.setAttribute("success", "Successfully User Name Changed");
		        	request.setAttribute("path", "ProfileServlet");
		        	rd = request.getRequestDispatcher("ProfileServlet");
            	}
                else {
                	request.setAttribute("error", "Error While Changing User Name");
                	request.setAttribute("path", "ProfileServlet");
		        	rd = request.getRequestDispatcher("ProfileServlet");
                }
            }
            if(action.equals("changepass")) {
            	
            	if(!oldpass.equals(newpass)) {
            	
	    			User user = userService.getUserByEmail(email);
	    			
	    			if (BCrypt.checkpw(oldpass, user.getPassword())) {
	    				userService.changePassword(email, newpass);
	    				request.setAttribute("success", "Successfully User Name Changed");
	    				request.setAttribute("path", "ProfileServlet");
			        	rd = request.getRequestDispatcher("ProfileServlet");
	    			}
	    			 else {
		            	request.setAttribute("error", "Old Password is not matching to your previous password");
		            	request.setAttribute("path", "ProfileServlet");
			        	rd = request.getRequestDispatcher("ProfileServlet");
		            }
	            }else {
	            	request.setAttribute("error", "Old Password and New Password Can not be same");
	            	request.setAttribute("path", "ProfileServlet");
		        	rd = request.getRequestDispatcher("ProfileServlet");
	            }
            }

        } catch (ServiceException e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
        }
        finally {
        	rd.forward(request, response);
		}
        
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
