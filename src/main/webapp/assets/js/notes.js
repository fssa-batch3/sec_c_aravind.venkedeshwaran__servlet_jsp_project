let notesId;
let form = document.getElementById("noteForm");

form.addEventListener('submit', function() {
	// Get the content from the contenteditable div
	let contentDiv = document.getElementById('content');

	// Set the content as the value of the hidden input field
	document.getElementById('contentValue').value = contentDiv.innerHTML;
	
});

window.onload = function() {
	// Get the value of the "action" parameter from the URL
	let urlParams = new URLSearchParams(window.location.search);
	notesId = urlParams.get("notesId");

	if (notesId > 0) {
		document.getElementById("savenotes").style.display = "none";
		document.getElementById("updatenotes").style.display = "block";
	}
	
	
	
	
}



function setFormAction(action) {
	

	if (action === 'save') {
		form.action = "SaveNoteServlet";
	}
	else if (action === 'update') {
		form.action = `UpdateNoteServlet?notesId=${notesId}`;
	}
	else if(action === 'delete'){
		form.action = `DeleteNoteServlet?notesId=${notesId}`;
	}

	// Submit the form
	form.submit();
}


function formatDoc(cmd, value = null) {
	if (value) {
		document.execCommand(cmd, false, value);
	} else {
		document.execCommand(cmd);
	}
}

function addLink() {
	const url = prompt('Insert url');
	formatDoc('createLink', url);
}




let content = document.getElementById('content');

content.addEventListener('mouseenter', function() {
	const a = content.querySelectorAll('a');
	a.forEach(item => {
		item.addEventListener('mouseenter', function() {
			content.setAttribute('contenteditable', false);
			item.target = '_blank';
		})
		item.addEventListener('mouseleave', function() {
			content.setAttribute('contenteditable', true);
		})
	})
})






const filename = document.getElementById('filename');

function fileHandle(value) {
	if (value === 'new') {
		content.innerHTML = '';
		filename.value = 'untitled';
	} else if (value === 'txt') {
		const blob = new Blob([content.innerText])
		const url = URL.createObjectURL(blob)
		const link = document.createElement('a');
		link.href = url;
		link.download = `${filename.value}.txt`;
		link.click();
	} else if (value === 'pdf') {
		html2pdf(content).save(filename.value);
	}
}











