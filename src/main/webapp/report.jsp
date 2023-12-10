<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>FreshTime | Report</title>

    <!-- styles for Report Page-->
    <link href="assets/css/reportmain.css" rel="stylesheet">
    <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">-->
    <link rel="stylesheet" href="assets/css/sidebar.css">
    
    <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
    
    <!-- bootstrap for adding icon  -->
	<script src="https://kit.fontawesome.com/ee40c53027.js"></script>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

		<jsp:include page="sidebar.jsp"></jsp:include>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <h1 class="h1 mb-0 text-gray-800">Task Report</h1>
                
                <!-- Dropdown for Daily, weekly, yearly -->
                <div class="filternav">  
	                <ul class="nav nav-pills mb-3 justify-content-end" id="pills-tab" role="tablist">
	                
					  <li class="nav-item">
					    <a class="nav-link" id="pills-today-tab" onclick="FilterReport()">Today</a>
					  </li>
					  
					  <li class="nav-item">
					    <a class="nav-link" id="pills-week-tab" onclick="FilterReport('week')">This Week</a>
					  </li>
					  
					  <li class="nav-item">
					    <a class="nav-link" id="pills-month-tab" onclick="FilterReport('month')" >This Month</a>
					  </li>
					 
					  
					  <li class="customdates">
					  		<input id="startDate" type="date" placeholder="Set Start Date" name = "startDate">
			        		<input id="endDate" type="date" placeholder="Set End Date" name="endDate" >
			        		<a class="nav-link active" id="pills-customdates-tab" onclick="FilterReport('customdate')" >Filter</a>
					</li>
					</ul>
					
					
				</div>
				
                

                <!-- Content Row -->
                <div class="row">

                    <div class="col-xl-8 col-lg-7">

                        
                        <!-- Bar Chart -->
                        <div class="card shadow mb-3" style="width: 100%;">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Completed Vs Uncompleted Task</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-bar">
                                    <canvas id="myBarChart"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Area Chart -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Productive perfomance</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-area">
                                    <canvas id="myAreaChart"></canvas>
                                </div>
                            </div>
                        </div>

                    </div>

                   
                    <div class="col-xl-4 col-lg-5">
                    
                    	<!-- Donut Chart -->
                        <div class="card shadow mb-4">
                            <!-- Card Header - Dropdown -->
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Task Ratio</h6>
                            </div>
                            <!-- Card Body -->
                            <div class="card-body">
                                <div class="chart-pie pt-4">
                                    <canvas id="myPieChart"></canvas>
                                </div>
                            </div>
                        </div>

                         <!-- Productivity Percentage -->
                        <div class="card shadow mb-4">
                            <!-- Card Header - Dropdown -->
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Overall Productivity Percentage</h6>
                            </div>
                            <!-- Card Body -->
                            <div class="card-body">
                                <div class="chart-pie pt-4">
                                    <div role="progressbar" id="progress-bar"></div>
                                    <!--<canvas id="myPieChart"></canvas>-->
                                </div>
                            </div>
                        </div>
                        
                        
                    </div>
                </div>

            </div>
            <!--End Of container-->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    


    <!-- Chart js scripts -->
    <script src="assets/js/mainchart.js"></script>
    
    
    
    <script type="text/javascript">
    
	    let totalTask = <%=request.getAttribute("totalTask")%>;
	    let completedTask = <%=request.getAttribute("completedTask")%>;
	
	    const productivityScore = [];
	
	    for (let i = 0; i < totalTask.length; i++) {
	        const total = totalTask[i];
	        const completed = completedTask[i];
	
	        const score = (completed / total) * 100;
	
	        productivityScore.push(score);
	    }
	    
	    console.log(productivityScore);
	
	    // Calculate the average of the productivity scores
		let sum = 0;
		for (let i = 0; i < productivityScore.length; i++) {
			if(productivityScore[i] >=  0){
				sum += productivityScore[i];
			}
		    
		}
		
		console.log(sum);
		
		const averageScore = Math.round(sum / productivityScore.length);
		
		console.log(averageScore);
	
	    const progressBar = document.getElementById("progress-bar");
	    progressBar.style.setProperty('--progress-value', averageScore);

    </script>
	
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script>
		config = {
			enableTime: false,
			altInput: true,
			altFormat: "F j, Y",
			};   
			
			flatpickr("input[type=date]", config);
	</script>
	
	<script>

			function FilterReport(filter) {

	            let today = new Date();
	            let startDate = new Date(today);
	            let endDate = new Date(today);
	            

	            if(filter == 'week'){
		            if(today.getDay() == 0){
		            	endDate.setDate(today.getDate() - today.getDay());
		            	startDate.setDate(endDate.getDate() - 6);
		            }
		            else{
			            startDate.setDate(today.getDate() - today.getDay() + 1);
			            endDate.setDate(startDate.getDate() + 6);
		            }
	            }
	            
	            if(filter == 'month'){
	            	// Get the current year and month
	            	const currentYear = today.getFullYear();
	            	const currentMonth = today.getMonth();

	            	// Calculate the first day of the month
	            	startDate = new Date(currentYear, currentMonth, 1);

	            	// Calculate the last day of the month
	            	endDate = new Date(currentYear, currentMonth + 1, 0);
	            }
	            
	            if(filter == 'customdate'){
	            	startDate = document.getElementById("startDate").value;
	            	endDate = document.getElementById("endDate").value;
	            	
	            }
	            
	            console.log("startDate= " + startDate);
	            console.log("endDate= " + endDate);
	           

	            // Format the start and end dates as "YYYY-MM-DD"
	            let startDateUrl = formatToJavaDate(startDate);
	            let endDateUrl = formatToJavaDate(endDate);

	            console.log("startDateUrl= " + startDateUrl);
	            console.log("endDateUrl = " + endDateUrl);
	            
			    // Construct the URL with the start and end dates
			     const url = `ReportServlet?startdate=${startDateUrl}&enddate=${endDateUrl}`;
			     window.location.href = url;
			}
			
			function formatToJavaDate(unformattedDate) {
				const date = new Date(unformattedDate);

				const year = date.getFullYear();
				const month = String(date.getMonth() + 1).padStart(2, '0');
				const day = String(date.getDate()).padStart(2, '0');
				
				const formattedDate = `${year}-${month}-${day}`;
				return formattedDate;
			}

	</script>
	
	    <script>
	 	const startDate = "<%=request.getAttribute("startdate")%>";
	    const endDate = "<%=request.getAttribute("enddate")%>";
	    let dateArray = [];
	    

	 	// Parse the startDate and endDate as Date objects
	    const startDateObj = new Date(startDate);
	    const endDateObj = new Date(endDate);

	    // Initialize a variable to keep track of the current date
	    let currentDate = new Date(startDateObj);

	    while (currentDate <= endDateObj) {
	        const formattedDate = formatDate(currentDate);
	        dateArray.push(formattedDate);

	        // Move to the next day
	        currentDate.setDate(currentDate.getDate() + 1);
	    }

	    function formatDate(date) {
	        const options = { day: '2-digit', weekday: 'short' };
	        const formatter = new Intl.DateTimeFormat('en-US', options);
	        const parts = formatter.formatToParts(date);
	        const day = parts.find(part => part.type === 'day').value;
	        const dayOfWeek = parts.find(part => part.type === 'weekday').value;
	        return `${day} ${dayOfWeek}`;
	    }
	    
	    
	 	// Set new default font family and font color to mimic Bootstrap's default styling
	    Chart.defaults.global.defaultFontFamily = 'Ubuntu';
	    Chart.defaults.global.defaultFontColor = '#858796';
	
	    // Bar Chart Example
	    var ctx = document.getElementById("myBarChart");
	    let myChart = new Chart(ctx, {
	    	type: 'bar',
	    	data: {
	    		labels: dateArray,
	    		datasets: [
	    			{
	    				label: "Completed Task",
	    				backgroundColor: "#5754f7",
	    				hoverBackgroundColor: "#5754f7",
	    				borderColor: "#5754f7",
	    				pointRadius: 0,
	    				fill: false,
	    				borderWidth: 1,
	    				fill: 'origin',
	    				data: completedTask
	    			},
	    			{
	    				label: "Total Task",
	    				borderColor: '#9993ff',
	    				backgroundColor: '#9993ff',
	    				hoverBackgroundColor: '#9993ff',
	    				pointRadius: 0,
	    				fill: false,
	    				borderWidth: 1,
	    				fill: 'origin',
	    				data: totalTask
	    			}
	    		]
	    	},
	    	options: {
	    		legend: {
	    			display: true
	    		},
	    		maintainAspectRatio: false,
	    		layout: {
	    			padding: {
	    				left: 10,
	    				right: 25,
	    				top: 15,
	    				bottom: 0
	    			}
	    		},
	    		scales: {
	    			xAxes: [{
	    				time: {
	    					unit: 'week'
	    				},
	    				gridLines: {
	    					display: false,
	    					drawBorder: false
	    				},
	    				ticks: {
	    					maxTicksLimit: 31
	    				},
	    				barPercentage: 0.4,
	    			}],
	    			yAxes: [{
	    				ticks: {
	    					min: 0,
	    					max: 10,
	    					maxTicksLimit: 20,
	    					padding: 10,
	    				},
	    				gridLines: {
	    					color: "rgb(234, 236, 244)",
	    					zeroLineColor: "rgb(234, 236, 244)",
	    					drawBorder: false,
	    					borderDash: [1],
	    					zeroLineBorderDash: [1]
	    				}
	    			}],
	    		}
	    	},
	    	elements: {
	    		point: {
	    			radius: 0
	    		}
	    	}
	    })
    </script>
    
    
    
    <script type="text/javascript">
	 	// Area Chart
	    var ctx = document.getElementById("myAreaChart");
	    var myLineChart = new Chart(ctx, {
	      type: 'line',
	      data: {
	        labels: dateArray,
	        datasets: [{
	          label: "Productivity Score",
	          lineTension: 0.3,
	          backgroundColor: "rgba(78, 115, 223, 0.05)",
	          borderColor: "rgba(78, 115, 223, 1)",
	          pointRadius: 3,
	          pointBackgroundColor: "rgba(78, 115, 223, 1)",
	          pointBorderColor: "rgba(78, 115, 223, 1)",
	          pointHoverRadius: 3,
	          pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
	          pointHoverBorderColor: "rgba(78, 115, 223, 1)",
	          pointHitRadius: 10,
	          pointBorderWidth: 2,
	          data: productivityScore,
	        }],
	      },
	      options: {
	        maintainAspectRatio: false,
	        layout: {
	          padding: {
	            left: 10,
	            right: 25,
	            top: 25,
	            bottom: 0
	          }
	        },
	        scales: {
	          xAxes: [{
	            time: {
	              unit: 'date'
	            },
	            gridLines: {
	              display: false,
	              drawBorder: false
	            },
	            ticks: {
	              maxTicksLimit: 31
	            }
	          }],
	          yAxes: [{
	            ticks: {
	              maxTicksLimit: 5,
	              padding: 10,
	            },
	            gridLines: {
	              color: "rgb(234, 236, 244)",
	              zeroLineColor: "rgb(234, 236, 244)",
	              drawBorder: false,
	              borderDash: [2],
	              zeroLineBorderDash: [2]
	            }
	          }],
	        },
	        legend: {
	          display: true
	        }
	      }
	    });

    </script>
    
    <script type="text/javascript">
	    let todoCount = <%=request.getAttribute("todoCount")%>;
	    let inprogressTaskCount = <%=request.getAttribute("inprogressTaskCount")%>;
	    let completedTaskCount = <%=request.getAttribute("completedTaskCount")%>;
	    let overdueTaskCount = <%=request.getAttribute("overdueTaskCount")%>;
	    let blockedTaskCount = <%=request.getAttribute("blockedTaskCount")%>;
	 	// Pie Chart
	    var ctx = document.querySelectorAll("#myPieChart");
	    var myPieChart = new Chart(ctx, {
	      type: 'doughnut',
	      data: {
	        labels: ["Todo", "Inprogress", "Completed", "Overdue", "Blocked"],
	        datasets: [{
	          data: [todoCount, inprogressTaskCount, completedTaskCount, overdueTaskCount, blockedTaskCount],//change
	          backgroundColor: ['#ffde5c', '#1cc88a', '#5754f7','#e5e5e5','#F75802'],
	          hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
	          hoverBorderColor: "rgba(234, 236, 244, 1)",
	        }],
	      },
	      
	      options: {
	        maintainAspectRatio: false,
	        legend: {
	          display: true,
	          position: 'bottom',
	    	  usePointStyle: true
	        },
	        tooltips: {
	          backgroundColor: "rgb(255,255,255)",
	          bodyFontColor: "#858796",
	          borderColor: '#dddfeb',
	          borderWidth: 1,
	          xPadding: 15,
	          yPadding: 15,
	          displayColors: false,
	          caretPadding: 10,
	        },
	        cutoutPercentage: 80,
	      },
	    });
    </script>
</body>

</html>