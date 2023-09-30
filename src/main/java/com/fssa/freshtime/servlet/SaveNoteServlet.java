package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.models.Note;
import com.fssa.freshtime.models.User;
import com.fssa.freshtime.services.NoteService;
import com.fssa.freshtime.utils.Logger;

@WebServlet("/SaveNoteServlet")
public class SaveNoteServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        String title = request.getParameter("filename");
        String content = request.getParameter("content");

        User user = (User) session.getAttribute("user");
        
        Note note = new Note();
        if(user != null) {
        	note.setUserId(user.getUserId());
        }
        else {
        	Logger.info("user is null");
        }
        note.setHeading(title);
        note.setNotes(content);
        
        NoteService noteservice = new NoteService();
        
        try {
			noteservice.createNote(note);
		} catch (ServiceException e) {
			System.out.println(e.getMessage());
		}
        
        response.sendRedirect("NotesServlet");
    }
}
