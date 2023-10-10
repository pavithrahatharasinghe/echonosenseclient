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
    // Fetch data and populate the news list based on filters.
    // Provide functions to handle sorting and categorizing of news items.
</script>
</body>
<jsp:include page="customerFooter.jsp" />

