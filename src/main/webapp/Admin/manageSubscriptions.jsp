<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<jsp:include page="adminHeader.jsp" />
<%
  Properties properties = new Properties();
  try {
    // Load the configuration file
    String configFilePath = application.getRealPath("/WEB-INF/config.properties");
    properties.load(new FileInputStream(configFilePath));
  } catch (Exception e) {
    e.printStackTrace();
  }
  String servicesEndpoint = properties.getProperty("servicesEndpoint");

%>
<body>
<div class="wrapper">
  <jsp:include page="adminSidebar.jsp" />
  <div class="main-panel">
    <jsp:include page="adminNavbar.jsp" />
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <!-- Add Subscription Plan -->
          <div class="col-md-6">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title">Add Subscription Plan</h4>
              </div>
              <div class="card-body">
                <form id="addSubscriptionPlanForm">
                  <div class="form-group">
                    <label>Plan Name</label>
                    <input type="text" required class="form-control" placeholder="Plan Name"
                           name="PlanName">
                  </div>
                  <div class="form-group">
                    <label>Duration</label>
                    <input type="text" required class="form-control" placeholder="Duration"
                           name="Duration">
                  </div>
                  <div class="form-group">
                    <label>Price</label>
                    <input type="text" required class="form-control" placeholder="Price"
                           name="Price">
                  </div>
                  <button id="addSubscriptionPlanBtn" type="submit"
                          class="btn btn-primary">Add Subscription Plan</button>
                </form>
              </div>
            </div>
          </div>
          <!-- Update Subscription Plan -->
          <div class="col-md-6">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title">Update Subscription Plan</h4>
              </div>
              <div class="card-body">
                <form id="updateSubscriptionPlanForm">
                  <div class="form-group">
                    <label>Plan ID</label>
                    <input type="text" class="form-control"
                           placeholder="Existing Subscription Plan ID" id="subscriptionPlanIdInput"
                           name="subscriptionPlanIdInput" required>
                  </div>
                  <div class="form-group">
                    <label>Plan Name</label>
                    <input type="text" class="form-control" placeholder="New Plan Name"
                           name="newPlanName" required>
                  </div>
                  <div class="form-group">
                    <label>Duration</label>
                    <input type="text" class="form-control" placeholder="New Duration"
                           name="newDuration" required>
                  </div>
                  <div class="form-group">
                    <label>Price</label>
                    <input type="text" class="form-control" placeholder="New Price"
                           name="newPrice" required>
                  </div>
                  <button id="updateSubscriptionPlanBtn" type="submit"
                          class="btn btn-primary">Update Subscription Plan</button>
                </form>
              </div>
            </div>
          </div>
          <!-- Add Subscription Plan Script -->
          <script>
            // Function to handle the form submission for adding a subscription plan
            function submitAddSubscriptionPlanForm(event) {
              event.preventDefault(); // Prevent the default form submission

              const formData = {
                planName: document.querySelector('input[name="PlanName"]').value,
                duration: document.querySelector('input[name="Duration"]').value,
                price: document.querySelector('input[name="Price"]').value
              };

              // Perform a POST request to add the subscription plan
              // You should replace 'vurl' with the appropriate API endpoint
              const vurl = '<%=servicesEndpoint%>';
              const options = {
                method: "POST",

                headers: {
                  "content-type": "application/json"
                },
                body: JSON.stringify(formData)
              };

              fetch(vurl, options)
                      .then(response => {
                        if (response.ok) {

                          $.notify({
                            icon: "pe-7s-gift",
                            message: "Subscription plan added successfully"
                          }, {
                            type: 'success',
                            timer: 4000,
                            placement: {
                              from: 'top',
                              align: 'center'
                            }
                          });

                          document.querySelector('#addSubscriptionPlanForm').reset();
                          refreshSubscriptionPlanTable(); // Refresh the table
                        } else {
                          $.notify({
                            icon: "pe-7s-gift",
                            message: "An error occurred while adding the subscription plan. Please try again later."
                          }, {
                            type: 'danger',
                            timer: 4000,
                            placement: {
                              from: 'top',
                              align: 'center'
                            }
                          });
                        }
                      });
            }

            // Attach the form submission event handler
            document.getElementById("addSubscriptionPlanBtn").addEventListener("click", submitAddSubscriptionPlanForm);
          </script>


          <!-- Update Subscription Plan Script -->
          <script>
            // Function to handle the form submission for updating a subscription plan
            function submitUpdateSubscriptionPlanForm(event) {
              event.preventDefault();

              const formData = {
                subscriptionID:  document.querySelector('input[name="subscriptionPlanIdInput"]').value,
                planName: document.querySelector('input[name="newPlanName"]').value,
                duration: document.querySelector('input[name="newDuration"]').value,
                price: document.querySelector('input[name="newPrice"]').value
              };

              const subscriptionPlanId = document.querySelector('input[name="subscriptionPlanIdInput"]').value;

              const options = {
                method: "PUT",
                headers: {
                  "content-type": "application/json"
                },
                body: JSON.stringify(formData)
              };

              // Perform a PUT request to update the subscription plan
              // You should replace 'vucurl' with the appropriate API endpoint
              const vucurl = "<%=servicesEndpoint%>";
              fetch(vucurl + subscriptionPlanId, options)
                      .then(response => {
                        if (response.ok) {

                          $.notify({
                            icon: "pe-7s-gift",
                            message: "Subscription plan updated successfully"
                          }, {
                            type: 'success',
                            timer: 4000,
                            placement: {
                              from: 'top',
                              align: 'center'
                            }
                          });

                          refreshSubscriptionPlanTable(); // Refresh the table
                          document.querySelector('#updateSubscriptionPlanForm').reset();
                        } else {
                          $.notify({
                            icon: "pe-7s-gift",
                            message: "An error occurred while updating the subscription plan. Please try again later."
                          }, {
                            type: 'danger',
                            timer: 4000,
                            placement: {
                              from: 'top',
                              align: 'center'
                            }
                          });
                        }
                      });
            }

            // Attach the form submission event handler
            document.getElementById("updateSubscriptionPlanBtn").addEventListener("click", submitUpdateSubscriptionPlanForm);


          </script>
        </div>
      </div>

      <!-- Display Subscription Plans Table -->
      <div class="container-fluid">
        <div class="col-md-12">
          <div class="card">
            <div class="card-header">
              <h4 class="card-title">All Subscription Plans</h4>
            </div>
            <div class="card-body table-full-width table-responsive">
              <table class="table table-hover table-striped">
                <thead>
                <tr>
                  <th>ID</th>
                  <th>Plan Name</th>
                  <th>Duration</th>
                  <th>Price</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody id="subscriptionPlanTableBody">
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

      <!-- Script for Displaying Subscription Plans Table -->
      <script>
        // Initial load of subscription plans table
        refreshSubscriptionPlanTable();
        // Event listener for table row click
        $('#subscriptionPlanTableBody').on('click', 'tr', function () {
          const subscriptionPlanId = $(this).find('td:eq(0)').text();
          const planName = $(this).find('td:eq(1)').text();
          const duration = $(this).find('td:eq(2)').text();
          const price = $(this).find('td:eq(3)').text();

          // Populate the form fields with the data from the clicked row
          $('#subscriptionPlanIdInput').val(subscriptionPlanId);
          $('input[name="newPlanName"]').val(planName);
          $('input[name="newDuration"]').val(duration);
          $('input[name="newPrice"]').val(price);
        });


        // Function to refresh the subscription plans table
        function refreshSubscriptionPlanTable() {
          const url = '<%=servicesEndpoint%>/';
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
                    $('#subscriptionPlanTableBody').empty();
                    $.each(data, function (index, subscriptionPlan) {
                      const row = '<tr>' +
                              '<td>' + subscriptionPlan.subscriptionID + '</td>' +
                              '<td>' + subscriptionPlan.planName + '</td>' +
                              '<td>' + subscriptionPlan.duration + '</td>' +
                              '<td>' + subscriptionPlan.price + '</td>' +
                              '<td>' +
                              '<button type="button" class="btn btn-danger">Delete</button>' +
                              '</td>' +
                              '</tr>';
                      $('#subscriptionPlanTableBody').append(row);
                    });
                  })
                  .catch(error => console.error(error));
        }

        // Event handler for deleting a subscription plan
        $('#subscriptionPlanTableBody').on('click', 'button', function () {
          const subscriptionPlanId = $(this).closest('tr').find('td:eq(0)').text();
          const button = $(this);
          button.text('Processing...');
          const url = 'http://localhost:8080/echonosenserest_war_exploded/api/subscriptions/' + subscriptionPlanId;
          const options = {
            method: 'DELETE',
            headers: {
              'Content-Type': 'application/json'
            }
          };
          fetch(url, options)
                  .then(response => {
                    if (response.ok) {

                      $.notify({
                        icon: "pe-7s-gift",
                        message: "Subscription plan deleted successfully"
                      }, {
                        type: 'success',
                        timer: 4000,
                        placement: {
                          from: 'top',
                          align: 'center'
                        }
                      });
                      refreshSubscriptionPlanTable(); // Refresh the table
                    } else {
                      button.text('Delete');

                      $.notify({
                        icon: "pe-7s-gift",
                        message: "Failed to delete subscription plan: ${response.status}"
                      }, {
                        type: 'danger',
                        timer: 4000,
                        placement: {
                          from: 'top',
                          align: 'center'
                        }
                      });
                    }
                  })
                  .catch(error => {
                    console.error(error);
                    button.text('Delete');
                    $.notify({
                      icon: "pe-7s-gift",
                      message: "An error occurred while deleting the subscription plan."
                    }, {
                      type: 'danger',
                      timer: 4000,
                      placement: {
                        from: 'top',
                        align: 'center'
                      }
                    });
                  });
        });
      </script>
    </div>
  </div>
</div>
</body>

<jsp:include page="adminFooter.jsp" />
