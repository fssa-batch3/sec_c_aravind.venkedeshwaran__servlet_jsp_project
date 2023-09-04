// Get DOM elements
const addtaskplus = document.getElementById("addtaskplus");
const addtaskpopup = document.querySelector(".addtaskpopup");
const taskpage = document.querySelector(".taskpage");
const savetask = document.getElementById("savetask");
const cancel = document.getElementById("cancel");
const updatetask = document.getElementById("updatetask");
let taskList = document.querySelectorAll(".taskli"); // Use 'querySelectorAll' to select multiple elements

// Event handler for 'addtaskplus' button click
	addtaskplus.onclick = () => {
	  addtaskpopup.style.display = "block";
	  taskpage.style.filter = "blur(3px)";
	};
	
// Event handler for 'cancel' button click
	cancel.onclick = function () {
	  addtaskpopup.style.display = "none";
	  taskpage.style.filter = "none";
	};
	
	
const editButton = document.getElementById('editButton');
const form = document.getElementById('addtaskform');
const formFields = form.elements;
let inputElements = document.querySelectorAll("input");

	
	window.onload = function() {
        // Get the value of the "action" parameter from the URL
        var urlParams = new URLSearchParams(window.location.search);
        var action = urlParams.get("action");

        // Check if the "action" parameter is "edit" and invoke the function
        if (action === "edit") {
            showPopup();
        }
    }
	
	
	function showPopup(){
	    addtaskpopup.style.display = "block";
	    taskpage.style.filter = "blur(3px)";

		inputElements.forEach(function(inputElement) {
		    inputElement.disabled = true;
		});
	}
	
	



	

	
// Event listener for the 'editButton' click
	editButton.addEventListener('click', toggleEditMode);
	
// Event listener for form submission
	form.addEventListener('submit', function (event) {
	  event.preventDefault();
	  toggleEditMode();
	});
	
// Function to toggle edit mode for form fields
	function toggleEditMode() {
	  inputElements.forEach(function(inputElement) {
		    inputElement.disabled = false;
		});
	}
	
// Event listener for 'editButton' click to display 'updatetask'
	editButton.addEventListener('click', function(){
	  savetask.style.display = "none";
	  updatetask.style.display = "block";
	});
	
	
	let taskId = document.getElementById("taskId").value;
	
	function setFormAction(action) {
    var form = document.getElementById("addtaskform");
    
    if (action === 'save') {
        form.action = "AddTaskServlet";
    } 
    else if (action === 'update') {
        form.action = `UpdateTaskServlet?taskId=${taskId}`;
    }
    else if(action === 'delete'){
		form.action = `DeleteTaskServlet?taskId=${taskId}`;
	}
    
    // Submit the form
    form.submit();
}