<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 10/9/2023
  Time: 7:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="customerHeader.jsp"/>


<body>
<div class="wrapper">
    <jsp:include page="customerSidebar.jsp"/>
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

                    <!-- Predicted Prices -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Predicted Prices</h4>
                            </div>
                            <div class="card-body" id="predictedPrices">
                                <!-- Content will be populated dynamically -->
                            </div>
                        </div>
                    </div>
                </div>


                <div style="width: 80%; margin: auto;">
                    <!-- Create a canvas element to render the chart -->
                    <canvas id="historicalPriceChart" width="400" height="200"></canvas>
                </div>


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
                    option.value = coin.symbol;  // Use the coin's symbol
                    option.textContent = coin.name;
                    coinSelector.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching coin names: ', error));


    }

    // Call the function to populate the coin selector on page load
    window.addEventListener('load', populateCoinSelector);
    coinSelector.addEventListener('change', function () {
        const selectedCoinSymbol = this.value;
        updateHistoricalPriceChart(selectedCoinSymbol);

    });

    // Function to update the historical price chart
    function updateHistoricalPriceChart(coinSymbol) {


        var selectdCoin = coinSymbol + 'USDT'
        // Construct the URL based on the selected coin symbol
        const url = `http://localhost:8080/echonosenserest_war_exploded/api/prices/coin/` + selectdCoin;


        // Function to fetch data from the specified endpoint
        function fetchData() {
            fetch(url)
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

        // Call the fetchData function when a new coin is selected
        fetchData();
    }
</script>

<script>
    // Function to update the Predicted Prices table with data from the API
    function updatePredictedPricesTable(coinSymbol) {
        // Replace 'coinPredictionEndpoint' with your actual API endpoint for coin predictions
        const selectdCoin = coinSymbol + 'USDT';
        const coinPredictionEndpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/coin-predictions/' + selectdCoin;

        fetch(coinPredictionEndpoint)
            .then(response => response.json())
            .then(data => {
                // Clear existing content in the predictedPrices div
                const predictedPricesDiv = document.getElementById('predictedPrices');
                predictedPricesDiv.innerHTML = '';

                if (data.id !== undefined) {
                    // Create a table to display the prediction data
                    const table = document.createElement('table');
                    table.className = 'table table-striped';

                    // Create a table header row
                    const headerRow = table.insertRow(0);
                    headerRow.innerHTML = '<th>Predicted Close</th><th>Prediction Date</th>';

                    // Create a table data row using string concatenation
                    const dataRow = table.insertRow(1);
                    dataRow.innerHTML = '<td>' + data.predictedClose + '</td><td>' + data.predictionDate + '</td>';

                    // Append the table to the predictedPrices div
                    predictedPricesDiv.appendChild(table);
                } else {
                    // Handle the case when there are no predictions for the selected coin
                    predictedPricesDiv.innerHTML = 'No predictions found for the selected coin.';
                }
            })
            .catch(error => console.error('Error fetching coin predictions: ', error));
    }

    // Event listener to update the Predicted Prices table when a coin is selected
    coinSelector.addEventListener('change', function () {
        const selectedCoinSymbol = this.value;
        updatePredictedPricesTable(selectedCoinSymbol);
        updateHistoricalPriceChart(selectedCoinSymbol); // Optionally update historical price chart
    });
</script>

</body>
<jsp:include page="customerFooter.jsp"/>
