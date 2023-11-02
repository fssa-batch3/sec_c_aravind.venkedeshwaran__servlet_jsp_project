<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@ page import="com.fssa.freshtime.models.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">


<title>Notes Dashboard</title>

<!-- ubuntu font link added -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
	rel="stylesheet">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Ubuntu&display=swap');
</style>


<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">

<!-- bootstrap for adding icon  -->
<script src="https://kit.fontawesome.com/ee40c53027.js"></script>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">

<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css'
	rel='stylesheet'>


<link rel="stylesheet" href="assets/css/notes.css">
<link rel="stylesheet" href="assets/css/sidebar.css">
</head>

<body>

	<div class="main">
		<div class="notespage">

			<jsp:include page="sidebar.jsp"></jsp:include>

			<div class="page-content container note-has-grid">

				<div class="notesHeader">
					<div>
						<p class="wish">
							Good Morning,
							<%=session.getAttribute("username")%><span class="dot">.</span>
						</p>
						<p class="quotes">When heart speaks take good notes.</p>

					</div>
					<form class="searchbar"
						action="<%=request.getContextPath()%>/NotesServlet">
						<input type="search" id="searchTerm" name="searchTerm" placeholder="search Notes"> 
						<button type="submit" class="searchbtn">Search</button>
					</form>
				</div>


				<ul
					class="nav nav-pills p-3 bg-white mb-3 rounded-pill align-items-center">
					<li class="nav-item">
						<!--The tag list starts Here. Just change the id dynamically and Text -->
						<a href="<%=request.getContextPath()%>/NotesServlet"
						class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2 active"
						id="all-category"> <i class="icon-layers mr-1"></i><span
							class="d-none d-md-block">All Notes</span>
					</a>
					</li>
					<%
					List<String> notesCategory = (List<String>) request.getAttribute("getAllCategory");

					for (String category : notesCategory) {
						if (category != null) {
					%>
					<li class="nav-item"><a
						href="<%=request.getContextPath()%>/NotesServlet?category=<%=category%>"
						class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2"
						id="note-business"> <i class="icon-briefcase mr-1"></i><span
							class="d-none d-md-block"><%=category%></span>
					</a></li>
					<%
					}
					}
					%>

				</ul>
				<div class="nav-item ml-auto addNotes">
					<a href="<%=request.getContextPath()%>/notesCreate.jsp"
						class="nav-link btn-primary rounded-pill d-flex align-items-center px-3"
						id="add-notes"> <i class="icon-note m-1"></i> <span
						class="d-none d-md-block font-14">Add Notes</span>
					</a>
				</div>



				<div class="tab-content bg-transparent">
				    <div id="note-full-container" class="note-has-grid row">
				        <%
				        List<Note> allNotes = (List<Note>) request.getAttribute("allNotes");
				        System.out.println(allNotes);
				        if (allNotes != null) {
				            for (Note note : allNotes) {
				        %>
				        <a href="notesCreate.jsp?notesId=<%= note.getNotesId() %>" class="col-md-4 single-note-item all-category">
				            <div class="card card-body">
				                <span class="side-stick"></span>
				                <h5 class="note-title text-truncate w-75 mb-0"><%= note.getHeading() %><i
				                        class="point fa fa-circle ml-1 font-10"></i>
				                </h5>
				                <p class="note-date font-12 text-muted"><%= note.getCreatedOn() %></p>
				
				                <div class="note-content">
				                    <p class="note-inner-content text-muted" id="notesContent"><%= note.getNotes() %></p>
				                </div>
				            </div>
				        </a>
				        <%
				        }
				        } else {
				        %>
				        <img alt="no notes img" src="assets/images/nonotes.png">
				        <%
				        }
				        %>
				    </div>
				</div>


			</div>
		</div>
	</div>
		<script>
		    // Function to convert HTML to plain text
		    function htmlToPlainText(html) {
		        const tempDiv = document.createElement('div');
		        tempDiv.innerHTML = html;
		        return tempDiv.textContent || tempDiv.innerText;
		    }
		
		    // Get all elements with the class .note-content
		    const notesContentList = document.querySelectorAll('.note-content');
		
		    // Iterate through all elements and convert HTML to plain text for each one
		    notesContentList.forEach(notesContent => {
		        const htmlContent = notesContent.innerHTML; // Assuming note.getNotes() returns HTML
		        notesContent.textContent = htmlToPlainText(htmlContent);
		    });
		</script>


</body>
</html>