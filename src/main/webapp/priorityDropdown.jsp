
<head>
	<style>
	
		.priority-dropdown{
			margin-top: -25px;
			margin-left: -5px;
		}
		
		.priorityBox{
			width: 400px;
			padding: 10px;
			border-radius: 8px;
			
		}
		
		.priorityBox:hover{
			background-color: #dbdbdb;
			color: #00b3f3;
			.selected-priority{
				color: white;
			}
		}
		
		.selected-priority {
		   	position: relative;
		    display: inline;
		   	padding-left: 20px;
		   	color: #A1A6AF;
		   }
		      
		.priority-dropdown-list {
		    list-style: none;
		    padding: 0;
		    margin: 0;
		    border: 1px solid #ccc;
		    width: 200px;
		    cursor: pointer;
		    display: none;
		}
		
		.priority-dropdown-list li {
		    padding: 10px;
		    font-size: 16px;
		    display: flex;
		    align-items: center;
		}
		
		.priority-dropdown .icon {
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		}
		
		.circle {
		    width: 20px;
		    height: 20px;
		    border-radius: 50%;
		    margin: -5px 8px;
		    background: linear-gradient(135deg, rgba(255, 255, 255, 0.2) 0%, rgba(0, 0, 0, 0.2) 100%);
		    display: inline-block;
		    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2); /* Add a shadow for depth */
		}
		
		.red-circle { background-color: red; }
		.orange-circle { background-color: orange; }
		.green-circle { background-color: green; }

    </style>
</head>
<body>
	
    <div class="priority-dropdown">
    	
    	<div class="priorityBox">
	    	<label class="priorityLabel" ><i class="fa-solid fa-bolt"></i> </label>
	        <p class="selected-priority">Add Priority</p>
	        <input type="hidden" id="priorityInput">
        </div>
        <ul class="priority-dropdown-list">
            <li data-value="HIGH" class="high-priority">
                <span class="circle red-circle"></span> High Priority
            </li>
            <li data-value="MID" class="mid-priority">
                <span class="circle orange-circle"></span> Mid Priority
            </li>
            <li data-value="LOW" class="low-priority">
                <span class="circle green-circle"></span> Low Priority
            </li>
        </ul>
        
    </div>

    <script>
    
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

    </script>
</body>

