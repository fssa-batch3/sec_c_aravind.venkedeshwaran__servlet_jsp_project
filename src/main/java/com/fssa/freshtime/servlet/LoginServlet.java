package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.UserService;
import com.fssa.freshtime.utils.Logger;

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

		UserService userService = new UserService();

		HttpSession session = request.getSession();

		String emailIdLogin = request.getParameter("emaillogin");
		String passwordLogin = request.getParameter("passwordlogin");

		try {

			User user = userService.getUserByEmail(emailIdLogin);
			

			if (BCrypt.checkpw(passwordLogin, user.getPassword())) {
				
				session.setAttribute("username", user.getUserName());

				session.setAttribute("user", user);

				request.setAttribute("success", "Logged In Success");
				request.setAttribute("path", "TaskServlet");
				rd = request.getRequestDispatcher("TaskServlet");

				
			} else {
				
				request.setAttribute("error", "Incorrect Password!!!");
				request.setAttribute("path", "TaskServlet");
				rd = request.getRequestDispatcher("/signup.jsp");
				
			}

		} catch (ServiceException e) {

			System.out.println(e.getMessage());

			e.printStackTrace();

			request.setAttribute("error", e.getMessage());
			request.setAttribute("path", "TaskServlet");
			rd = request.getRequestDispatcher("/signup.jsp");
		}
		finally {
			rd.forward(request, response);
		}
	}
}
