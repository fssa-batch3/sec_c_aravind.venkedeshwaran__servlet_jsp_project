package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.UserService;

/**
 * Servlet implementation class SignUpServlet
 */
@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	UserService userservice = new UserService();

	RequestDispatcher rd = null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter out = response.getWriter();

//		get the user name, email, password in the request object
		String username = (String) request.getParameter("username");
		String emailId = (String) request.getParameter("emailId");
		String password = (String) request.getParameter("password");

//		set the attribute in the user object
		User user = new User();
		user.setEmailId(emailId);
		user.setUserName(username);
		user.setPassword(password);

		try {

//			validate the attributes 
			userservice.userSignUp(user);

			request.setAttribute("success", "Signed Up Successfully!");

			rd = request.getRequestDispatcher("/signup.jsp");

		} catch (ServiceException e) {

			request.setAttribute("error", e.getMessage());

			rd = request.getRequestDispatcher("/signup.jsp");
			// response.sendRedirect("/signup.jsp");

			System.out.println(e.getMessage());

			e.printStackTrace();
		} finally {

			rd.forward(request, response);
		}

	}

}
