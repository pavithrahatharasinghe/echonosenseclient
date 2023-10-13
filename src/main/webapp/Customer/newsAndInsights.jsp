<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 10/9/2023
  Time: 7:29 PM
  To change this template use File | Settings | File Templates.
--%>
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
                <!-- News & Insights -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h4 class="card-title">News & Insights</h4>
                            </div>
                            <div class="card-body">
                                <!-- Filters -->
                                <div class="filters mb-3">
                                    <label for="coinSelection">Filter by Coin:</label>
                                    <select id="coinSelection" class="form-control d-inline-block" style="width: auto;">
                                        <option value="all">All Coins</option>
                                        <!-- Options for coins will be populated here -->
                                    </select>

                                    <label for="impactSelection" class="ml-3">Sort by Impact:</label>
                                    <select id="impactSelection" class="form-control d-inline-block" style="width: auto;">
                                        <option value="all">All</option>
                                        <option value="high">High</option>
                                        <option value="medium">Medium</option>
                                        <option value="low">Low</option>
                                    </select>
                                </div>

                                <!-- News List -->
                                <ul id="newsList" class="list-group list-group-flush">
                                    <!-- News items will be populated here -->
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    // Function to fetch news data based on selected filters
    function fetchNewsData() {
        // Replace 'newsEndpoint' with your actual API endpoint for news data
        const newsEndpoint = '/your/api/endpoint';

        // Get selected coin and impact filter values
        const selectedCoin = document.getElementById('coinSelection').value;
        const selectedImpact = document.getElementById('impactSelection').value;

        // Fetch news data based on filters
        fetch(`${newsEndpoint}?coin=${selectedCoin}&impact=${selectedImpact}`)
            .then(response => response.json())
            .then(data => {
                const newsList = document.getElementById('newsList');
                newsList.innerHTML = '';

                data.forEach(newsItem => {
                    const listItem = document.createElement('li');
                    listItem.classList.add('list-group-item');
                    listItem.innerHTML = `
                        <h5>${newsItem.title}</h5>
                        <p>${newsItem.description}</p>
                        <span class="badge badge-${newsItem.impact}-info">${newsItem.impact}</span>
                    `;

                    newsList.appendChild(listItem);
                });
            })
            .catch(error => console.error('Error fetching news data: ', error));
    }

    // Event listener for filter changes
    document.getElementById('coinSelection').addEventListener('change', fetchNewsData);
    document.getElementById('impactSelection').addEventListener('change', fetchNewsData);

    // Call the function to fetch news data when the page loads
    fetchNewsData();
    function populateCoinSelection() {
        // Replace 'coinEndpoint' with your actual API endpoint for coin names
        const coinEndpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/coins';

        fetch(coinEndpoint)
            .then(response => response.json())
            .then(data => {
                const coinSelection = document.getElementById('coinSelection');

                // Clear existing options
                coinSelection.innerHTML = '';

                // Add an "All Coins" option
                const allCoinsOption = document.createElement('option');
                allCoinsOption.value = 'all';
                allCoinsOption.textContent = 'All Coins';
                coinSelection.appendChild(allCoinsOption);

                // Add options for each coin name
                data.forEach(coin => {
                    const option = document.createElement('option');
                    option.value = coin.id;  // Use the coin's ID or appropriate identifier
                    option.textContent = coin.name;
                    coinSelection.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching coin names: ', error));
    }

    // Attach the function to populate the dropdown to the window's load event
    window.addEventListener('load', populateCoinSelection);

</script>

</body>
<jsp:include page="customerFooter.jsp" />
