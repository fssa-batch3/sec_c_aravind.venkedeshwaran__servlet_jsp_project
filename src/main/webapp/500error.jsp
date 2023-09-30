<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Ubuntu font link added -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
	    rel="stylesheet">
	<style>
	@import
	    url('https://fonts.googleapis.com/css2?family=Ubuntu&display=swap');
	</style>

    <title>500 error</title>
    <style>
        body {
            background-color: #FDFDFD;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: 'Ubuntu';
        }

        img {
            max-width: 100%;
            height: auto;
        }

        .homeLink {
            background-color: darkblue;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            margin-top: 20px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <img src="assets/images/500errorrobot.gif" alt="Error Robot Image">
    <a href="<%=request.getContextPath()%>/signup.jsp" class="homeLink">Please Log In Again</a>
</body>
</html>
