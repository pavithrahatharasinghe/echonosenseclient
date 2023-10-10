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
                <!-- Subscription Details -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Subscription Details</h4>
                            </div>
                            <div class="card-body table-full-width table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Status</th>
                                        <th>Amount</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody id="subscriptionTableBody">
                                    <!-- Subscription data will be populated here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Offered Services and Products -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Offered Services and Products</h4>
                            </div>
                            <div class="card-body">
                                <ul id="servicesList">
                                    <!-- Services and products will be populated here -->
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Subscription History -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Subscription History</h4>
                            </div>
                            <div class="card-body table-full-width table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Action</th>
                                        <th>Description</th>
                                    </tr>
                                    </thead>
                                    <tbody id="subscriptionHistoryTableBody">
                                    <!-- Subscription history will be populated here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    // Fetch data and populate tables and lists as needed.
    // Also, provide functions for actions (renew, cancel, upgrade, downgrade, etc.)
</script>
</body>
<jsp:include page="customerFooter.jsp" />
