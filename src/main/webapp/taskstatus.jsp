
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://kit.fontawesome.com/ee40c53027.js" crossorigin="anonymous" integrity=""></script>
<style>

	/* Style the dropdown  */
	.status-dropdown {
	    position: relative;
	    display: inline-block;
	}
	
	/* Style the list container */
	.dropdown-list {
	    list-style: none;
	    padding: 0;
	    margin: 0;
	    width: 200px; 
	    cursor: pointer;
	    display: none;
	    border-radius: 15px;
	    box-shadow: rgba(0, 0, 0, 0.15) 0px 3px 3px 0px;
	}
	
	/* Style the list items */
	.dropdown-list li {
	    padding: 10px 10px 10px 15px;
	    font-size: 20px;
	}
	
	.dropdown-list li:hover{
		background-color: #0028a1;
		color: white;
	}
	
	/* Style the icon */
	.custom-dropdown .icon {
	    position: absolute;
	    top: 50%;
	    right: 10px;
	    transform: translateY(-50%);
	}
	
	.dropdown-list i, .selected-option {
	    padding-right: 10px;
	    font-size: 20px;
	}

</style>
</head>
<body>
	<div class="status-dropdown">
        <div class="selected-option">
        	<input type="hidden" id="statusInput">
            <i class="fa-regular fa-square"></i>
        </div>
        <ul class="dropdown-list">
            <li data-value="TODO"><i class="fa-regular fa-square"></i>To Do</li>
            <li data-value="INPROGRESS"> <i class="fa-solid fa-play"></i> In Progress</li>
            <li data-value="COMPLETED"> <i class="fa-regular fa-circle-check"></i> Completed</li>
            <li data-value="BLOCKER"> <i class="fa-solid fa-circle-exclamation"></i>  Blocker</li>
            <li data-value="OVERDUE"> <i class="fa-solid fa-triangle-exclamation"></i> Overdue</li>
        </ul>
    </div>
    
    <script type="text/javascript">
    
	 	// Show task status options 
	    const dropdownList = document.querySelector(".dropdown-list");
	    const selectedOption = document.querySelector(".selected-option");
	    let statusInput = document.getElementById("statusInput").value;
	    
	    statusInput = "TODO";
	
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
	            statusInput = selectedValue;
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
    </script>
			    
</body>
