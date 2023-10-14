<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Historical Price Chart</title>
  <!-- Include Chart.js library -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
</head>
<body>
<div style="width: 80%; margin: auto;">
  <!-- Create a canvas element to render the chart -->
  <canvas id="historicalPriceChart" width="400" height="200"></canvas>
</div>

<script>
  // Function to fetch data from the specified endpoint
  function fetchData() {
    const endpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/prices/coin/LTCUSDT';

    fetch(endpoint)
            .then(response => response.json())
            .then(data => {
              const dates = data.map(entry => entry.fetchTime); // Use the correct property name
              const prices = data.map(entry => entry.price); // Use the correct property name

              // Get a reference to the chart canvas
              const historicalPriceChart = document.getElementById('historicalPriceChart').getContext('2d');

              // Create a new Chart.js chart
              new Chart(historicalPriceChart, {
                type: 'line',
                data: {
                  labels: dates,
                  datasets: [{
                    label: 'Historical Prices',
                    data: prices,
                    backgroundColor: "rgba(75, 192, 192, 0.2)",
                    borderColor: "rgba(75, 192, 192, 1)",
                    borderWidth: 1,
                  }],
                },
                options: {
                  scales: {
                    x: {
                      title: {
                        display: true,
                        text: 'Fetch Time',
                      },
                    },
                    y: {
                      title: {
                        display: true,
                        text: 'Price',
                      },
                    },
                  },
                },
              });
            })
            .catch(error => console.error('Error fetching data: ', error));
  }

  // Call the fetchData function on page load
  window.addEventListener('load', fetchData);
</script>
</body>
</html>
