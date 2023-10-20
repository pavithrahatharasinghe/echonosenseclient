<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
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
                <div class="row" id="servicesCards">
                    <!-- Services and products cards will be populated here -->
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

    // Function to render the services and products as cards
    function renderServiceCards(data) {
        const servicesCardsContainer = document.getElementById('servicesCards');
        servicesCardsContainer.innerHTML = '';

        data.forEach(service => {
            const cardCol = document.createElement('div');
            cardCol.className = 'col-md-4';

            const card = document.createElement('div');
            card.className = 'card';

            const cardHeader = document.createElement('div');
            cardHeader.className = 'card-header';
            cardHeader.textContent = service.planName;

            const cardBodyDuration = document.createElement('div');
            cardBodyDuration.className = 'card-body';
            cardBodyDuration.textContent = 'Duration: ' + service.duration;

            const cardBodyPrice = document.createElement('div');
            cardBodyPrice.className = 'card-body';
            cardBodyPrice.textContent = 'Price: $' + service.price;

            const purchaseButton = document.createElement('button');
            purchaseButton.className = 'btn btn-primary';
            purchaseButton.textContent = 'Purchase';
            purchaseButton.onclick = function() {
                // Open the payment page for the selected service
                window.location.href = '/echonosenseclient_war_exploded/Customer/payment.jsp?planID=' + service.id; // Assuming you have a payment page that accepts a serviceId parameter
            };

            card.appendChild(cardHeader);
            card.appendChild(cardBodyDuration);
            card.appendChild(cardBodyPrice);
            card.appendChild(purchaseButton);
            cardCol.appendChild(card);
            servicesCardsContainer.appendChild(cardCol);
        });

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



    // Call the functions to fetch and render data when the page loads
    (async () => {

        <%
    Properties properties = new Properties();
    try {
        // Load the configuration file
        String configFilePath = application.getRealPath("/WEB-INF/config.properties");
        properties.load(new FileInputStream(configFilePath));
    } catch (Exception e) {
        e.printStackTrace();
    }
    String historyEndpoint = properties.getProperty("historyEndpoint");
    String servicesEndpoint = properties.getProperty("servicesEndpoint");
    String subscriptionEndpoint = properties.getProperty("subscriptionEndpoint");
%>
        const historyEndpoint = <%= historyEndpoint %>
        const servicesEndpoint = <%= servicesEndpoint %>
        const subscriptionEndpoint = <%= subscriptionEndpoint %>

        const paymentData = await fetchData(historyEndpoint);
        const servicesData = await fetchData(servicesEndpoint);
        const subscriptionData = await fetchData(subscriptionEndpoint);

        if (paymentData) {
            renderTable(paymentData, 'subscriptionHistoryTableBody', renderPaymentRow);
        }

        if (servicesData) {
            renderServiceCards(servicesData);
        }

        if (subscriptionData) {
            renderTable(subscriptionData, 'subscriptionTableBody', renderSubscriptionRow);
        }
    })();
</script>





<jsp:include page="customerFooter.jsp" />
</body>
