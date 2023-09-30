package com.fssa.freshtime.servlet;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Note;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.NoteService;
import com.fssa.freshtime.utils.Logger;

/**
 * Servlet implementation class NotesServlet
 */
public class NotesServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		NoteService noteservice = new NoteService();
		
		try {
			
			List<String> categories = noteservice.getAllCategory();
			request.setAttribute("getAllCategory", categories);
			
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			
			List<Note> allNotes = noteservice.readAllNotesByUser(user.getUserId());
			
			String searchTerm = request.getParameter("searchTerm");
			String category = request.getParameter("category");
			
			if(searchTerm != null && !"".equals(searchTerm)) {
				allNotes = allNotes.stream().filter(obj-> 
										obj.getNotes().toLowerCase().contains(searchTerm.toLowerCase()) || 
										obj.getHeading().toLowerCase().contains(searchTerm.toLowerCase()))
										.collect(Collectors.toList());
			}
			
			if (category != null && !"".equals(category)) {
			    allNotes = allNotes.stream()
			        .filter(obj -> {
			            String notesCategory = obj.getNotesCategory();
			            return notesCategory != null && notesCategory.toLowerCase().equals(category.toLowerCase());
			        })
			        .collect(Collectors.toList());
			}



			request.setAttribute("allNotes", allNotes);
			request.getRequestDispatcher("notesDashboard.jsp").forward(request, response);
			
			
		}
		catch(ServiceException e) {
			Logger.info(e.getMessage());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
