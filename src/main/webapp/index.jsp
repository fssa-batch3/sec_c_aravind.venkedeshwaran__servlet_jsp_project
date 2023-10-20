<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FRESHTIME</title>

<!-- adding favicon -->
<link rel="icon" type="image/x-icon" sizes="16x16 32x32"
	href="assets/images/favicon.png">

<!-- adding css -->
<link rel="stylesheet" href="assets/css/index.css">

<!-- adding ubuntu font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
	rel="stylesheet">
<style>
@import
	url("https://fonts.googleapis.com/css2?family=Ubuntu&display=swap");
</style>

<!-- bootstrap for adding icon  -->
<script src="https://kit.fontawesome.com/ee40c53027.js"
	crossorigin="anonymous" integrity="">
	
</script>

<link rel="stylesheet" href="assets/css/notify.css">
<script
	src="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.js">
</script>

</head>

<body>

	<!-- Notify Alert -->
	<%
	String success = (String) request.getAttribute("success");
	String error = (String) request.getAttribute("error");
	%>


	<%
	if (error != null) {
	%>
	<script>
		    let error = "<%=error%>";
		    Notify.error(error);
		</script>
	<%
	}
	%>

	<%
	if (success != null) {
	%>
	<script>
	    	let success = "<%=success%>
		";
		Notify.success(success);
	</script>
	<%
	}
	%>
	<!-- nav bar starts -->
	<header>
		<div class="header">
			<div class="logo">
				<img
					src="assets/images/b69f24d1a6b6244d359a5d7fc4729eae-removebg-preview.png"
					alt="Logo" width="50px" height="53.32vw">
				<h1>FRESHTIME</h1>
			</div>

			<div class="nav">
				<a href="#hero-section">Home</a> <a
					href="<%=request.getContextPath()%>/signup.jsp">Task</a> <a
					href="<%=request.getContextPath()%>/signup.jsp">Timer</a> <a
					href="<%=request.getContextPath()%>/signup.jsp">Journal</a> <a
					href="<%=request.getContextPath()%>/signup.jsp">
					<button class="login-btn">LOGIN</button>
				</a>
			</div>
		</div>
	</header>
	<!-- nav bar starts -->

	<main>
		<!--hero section starts -->
		<div class="hero-row" id="hero-section">
			<div class="hero-left">
				<h1>
					Optimize <br> <span class="text">Your Work and Life</span>
				</h1>
				<p>The Golden Keys to a Better Life. Translate your potential
					using Freshtime features.- Never forget your task and habits -
					Maintain your Streaks - Get an overview of task and Habit Calendars
					- View the Completion Rate - Document with Notes - Set Time goals
					for your tasks.</p>
				<a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="try-btn">Try It</button>
				</a> <a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="remind-btn">Take a Tour</button>
				</a>
			</div>
			<img class="time-img" src="assets/images/21787145.jpg"
				alt="Time Illustration">
		</div>
		<!--hero section ends -->

		<!-- second section starts -->
		<div class="meditate-row">
			<img src="assets/images/row-1 gif.gif" alt="gif" width="800px">
			<div class="meditate-right">
				<h1>
					<span class="text-2">Reach The Mental Clarity</span> <br> You
					are longing for.
				</h1>
				<p>Your to-do lists are automatically sorted into Today,
					Upcoming and custom Filter views to help you priority on your most
					important things.</p>
				<a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="remind-btn">Sign Up</button>
				</a> <a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="try-btn">Try It</button>
				</a>
			</div>
		</div>
		<!-- second section ends -->

		<!-- Third section starts -->
		<div class="works-row">

			<div class="head">
				<h1>How Does It Works?</h1>
				<p class="head-para">
					Productivity tracker in its essential steps: <br> choose the
					tasks, actually remember to do it, and track your development.
				</p>
			</div>

			<div class="steps">
				<div class="goals">
					<img src="assets/images/setup.png" alt="Set up goals" width="200px">
					<h1>1. Set Up Your Goals</h1>
					<p>String together a list of tasks you need to do and start
						your journey.</p>
				</div>

				<div class="cue">
					<img src="assets/images/2.png" alt="cue" width="200px">
					<h1>2. Get the Cue</h1>
					<p>With multiple reminders,Stay accountable and never forget
						your tasks.</p>
				</div>

				<div class="progress">
					<img src="assets/images/3.png" alt="progress" width="200px">
					<h1>3. Check your Progress</h1>
					<p>Guage you productivity thorugh detailed weekly and monthly
						reports.</p>
				</div>
			</div>

		</div>
		<!-- third section ends -->

		<!--Fourth Section starts-->
		<div class="journal-row">
			<div class="journal">
				<h1>Set goals and crush them faster.</h1>
				<p>Stay on track and smash your goals with targets for task
					completions, numbers, monetary values and more. Track progress your
					of your objectives organized with Goal Folders.</p>
				<a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="remind-btn">Sign Up</button>
				</a> <a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="try-btn">Try It</button>
				</a>
			</div>
			<img src="assets/images/journal.gif" alt="journal">

		</div>
		<!--Fourth Section ends-->

		<!-- Fifth section starts -->
		<div class="report-row">
			<!--row5 report row-->
			<img src="assets/images/report3.gif" alt="gif" width="500px"
				height="500px">
			<div class="report-right">
				<h1>FRESHTIME Is a productive power House</h1>
				<p>Simple, flexible, and powerful. All it takes are boards,
					lists, and cards to get a clear view of who’s doing what and what
					needs to get done. Learn more in our guide for getting started.</p>
				<a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="remind-btn">Sign Up</button>
				</a> <a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="try-btn">Try It</button>
				</a>
			</div>
		</div>
		<!-- fourth section ends -->

		<!--Sixth Section starts-->
		<div class="habit-row">
			<!--row4 habit-row-->
			<div class="habit">
				<h1>Leverage Your Productivity using animedoro</h1>
				<p>The Golden Keys to a Better Life. Translate your potential
					into concrete habits with a set of Freshtime features. Never forget
					your habits. Maintain your Streaks. Get an overview of Habit
					Calendars. View the Completion Rate. Document with Notes. Set Time
					goals for your habits.</p>
				<a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="remind-btn">Sign Up</button>
				</a> <a href="<%=request.getContextPath()%>/signup.jsp">
					<button class="try-btn">Try It</button>
				</a>
			</div>
			<img src="assets/images/anime front.gif" alt="anime">
		</div>
		<!--Sixth Section ends-->

	</main>

	<!-- footer starts -->
	<footer>
		<div class="logo-footer">
			<img
				src="assets/images/b69f24d1a6b6244d359a5d7fc4729eae-removebg-preview.png"
				alt="Logo" width="50px" height="50px">
			<h1>FRESHTIME</h1>
		</div>

		<!-- features column starts -->
		<div class="features">
			<h1>Features</h1>
			<a href="/">Home</a> <a
				href="<%=request.getContextPath()%>/signup.jsp">Task</a> <a
				href="<%=request.getContextPath()%>/signup.jsp">Timer</a> <a
				href="<%=request.getContextPath()%>/signup.jsp">Journal</a>
		</div>
		<!-- features column starts -->

		<!-- social icon column starts -->
		<div class="social-icons">
			<h1 aria-hidden="true">Social network</h1>
			<a href="https://www.facebook.com" target="_blank"
				class="fa fa-facebook" rel="noopener"></a> <a
				href="https://www.google.com" target="_blank" class="fa fa-google"
				rel="noopener"></a> <a href="https://www.linkedin.com"
				target="_blank" class="fa fa-linkedin" rel="noopener"></a> <a
				href="https://www.youtube.com" target="_blank" class="fa fa-youtube"
				rel="noopener"></a> <br> <a href="https://www.instagram.com"
				target="_blank" class="fa fa-instagram" rel="noopener"></a> <a
				href="https://www.twitter.com" target="_blank" class="fa fa-twitter"
				rel="noopener"></a>
		</div>
		<!-- social icon column starts -->

		<!-- subscribe column starts  -->
		<div class="subs">
			<h1>Join In Our Community To get new productivity tips</h1>
			<label for="email"></label> <input type="email" id="email"
				placeholder="Enter Your Email Address">
			<button>Join</button>
		</div>
		<!-- subscribe column ends  -->
	</footer>
	<!-- footer ends -->
</body>

</html>