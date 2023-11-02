<!DOCTYPE html>
<%@page import="com.fssa.freshtime.services.NoteService"%>
<html lang="en">
<%@page import="com.fssa.freshtime.models.Note"%>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- web page title  -->
<title>FRESHTIME | Notes</title>

<!-- style sheet added -->
<link rel="stylesheet" href="assets/css/sidebar.css">
<link rel="stylesheet" href="assets/css/notes.css">
<link rel="stylesheet" href="assets/css/notify.css">

<!-- adding favicon -->
<link rel="icon" type="image/x-icon" sizes="16x16 32x32"
	href="../assets/Images/favicon.png">

<!-- ubuntu font link added -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
	rel="stylesheet">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Ubuntu&display=swap');
</style>

<!-- bootstrap for adding icon  -->
<script src="https://kit.fontawesome.com/ee40c53027.js"
	crossorigin="anonymous" integrity="">
	
</script>
<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css'
	rel='stylesheet'>

</head>

<body>
	<div class="main">

		<jsp:include page="sidebar.jsp"></jsp:include>

		<div class="noteseditor">



			<div class="toolbar">
				<div class="head">

					<select onchange="fileHandle(this.value); this.selectedIndex=0">
						<option value="" selected="" hidden="" disabled="">File</option>
						<option value="new">New file</option>
						<option value="txt">Save as txt</option>
						<option value="pdf">Save as pdf</option>
					</select> <select
						onchange="formatDoc('formatBlock', this.value); this.selectedIndex=0;">
						<option value="" selected="" hidden="" disabled="">Format</option>
						<option value="h1">Heading 1</option>
						<option value="h2">Heading 2</option>
						<option value="h3">Heading 3</option>
						<option value="h4">Heading 4</option>
						<option value="h5">Heading 5</option>
						<option value="h6">Heading 6</option>
						<option value="p">Paragraph</option>
					</select> <select
						onchange="formatDoc('fontSize', this.value); this.selectedIndex=0;">
						<option value="" selected="" hidden="" disabled="">Font
							size</option>
						<option value="1">Extra small</option>
						<option value="2">Small</option>
						<option value="3">Regular</option>
						<option value="4">Medium</option>
						<option value="5">Large</option>
						<option value="6">Extra Large</option>
						<option value="7">Big</option>
					</select>
					<div class="color">
						<span>Color</span> <input type="color"
							oninput="formatDoc('foreColor', this.value); this.value='#000000';">
					</div>
					<div class="color">
						<span>Background</span> <input type="color"
							oninput="formatDoc('hiliteColor', this.value); this.value='#000000';">
					</div>

				</div>
				<div class="btn-toolbar">
					<button onclick="formatDoc('undo')">
						<i class='bx bx-undo'></i>
					</button>
					<button onclick="formatDoc('redo')">
						<i class='bx bx-redo'></i>
					</button>
					<button onclick="formatDoc('bold')">
						<i class='bx bx-bold'></i>
					</button>
					<button onclick="formatDoc('underline')">
						<i class='bx bx-underline'></i>
					</button>
					<button onclick="formatDoc('italic')">
						<i class='bx bx-italic'></i>
					</button>
					<button onclick="formatDoc('strikeThrough')">
						<i class='bx bx-strikethrough'></i>
					</button>
					<button onclick="formatDoc('justifyLeft')">
						<i class='bx bx-align-left'></i>
					</button>
					<button onclick="formatDoc('justifyCenter')">
						<i class='bx bx-align-middle'></i>
					</button>
					<button onclick="formatDoc('justifyRight')">
						<i class='bx bx-align-right'></i>
					</button>
					<button onclick="formatDoc('justifyFull')">
						<i class='bx bx-align-justify'></i>
					</button>
					<button onclick="formatDoc('insertOrderedList')">
						<i class='bx bx-list-ol'></i>
					</button>
					<button onclick="formatDoc('insertUnorderedList')">
						<i class='bx bx-list-ul'></i>
					</button>
					<button onclick="addLink()">
						<i class='bx bx-link'></i>
					</button>
					<button onclick="formatDoc('unlink')">
						<i class='bx bx-unlink'></i>
					</button>
				</div>
			</div>


			<form id="noteForm" method="POST">

				<%
				NoteService noteservice = new NoteService();
				String notesIdStr = (String) request.getParameter("notesId");
				Note note = null;
				if (notesIdStr != null) {
					int notesId = Integer.parseInt(notesIdStr);
					note = noteservice.readNotesByNotesId(notesId);
				}
				%>


				<input type="text" placeholder="Title" id="filename" name="filename"
					value="<%=(note != null) ? note.getHeading() : ""%>" required>

				<div id="content" contenteditable="true" spellcheck="true"
					placeholder="Type Your Notes Here"><%=(note != null) ? note.getNotes() : ""%></div>
				<input type="text" id="contentValue" name="content">

				<button type="submit" id="savenotes" onclick="setFormAction('save')">Save</button>
				<button type="submit" id="updatenotes" onclick="setFormAction('update')">Update</button>
				<button type="button" id="deletenotes" onclick="setFormAction('delete')">Delete</button>

			</form>

		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"
		integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.3.1/purify.min.js"></script>

	<script src="assets/js/notes.js"></script>
</html>