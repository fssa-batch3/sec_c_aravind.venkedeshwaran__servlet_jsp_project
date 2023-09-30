// Get DOM elements
const addtaskplus = document.getElementById("addtaskplus");
const addtaskpopup = document.querySelector(".addtaskpopup");
const taskpage = document.querySelector(".taskpage");
const cancel = document.getElementById("cancel");
const updatetask = document.getElementById("updatetask");
let taskList = document.querySelectorAll(".taskli"); // Use 'querySelectorAll' to select multiple elements

	
// Event handler for 'cancel' button click
cancel.onclick = function () {
  window.location.href = "TaskServlet";
};
	
const toggleChevronIcons = document.querySelectorAll('.toggle-chevron');

toggleChevronIcons.forEach(icon => {
    icon.addEventListener('click', function() {
        let subtaskliList = document.querySelectorAll('.subtasklist');
        subtaskliList.forEach(subtaskli => {
            if (subtaskli.style.display === 'block' || subtaskli.style.display === '') {
                subtaskli.style.display = 'none';
                icon.classList.remove('fa-chevron-down');
                icon.classList.add('fa-chevron-right');
            } else {
                subtaskli.style.display = 'block';
                icon.classList.remove('fa-chevron-right');
                icon.classList.add('fa-chevron-down');
            }
        });
    });
});



	
	
const form = document.getElementById('addtaskform');
const formFields = form.elements;
let inputElements = document.querySelectorAll("input");
let action;
	
	window.onload = function() {
        
        let urlParams = new URLSearchParams(window.location.search);
        action = urlParams.get("action");

        if (action === "edit" || action === "editsubtask") {
            showPopup();
        }
    }
	
	
	function showPopup(){
	    addtaskpopup.style.display = "block";
	    taskpage.style.filter = "blur(3px)";
	}
	

function setFormAction(formaction) {
    let form = document.getElementById("addtaskform");
    let taskId = document.getElementById("taskId").value;
	let subtaskId = document.getElementById("subtaskId").value;
	// let taskStatus = document.getElementById("statusInput").value;
	let startDate = document.getElementById("startDate").value;
	let endDate = document.getElementById("endDate").value;
	let priority = document.getElementById("priorityInput").value
	let reminder = document.getElementById("reminderInput").value;
	let notes = document.getElementById("notesFeild").value;

    if (formaction === 'save') {
        form.action = "AddTaskServlet";
    } 
    else if (formaction === 'update') {
		if(action === "editsubtask"){
			form.action = `UpdateSubtaskServlet?subtaskId=${subtaskId}`;
		}
		else{
			form.action = `UpdateTaskServlet?
				taskId=${taskId}&
				status=${statusInput}&
				startDate=${startDate}&
				endDate=${endDate}&
				priority=${priority}&
				reminder=${reminder}&
				notes=${notes}`;
		}
    }
    else if(formaction === 'delete'){
		if(action === "editsubtask"){
			form.action = `DeleteSubtaskServlet?subtaskId=${subtaskId}`;
		}
		else{
			form.action = `DeleteTaskServlet?taskId=${taskId}`;
		}
	}
    
    form.submit();
}

