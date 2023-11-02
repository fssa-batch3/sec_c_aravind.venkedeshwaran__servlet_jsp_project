const tasklists = document.querySelectorAll('#tasklist');

tasklists.forEach(tasklist => {
	const chevron = tasklist.querySelector('.toggle-chevron');
    const subtasklist = tasklist.querySelector('.subtasklist');

	chevron.addEventListener('click', () => {
		if(subtasklist.style.display === 'none'){
			subtasklist.style.display = 'block';
			chevron.classList.remove('fa-chevron-right');
            chevron.classList.add('fa-chevron-down');
		}
		else{
			subtasklist.style.display = 'none';
			chevron.classList.remove('fa-chevron-down');
            chevron.classList.add('fa-chevron-right');
		}
    });    
});



const addtaskpopup = document.querySelector(".addtaskpopup");
const taskpage = document.querySelector(".taskpage");
const cancel = document.getElementById("cancel");
const form = document.getElementById('addtaskform');
// const formFields = form.elements;
let inputElements = document.querySelectorAll("input");
let action;


// Event handler for 'cancel' button click
	cancel.onclick = function () {
	  window.location.href = "TaskServlet";
	};
	
	window.onload = function() {
        
        let urlParams = new URLSearchParams(window.location.search);
        action = urlParams.get("action");

		if (action === "edit" || action === "editsubtask") {
		    showPopup();
		    document.querySelector(".addtask").style.display = "none";
		    document.querySelector(".updatetask").style.display = "block";
		}

    }
    
    function showPopup(){
	    addtaskpopup.style.display = "block";
	    taskpage.style.filter = "blur(3px)";
	}
	
	document.getElementById("addtaskplus").onclick = showPopup;
	

// Show task status options 
    const dropdownList = document.querySelector(".dropdown-list");
    const selectedOption = document.querySelector(".selected-option");
    let statusInput = document.getElementById("statusInput");
    
    statusInput.value = "TODO";
	
	    // Toggle the dropdown on click
	    selectedOption.addEventListener("click", function () {
	        dropdownList.style.display = (dropdownList.style.display === "block") ? "none" : "block";
	    });
	
		// Handle option selection
		dropdownList.addEventListener("click", function (e) {
		    if (e.target.tagName === "LI") {
		        const selectedIconHTML = e.target.querySelector("i").outerHTML;
		        selectedOption.innerHTML = `${selectedIconHTML}`;
		        const selectedValue = e.target.getAttribute("data-value");
	            statusInput.value = selectedValue;
		        dropdownList.style.display = "none";
		        
		        console.log(statusInput);
		    }
		});
		
		// Close the dropdown when clicking outside
	    document.addEventListener("click", function (e) {
	        if (!selectedOption.contains(e.target) && e.target !== dropdownList) {
	            dropdownList.style.display = "none";
	        }
	    });
    
    


    
const priorityDropdownList = document.querySelector(".priority-dropdown-list");
const selectedPriority = document.querySelector(".selected-priority");
const priorityInput = document.getElementById("priorityInput");
    
    selectedPriority.addEventListener("click", function () {
        priorityDropdownList.style.display = (priorityDropdownList.style.display === "block") ? "none" : "block";
    });

 
    priorityDropdownList.addEventListener("click", function (e) {
        if (e.target.tagName === "LI") {
            const selectedPriorityValue = e.target.getAttribute("data-value");
            const selectedPriorityText = e.target.textContent;
            let circleClass;
            
            priorityInput.value = selectedPriorityValue;

            if (selectedPriorityValue === "HIGH") {
                circleClass = "red-circle";
            } else if (selectedPriorityValue === "MID") {
                circleClass = "orange-circle";
            } else if (selectedPriorityValue === "LOW") {
                circleClass = "green-circle";
            } else {
                circleClass = "gray-circle";
            }

            selectedPriority.innerHTML = `<span class="circle ${circleClass}"></span> ${selectedPriorityText}`;
            priorityDropdownList.style.display = "none";

        }
    });


    document.addEventListener("click", function (e) {
        if (!selectedPriority.contains(e.target) && e.target !== priorityDropdownList) {
            priorityDropdownList.style.display = "none";
        }
    });