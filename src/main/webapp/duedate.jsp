<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">

<style>
    .form-control:disabled, .form-control[readonly] {
        background-color: transparent;
    }
    .form-control{
    	width: 250px;
    	border: none;
    	display: inline;
    	padding-left: 20px;
    }

	
  	#startDate, #endDate{
		border: none;
		width: 200px;
		height: 30px;
		margin-left: 15px;
		margin-top: 10px;
		border-radius: 5px;
	}
	
	.startDate-group:hover, .endDate-group:hover{
		background-color: #dbdbdb;
		border-radius: 5px;
		color: white;
	}
      
	#line{
		width: 4px;
		height: 25px;
		background-color: black;
		margin: 2px 0px 2px 5.5px;
		border-radius: 5px;
		 
		
	}
	.startDate-group{
		margin-bottom: -20px;
	}
	.endDate-group{
		margin-top: -15px;
	}
	


  </style>
</head>
<body>
    <div class="dueDateBox">
    
        <div class="startDate-group">
            <label for="startDate" id="startDateLabel">
            <svg xmlns="http://www.w3.org/2000/svg" width="48" height="50" viewBox="0 0 48 50" style="width: 18px;"><path data-name="Calendar Date" d="M40 50H8a8 8 0 01-8-8V14a8 8 0 018-8h4V1.5A1.5 1.5 0 0113.5 0h3A1.5 1.5 0 0118 1.5V6h12V1.5A1.5 1.5 0 0131.5 0h3A1.5 1.5 0 0136 1.5V6h4a8 8 0 018 8v28a8 8 0 01-8 8zm2-36a2 2 0 00-2-2H8a2 2 0 00-2 2v28a2 2 0 002 2h32a2 2 0 002-2V14zM20.5 28h-7a1.5 1.5 0 01-1.5-1.5v-7a1.5 1.5 0 011.5-1.5h7a1.5 1.5 0 011.5 1.5v7a1.5 1.5 0 01-1.5 1.5z" fill-rule="evenodd"></path></svg>
            </label>
            <input id="startDate" type="datetime-local" placeholder="Set Start Date" />
            <input type="hidden" id="startDateJs" name="startDate">
        </div>
        
        <p id="line"></p>
        
        <div class="endDate-group">
            <label for="endDate">
				<svg xmlns="http://www.w3.org/2000/svg" width="48" height="50" viewBox="0 0 48 50" style="width: 18px;"><path data-name="Calendar End Date" d="M40 50H8a8 8 0 01-8-8V14a8 8 0 018-8h4V1.5A1.5 1.5 0 0113.5 0h3A1.5 1.5 0 0118 1.5V6h12V1.5A1.5 1.5 0 0131.5 0h3A1.5 1.5 0 0136 1.5V6h4a8 8 0 018 8v28a8 8 0 01-8 8zm2-36a2 2 0 00-2-2H8a2 2 0 00-2 2v28a2 2 0 002 2h32a2 2 0 002-2V14zm-7.5 24h-7a1.5 1.5 0 01-1.5-1.5v-7a1.5 1.5 0 011.5-1.5h7a1.5 1.5 0 011.5 1.5v7a1.5 1.5 0 01-1.5 1.5z" fill-rule="evenodd"></path></svg>
			</label>
                <input id="endDate" type="datetime-local" placeholder="Set End Date" />
                <input type="hidden" name="endDate" id="endDateJs" >
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script>

	    
	    config = {
	    enableTime: true,
	    altInput: true,
	    altFormat: "F j, Y h:i:K",
	    minDate: "today"
	    };   
	
	    flatpickr("input[type=datetime-local]", config);
	
	</script>
</body>
</html>
