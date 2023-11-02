<link rel="stylesheet" href="assets/css/notify.css">
<script
    src="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.js">
</script>

<script>
<%
	String error = (String) request.getAttribute("error");
	String success = (String) request.getAttribute("success");
	String path = (String) request.getAttribute("path");

	
	if (error != null) {%>
		let error = "<%=error%>";
	    Notify.error(error);
		setTimeout(() => {
			window.location.href="<%=path%>";
		}, 3500);
			
		<%}%>
		
	<%if (success != null) {%>
		let success = "<%=success%>";
        Notify.success(success);
        
        setTimeout(() => {
			window.location.href= "<%=path%>";
		}, 3500);
	<%}%>
</script>