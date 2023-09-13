package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.ServiceException;
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


		RequestDispatcher rd = null;

		String emailIdLogin = request.getParameter("emaillogin");
		String passwordLogin = request.getParameter("passwordlogin");

		try {
			// Validate and check user in the database
			boolean isLogedIn = userservice.userLogin(emailIdLogin, passwordLogin);

			if(isLogedIn) {

				HttpSession session = request.getSession();
				session.setAttribute("Logedinemail", emailIdLogin);

	
				request.setAttribute("loginSuccess", "Logged In Success");
	
	
				rd = request.getRequestDispatcher("ProfileServlet");

			}
			else {
				request.setAttribute("invalidCredentials", "Invalid Credentials: email or password is wrong");
				rd = request.getRequestDispatcher("/signup.jsp");
			}


		} catch (ServiceException e) {

			System.out.println(e.getMessage());

			e.printStackTrace();

			request.setAttribute("loginError", e.getMessage());


			rd = request.getRequestDispatcher("/signup.jsp");

		} finally {

			rd.forward(request, response);

		}
	}
}
