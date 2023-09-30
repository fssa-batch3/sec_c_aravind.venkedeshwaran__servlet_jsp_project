
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

    .reminderBox{
		width: 400px;
		padding: 5px;
		border-radius: 8px;
		margin-top: -25px;	
	}	
	.reminderBox:hover{
		background-color: #dbdbdb;
		color: #f7b900;
	}
</style>

<body>

		<div class="reminderBox">
	        <form>
	        	<label><i class="fa-solid fa-bell"></i></label>
	            <input id="reminderInput" type="datetime-local" placeholder="Set Reminder" />
	        </form>
        </div>

</body>

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