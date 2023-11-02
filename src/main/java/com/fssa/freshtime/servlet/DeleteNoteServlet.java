package com.fssa.freshtime.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.freshtime.exceptions.ServiceException;
import com.fssa.freshtime.services.NoteService;

/**
 * Servlet implementation class DeleteNoteServlet
 */
public class DeleteNoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		
		NoteService notesservice = new NoteService();
		
		int notesId = Integer.parseInt(request.getParameter("notesId"));
		
		try {
			notesservice.deleteNotes(notesId);
			
			request.setAttribute("error", "Notes Deleted Successfully!");
        	
        	request.setAttribute("path", "NotesServlet");
        	
        	rd = request.getRequestDispatcher("NotesServlet");
			
        }	
        catch(ServiceException e) {
        	
        	System.out.println(e.getMessage());
        	e.printStackTrace();
        	
		    request.setAttribute("error", e.getMessage());
		    
		    request.setAttribute("path", "NotesServlet");
			
			rd = request.getRequestDispatcher("NotesServlet");
            
        }
        finally {
        	 
        	rd.forward(request, response);
        }
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}



}
