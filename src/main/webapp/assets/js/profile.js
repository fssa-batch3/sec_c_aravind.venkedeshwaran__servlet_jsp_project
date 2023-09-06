//  enable and disable input for edit and update operation
function enableEdit() {
	document.getElementById("name").disabled = false;
	document.getElementById("password").disabled = false;
}


function setFormAction(action) {
	var form = document.getElementById("profileform");

	if (action === 'update') {
		form.action = "UpdateProfileServlet";
	}
	else if (action === 'delete') {
		enableEdit();
		form.action = `DeleteProfileServlet`;
	}

	// Submit the form
	form.submit();
}

function logout() {
        window.location.href = "index.jsp";
    }