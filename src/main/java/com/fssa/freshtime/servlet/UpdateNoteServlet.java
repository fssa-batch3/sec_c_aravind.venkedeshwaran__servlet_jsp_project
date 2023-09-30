package com.fssa.freshtime.servlet;

import java.io.IOException;

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
 * Servlet implementation class UpdateNoteServlet
 */
public class UpdateNoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		Note editedNote = new Note();
		NoteService noteservice = new NoteService();
		
		String notesIdStr = request.getParameter("notesId");
		String editedHeading = request.getParameter("filename");
		String editedNotes = request.getParameter("content");
		
		int notesId = Integer.parseInt(notesIdStr);
		
		editedNote.setNotesId(notesId);
		editedNote.setHeading(editedHeading);
		editedNote.setNotes(editedNotes);
		
		System.out.println(notesId);
		System.out.println(editedHeading);
		System.out.println(editedNotes);
		
		try {
			boolean isUpdated = noteservice.updateNote(editedNote);
			if(isUpdated) {
				// request.getRequestDispatcher("NotesServlet");
				response.sendRedirect("NotesServlet");
			}
		} catch (ServiceException e) {
			Logger.info(e.getMessage());
		}
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
