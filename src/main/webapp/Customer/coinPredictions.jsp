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
                                <!-- Populate with selected coin's details -->
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

            </div>
        </div>
    </div>
</div>

<script>
    // Fetch coin details, predictions, and related news based on the coin selected by the user.
    // Implement filtering for the news based on the impact.
</script>

</body>
<jsp:include page="customerFooter.jsp" />
