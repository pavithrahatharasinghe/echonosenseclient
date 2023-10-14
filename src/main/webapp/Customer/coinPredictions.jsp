<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 10/9/2023
  Time: 7:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="customerHeader.jsp" />


<body>
<div class="wrapper">
    <jsp:include page="customerSidebar.jsp" />
    <div class="main-panel">
        <!-- Navbar -->
        <jsp:include page="customerNavbar.jsp"/>
        <!-- End Navbar -->
        <div class="content">
            <div class="container-fluid">
                <!-- Coin Selector -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Select Coin</h4>
                            </div>
                            <div class="card-body">
                                <select id="coinSelector">
                                    <!-- Populate with available coins -->
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Coin Details and Predictions -->
                <div class="row">
                    <div class="col-md-6">
                        <!-- Coin Details & Historical Prices -->
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Coin Details & Historical Prices</h4>

                            </div>
                            <div class="card-body" id="coinDetails">
                                <canvas id="historicalPriceChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <!-- Predicted Prices -->
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Predicted Prices</h4>
                            </div>
                            <div class="card-body" id="predictedPrices">
                                <!-- Populate with predicted prices for selected coin -->
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Related News Section -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Related News</h4>
                                <!-- News Impact Filter -->
                                <select id="newsImpactFilter">
                                    <option value="all">All</option>
                                    <option value="good">Good</option>
                                    <option value="neutral">Neutral</option>
                                    <option value="bad">Bad</option>
                                </select>
                            </div>
                            <div class="card-body" id="newsSection">
                                <!-- Populate with news related to the selected coin -->
                            </div>
                        </div>
                    </div>
                </div>
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

            </div>
        </div>
    </div>
</div>

<script>
    // Function to populate the coin selector dropdown
    function populateCoinSelector() {
        const coinSelector = document.getElementById('coinSelector');

        // Replace 'coinEndpoint' with your actual API endpoint for coin names
        const coinEndpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/coins';

        fetch(coinEndpoint)
            .then(response => response.json())
            .then(data => {
                // Clear existing options
                coinSelector.innerHTML = '';

                // Create an option for each coin
                data.forEach(coin => {
                    const option = document.createElement('option');
                    option.value = coin.name;  // Use the coin's name
                    option.textContent = coin.name;
                    coinSelector.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching coin names: ', error));

        // Add an event listener to the coin selector
        coinSelector.addEventListener('change', function () {
            const selectedCoinName = this.value;
            // Call a function to update the table based on the selected coin name
            updateTable(selectedCoinName);
        });
    }

    // Call the function to populate the coin selector on page load
    window.addEventListener('load', populateCoinSelector);

    // Function to update the table based on the selected coin name
    function updateTable(selectedCoinName) {
        // Encode the coin name for URL
        const encodedCoinName = encodeURIComponent(selectedCoinName);

        console.log(encodedCoinName)
        // Construct the price endpoint URL with the selected coin's name
        const priceEndpoint = `http://localhost:8080/echonosenserest_war_exploded/api/prices/coin/LTCUSDT`;
console.log(priceEndpoint)
        // Inside your fetch block where you get price data
        fetch(priceEndpoint)
            .then(response => response.json())
            .then(data => {
                console.log('Received price data:', data);
                // Assume that 'data' contains an array of price objects with 'date' and 'price' properties.
                // Extract the 'date' and 'price' values from the 'data' array
                const dates = data.map(entry => entry.fetch_time); // Use the correct property name
                const prices = data.map(entry => entry.price); // Use the correct property name

                // Get a reference to the chart canvas
                const historicalPriceChart = document.getElementById('historicalPriceChart').getContext('2d');

                // Create a new Chart.js chart or update an existing one
                if (window.myLineChart) {
                    // Update the existing chart
                    window.myLineChart.data.labels = dates;
                    window.myLineChart.data.datasets[0].data = prices;
                    window.myLineChart.update();
                } else {
                    // Create a new chart
                    window.myLineChart = new Chart(historicalPriceChart, {
                        type: 'line',
                        data: {
                            labels: dates,
                            datasets: [{
                                label: 'Historical Prices',
                                data: prices,
                                borderColor: 'blue',
                                fill: false,
                            }]
                        },
                        options: {
                            scales: {
                                x: {
                                    type: 'time',
                                    time: {
                                        unit: 'day', // Adjust the time unit as needed
                                    },
                                    title: {
                                        display: true,
                                        text: 'Date',
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
                }
            })
            .catch(error => console.error('Error fetching prices: ', error));



// Function to update the table based on the selected coin name
        function updateTable(selectedCoinName) {
            // Simulated demo data (replace this with your actual data)
            const demoDates = ["2023-10-01", "2023-10-02", "2023-10-03", "2023-10-04", "2023-10-05"];
            const demoPrices = [100, 110, 120, 115, 125];

            // Get a reference to the chart canvas
            const historicalPriceChart = document.getElementById('historicalPriceChart').getContext('2d');

            // Create a new Chart.js chart or update an existing one
            if (window.myLineChart) {
                // Update the existing chart
                window.myLineChart.data.labels = demoDates;
                window.myLineChart.data.datasets[0].data = demoPrices;
                window.myLineChart.update();
            } else {
                // Create a new chart
                window.myLineChart = new Chart(historicalPriceChart, {
                    type: 'line',
                    data: {
                        labels: demoDates,
                        datasets: [{
                            label: 'Historical Prices',
                            data: demoPrices,
                            borderColor: 'blue',
                            fill: false,
                        }]
                    },
                    options: {
                        scales: {
                            x: {
                                type: 'time',
                                time: {
                                    unit: 'day', // Adjust the time unit as needed
                                },
                                title: {
                                    display: true,
                                    text: 'Date',
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
            }
        }


    }


</script>

</body>
<jsp:include page="customerFooter.jsp" />
