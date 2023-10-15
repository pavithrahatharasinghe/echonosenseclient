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
  refreshTable();

  function refreshTable() {
    const url = 'http://localhost:8080/echonosenserest_war_exploded/api/payments'; // Replace with your actual endpoint
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
              // Clear the table body
              $('#paymentTableBody').empty();
              // Populate the table with the data
              $.each(data, function (index, payment) {
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
</script>
</body>
