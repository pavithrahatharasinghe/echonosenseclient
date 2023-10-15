<jsp:include page="adminHeader.jsp"/>
<body>
<div class="wrapper">
    <jsp:include page="adminSidebar.jsp"/> <!-- This will include the sidebar -->
    <div class="main-panel">
        <!-- Navbar -->
        <jsp:include page="adminNavbar.jsp"/>
        <!-- End Navbar -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <!-- Left Side: User Statistics -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">User Statistics</h4>
                            </div>
                            <div class="card-body">
                                <p>Total Users: <strong>1234</strong></p> <!-- Replace with dynamic data -->
                                <p>New Users Today: <strong>12</strong></p> <!-- Replace with dynamic data -->
                            </div>
                        </div>
                    </div>
                    <!-- Right Side: New Users in Past 7 Days Table -->

                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">New Users in Past 7 Days</h4>
                            </div>
                            <div class="card-body">
                                <!-- Placeholder for Chart.js -->
                                <canvas id="newUsers7DaysChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <!-- Bottom Left: Total Income Charts -->
                    <div class="col-md-6">
                        <!-- Last 7 Days Income -->
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Income in Last 7 Days</h4>
                            </div>
                            <div class="card-body">
                                <!-- Placeholder for Chart.js -->
                                <canvas id="income7DaysChart"></canvas>
                            </div>
                        </div>
                        <!-- Last Month Income -->
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Income in Last Month</h4>
                            </div>
                            <div class="card-body">
                                <!-- Placeholder for Chart.js -->
                                <canvas id="incomeLastMonthChart"></canvas>
                            </div>
                        </div>
                        <!-- Last Year Income -->
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Income in Last Year</h4>
                            </div>
                            <div class="card-body">
                                <!-- Placeholder for Chart.js -->
                                <canvas id="incomeLastYearChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <!-- Bottom Right: Suggested Content -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Suggested Content</h4>
                            </div>
                            <div class="card-body">
                                <p>Here are some suggestions for further insights:</p>
                                <ul>
                                    <li>Compare the income trends across different time frames.</li>
                                    <li>Analyze the sources of income to identify the most profitable channels.</li>
                                    <li>Forecast future income based on historical data.</li>
                                    <li>Identify any seasonal trends in income.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Include Chart.js Library -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Initialize Chart.js -->
<script>
    // Sample data for demonstration purposes
    var daysLabels = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];
    var monthLabels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
    var yearLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    var income7DaysData = [12, 19, 3, 5, 2, 3, 7]; // Replace with dynamic data
    var incomeLastMonthData = [50, 45, 60, 55]; // Replace with dynamic data
    var incomeLastYearData = [600, 580, 620, 590, 610, 630, 640, 650, 660, 670, 680, 690]; // Replace with dynamic data

    createLineChart('income7DaysChart', daysLabels, income7DaysData, 'Income in Last 7 Days');
    createLineChart('incomeLastMonthChart', monthLabels, incomeLastMonthData, 'Income in Last Month');
    createLineChart('incomeLastYearChart', yearLabels, incomeLastYearData, 'Income in Last Year');

    function createLineChart(elementId, labels, data, label) {
        var ctx = document.getElementById(elementId).getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: label,
                    data: data,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }


    var daysLabels = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];
    var newUsers7DaysData = [5, 8, 10, 3, 7, 6, 4]; // Replace with dynamic data

    createBarChart('newUsers7DaysChart', daysLabels, newUsers7DaysData, 'New Users');

    function createBarChart(elementId, labels, data, label) {
        var ctx = document.getElementById(elementId).getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: label,
                    data: data,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }
</script>
</body>
<jsp:include page="adminFooter.jsp"/>
