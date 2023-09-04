package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.DAOException;
import com.fssa.freshtime.exceptions.InvalidInputException;
import com.fssa.freshtime.services.UserService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;
	UserService userservice = new UserService();
	

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        
        RequestDispatcher rd = null;

        String emailIdLogin = request.getParameter("emaillogin");
        String passwordLogin = request.getParameter("passwordlogin");

        try {
            // Validate and check user in the database
            userservice.userLogin(emailIdLogin, passwordLogin);
            
//			store data in session
			HttpSession session = request.getSession();
			session.setAttribute("Logedinemail", emailIdLogin);
			session.setAttribute("Logedinpassword", passwordLogin);
			
			request.setAttribute("loginSuccess", "Logged In Success");
			
			rd = request.getRequestDispatcher("TaskServlet");
			
			
            
        } 
        catch (InvalidInputException | DAOException | SQLException e) {
        	
        	System.out.println(e.getMessage());

			e.printStackTrace();
			
			request.setAttribute("loginError", e.getMessage());
			
			rd = request.getRequestDispatcher("/signup.jsp");
            
        }
        finally {
        	 
        	rd.forward(request, response);
        }
    }
}
