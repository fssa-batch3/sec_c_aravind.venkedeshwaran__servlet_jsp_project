package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.DAOException;
import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.services.UserService;

@WebServlet("/DeleteProfileServlet")
public class DeleteProfileServlet extends HttpServlet {

	private static final long serialVersionUID = -375167099813074757L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

		HttpSession session = request.getSession();
        String email = (String) session.getAttribute("Logedinemail");
        
        
        // Calling the UserService to delete the user's profile
        UserService userService = new UserService();
        try {
            boolean deleted = userService.deleteUser(email);
            if (deleted) {
            	request.setAttribute("success", "Successfuly profile deleted");
                request.getSession().invalidate();
                request.setAttribute("success", "Successfully profile deleted!");
                response.sendRedirect("index.jsp"); 
                
            } else {

                request.setAttribute("error", "Failed to delete profile");
                request.getRequestDispatcher("ProfileServlet").forward(request, response);
            }
        } catch (ServiceException e) {

            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("ProfileServlet").forward(request, response);
        }
    }
}
