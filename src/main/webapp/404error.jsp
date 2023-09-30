<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>404 Error</title>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Cabin:400,700" rel="stylesheet">

	<link type="text/css" rel="stylesheet" href="assets/css/404error.css" />



</head>

<body>

	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<div></div>
				<h1>404</h1>
			</div>
			<h2>Page not found</h2>
			<p>The page you are looking for might have been removed had its name changed or is temporarily unavailable.</p>
			<a href="<%=request.getContextPath()%>/index.jsp">home page</a>
		</div>
	</div>

</body>

</html>
