<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 10/7/2023
  Time: 9:24 PM
  To change this template use File | Settings | File Templates.
--%>
<jsp:include page="customerHeader.jsp"/>
<!-- Include Chart.js library -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<body>
<div class="wrapper">
    <jsp:include page="customerSidebar.jsp"/> <!-- This will include the sidebar -->
    <div class="main-panel">
        <!-- Navbar -->
        <jsp:include page="customerNavbar.jsp"/>
        <!-- End Navbar -->
        <div class="content">
            <div class="container-fluid">
                <!-- BTC Price Chart for Last 7 Days -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header" style="background-color: #f5f5f5;">
                                <h4 class="card-title">BTC Price Chart (Last 7 Days)</h4>
                            </div>
                            <div class="card-body">
                                <canvas id="btcPriceChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Top 5 Coins Card -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header" style="background-color: #f5f5f5;">
                                <h4 class="card-title">Top 5 Coins</h4>
                            </div>
                            <div class="card-body">
                                <ul>
                                    <li>Bitcoin (BTC) - $60,000</li>
                                    <li>Ethereum (ETH) - $4,000</li>
                                    <li>Cardano (ADA) - $2.5</li>
                                    <li>Binance Coin (BNB) - $450</li>
                                    <li>Solana (SOL) - $150</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <!-- Crypto News Highlights Card -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header" style="background-color: #f5f5f5;">
                                <h4 class="card-title">Crypto News Highlights</h4>
                            </div>
                            <div class="card-body">
                                <strong>Latest News:</strong> Bitcoin hits an all-time high!<br>
                                <strong>Trending News:</strong> Ethereum 2.0 launch successful.<br>
                                <strong>News Categories:</strong> Bitcoin, Ethereum, Altcoins<br>
                            </div>
                        </div>
                    </div>
                    <!-- Crypto Price Tracker Card -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header" style="background-color: #f5f5f5;">
                                <h4 class="card-title">Crypto Price Tracker</h4>
                            </div>
                            <div class="card-body">
                                <strong>Favorite Cryptos:</strong> BTC, ETH, ADA<br>
                                <strong>Market Overview:</strong> Market Cap: $2T, Volume: $50B, BTC Dominance: 45%<br>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Alerts and Notifications Card -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header" style="background-color: #f5f5f5;">
                                <h4 class="card-title">Alerts and Notifications</h4>
                            </div>
                            <div class="card-body">
                                <strong>Price Alerts:</strong> BTC reached $60,000!<br>
                                <strong>News Alerts:</strong> Major update on Ripple lawsuit.<br>
                                <strong>Account Activity:</strong> New login from Paris.<br>
                            </div>
                        </div>
                    </div>
                    <!-- Recommendations Card -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header" style="background-color: #f5f5f5;">
                                <h4 class="card-title">Recommendations</h4>
                            </div>
                            <div class="card-body">
                                <strong>Article Recommendations:</strong> "The future of DeFi"<br>
                                <strong>Crypto Recommendations:</strong> Consider looking into Cardano (ADA)<br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
</div>
</div>

<script>
    // Dummy data for BTC price chart
    const btcPrices = [57000, 58000, 59000, 60000, 61000, 62000, 63000];
    const days = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];

    const ctx = document.getElementById('btcPriceChart').getContext('2d');
    const btcChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: days,
            datasets: [{
                label: 'BTC Price',
                data: btcPrices,
                borderColor: 'rgba(75, 192, 192, 1)',
                fill: false
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
</script>

</body>
<jsp:include page="customerFooter.jsp"/>
