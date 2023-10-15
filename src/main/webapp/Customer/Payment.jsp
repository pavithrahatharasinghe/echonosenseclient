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
                <!-- Payment Form and Selected Plan Display -->
                <div class="row">
                    <!-- Payment Form (Left Side) -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Payment Details</h4>
                            </div>
                            <div class="card-body">
                                <form action="YourPaymentProcessingEndpoint" method="post" id="paymentForm">
                                    <!-- Cardholder Name -->
                                    <div class="form-group">
                                        <label for="cardholderName">Cardholder Name</label>
                                        <input type="text" class="form-control" id="cardholderName" name="cardholderName" required>
                                    </div>
                                    <!-- Card Number -->
                                    <div class="form-group">
                                        <label for="cardNumber">Card Number</label>
                                        <input type="text" class="form-control" id="cardNumber" name="cardNumber" pattern="\d{16}" title="Please enter a valid 16-digit card number." required>
                                    </div>
                                    <!-- Expiry Date & CVV -->
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="expiryDate">Expiry Date (MM/YY)</label>
                                            <input type="date" class="form-control" id="expiryDate" name="expiryDate" pattern="^(0[1-9]|1[0-2])\/?([0-9]{2})$" title="Please enter a valid expiry date in MM/YY format." required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="cvv">CVV</label>
                                            <input type="text" class="form-control" id="cvv" name="cvv" pattern="\d{3}" title="Please enter a valid 3-digit CVV." required>
                                        </div>
                                    </div>
                                    <!-- Amount -->
                                    <div class="form-group">
                                        <label for="amount">Amount ($)</label>
                                        <input type="number" class="form-control" id="amount" name="amount" min="0.01" step="0.01" required>
                                    </div>
                                    <!-- Submit Button -->
                                    <button type="submit" class="btn btn-primary">Proceed to Payment</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Selected Plan Details (Right Side) -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Selected Plan</h4>
                            </div>
                            <div class="card-body" id="selectedPlanDetails">
                                <!-- Plan details will be populated here via JavaScript -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Fetch plan details based on planID and populate the right side
    async function fetchPlanDetails(planID) {
        const apiEndpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/subscriptions/' + planID;
        const data = await fetchData(apiEndpoint);
        if (data) {
            const planDetailsDiv = document.getElementById("selectedPlanDetails");
            planDetailsDiv.innerHTML = `
                <h5>${data.planName}</h5>
                <p>Price: $${data.price}</p>
                <p>Description: ${data.description}</p>
                <!-- Add more details as needed -->
            `;
        } else {
            alert("Unable to fetch plan details. Please try again.");
        }
    }

    // On page load, get planID and userID from URL and fetch plan details
    (function() {
        const urlParams = new URLSearchParams(window.location.search);
        const planID = urlParams.get('planID');
        const userID = urlParams.get('userID');
        if (planID) {
            fetchPlanDetails(planID);
        }
    })();

    // Handle payment submission
    document.getElementById("paymentForm").addEventListener("submit", function(event) {
        event.preventDefault();
        // Perform client-side validations as before

        // If all validations pass, make an AJAX call to update the database
        // Note: Ensure to perform server-side validations and handle the actual payment processing securely
        const paymentData = {
            userID: userID,
            planID: planID,
            //... other payment details
        };
        // Make an AJAX call to update the database
        // On successful payment, show a confirmation to the user
    });
</script>

<jsp:include page="customerFooter.jsp" />
</body>
