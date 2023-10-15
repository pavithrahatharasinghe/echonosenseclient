<jsp:include page="adminHeader.jsp"/>

<body>
<div class="wrapper">
  <jsp:include page="adminSidebar.jsp"/>
  <div class="main-panel">
    <jsp:include page="adminNavbar.jsp"/>
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title">All Payments</h4>
              </div>
              <div class="card-body table-full-width table-responsive">
                <table class="table table-hover table-striped">
                  <thead>
                  <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Amount</th>
                    <th>Payment Date</th>
                    <th>Payment Method</th>
                    <th>Subscription ID</th>
                    <th>Reference ID</th>

                  </tr>
                  </thead>
                  <tbody id="paymentTableBody">
                  </tbody>
                </table>
                <div class="pagination-controls-payments">
                  <button onclick="previousPagePayments()">Previous</button>
                  <button onclick="nextPagePayments()">Next</button>
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="adminFooter.jsp"/>

<script>
  let currentPagePayments = 1; // Start on page 1 for payments
  const itemsPerPagePayments = 20; // Display 20 payments per page

  function refreshPaymentTable() {
    const url = 'http://localhost:8080/echonosenserest_war_exploded/api/payments';
    const options = {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    };

    fetch(url, options)
            .then(response => response.json())
            .then(data => {
              console.log(data);
              $('#paymentTableBody').empty();

              // Calculate start and end indices for slicing the data array
              const startIndex = (currentPagePayments - 1) * itemsPerPagePayments;
              const endIndex = startIndex + itemsPerPagePayments;

              const pageData = data.slice(startIndex, endIndex);

              $.each(pageData, function (index, payment) {
                const row = '<tr>' +
                        '<td>' + payment.paymentID + '</td>' +
                        '<td>' + payment.userID + '</td>' +
                        '<td>' + payment.amount + '</td>' +
                        '<td>' + payment.paymentDate + '</td>' +
                        '<td>' + payment.paymentMethod + '</td>' +
                        '<td>' + payment.subscriptionID + '</td>' +
                        '<td>' + payment.referenceID + '</td>' +
                        '</tr>';
                $('#paymentTableBody').append(row);
              });
            })
            .catch(error => console.error(error));
  }

  function nextPagePayments() {
    currentPagePayments++;
    refreshPaymentTable();
  }

  function previousPagePayments() {
    if (currentPagePayments > 1) {
      currentPagePayments--;
      refreshPaymentTable();
    }
  }


  refreshPaymentTable();
</script>
</body>
