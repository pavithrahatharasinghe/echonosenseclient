<jsp:include page="customerHeader.jsp" />

<body>
<div class="wrapper">
    <jsp:include page="customerSidebar.jsp" />
    <div class="main-panel">
        <!-- Navbar -->
        <jsp:include page="customerNavbar.jsp" />
        <!-- End Navbar -->
        <div class="content">
            <div class="container-fluid">
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

<!-- ... your existing JSP code ... -->

<script>
    // Function to fetch data from an API
    async function fetchData(apiEndpoint) {
        try {
            const response = await fetch(apiEndpoint);
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching data:', error);
            return null;
        }
    }

    // Function to render data in a table
    function renderTable(data, tableId, rowTemplate) {
        const tableBody = document.getElementById(tableId);
        tableBody.innerHTML = '';

        data.forEach(item => {
            const row = document.createElement('tr');
            row.innerHTML = rowTemplate(item);
            tableBody.appendChild(row);
        });
    }

    // Function to render payment history table rows using string concatenation
    function renderPaymentRow(payment) {
        return '<td>' + payment.paymentDate + '</td>' +
            '<td>Payment</td>' +
            '<td>Payment ID: ' + payment.paymentID + '</td>';
    }

    // Function to render subscription table rows using string concatenation
    function renderSubscriptionRow(subscription) {
        return '<td>' + subscription.subscriptionID + '</td>' +
            '<td>' + subscription.planName + '</td>' +
            '<td>' + subscription.startDate + '</td>' +
            '<td>' + subscription.endDate + '</td>' +
            '<td>' + subscription.status + '</td>' +
            '<td>$' + subscription.price + '</td>' +
            '<td><button onclick="performSubscriptionAction(' + subscription.subscriptionID + ')">Action</button></td>';
    }

    // Call the functions to fetch and render data when the page loads
    (async () => {
        const historyEndpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/payments';
        const servicesEndpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/subscriptions';
        const subscriptionEndpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/subscriptions';

        const paymentData = await fetchData(historyEndpoint);
        const servicesData = await fetchData(servicesEndpoint);
        const subscriptionData = await fetchData(subscriptionEndpoint);

        if (paymentData) {
            renderTable(paymentData, 'subscriptionHistoryTableBody', renderPaymentRow);
        }

        if (servicesData) {
            const servicesList = document.getElementById('servicesList');
            servicesList.innerHTML = '';
            servicesData.forEach(subscription => {
                const listItem = document.createElement('li');
                listItem.textContent = subscription.planName + ' - $' + subscription.price;
                servicesList.appendChild(listItem);
            });
        }

        if (subscriptionData) {
            renderTable(subscriptionData, 'subscriptionTableBody', renderSubscriptionRow);
        }
    })();
</script>


<!-- ... your existing JSP code ... -->

<jsp:include page="customerFooter.jsp" />
</body>
