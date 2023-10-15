    <jsp:include page="adminHeader.jsp"/>
    <body>
    <div class="wrapper">
        <jsp:include page="adminSidebar.jsp"/>
        <div class="main-panel">
            <jsp:include page="adminNavbar.jsp"/>
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6" id="userDetailsCard" style="display: none;">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">User Details</h4>
                                </div>
                                <div class="card-body">
                                    <form>
                                        <div class="form-group">
                                            <label for="customerId">Customer ID:</label>
                                            <input type="text" class="form-control" id="customerId" readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="firstName">First Name:</label>
                                            <input type="text" class="form-control" id="firstName" readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="lastName">Last Name:</label>
                                            <input type="text" class="form-control" id="lastName" readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="email">Email:</label>
                                            <input type="text" class="form-control" id="email" readonly>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- Update Password Card -->
                        <div class="col-md-6" id="updatePasswordCard" style="display: none;">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Update User Password</h4>
                                </div>
                                <div class="card-body">
                                    <form id="updatePasswordForm">
                                        <div class="form-group">
                                            <label for="updateCustomerId">Customer ID:</label>
                                            <input type="text" class="form-control" id="updateCustomerId" readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="newPassword">New Password:</label>
                                            <input type="password" class="form-control" id="newPassword" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Update Password</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">All Customers</h4>
                                </div>
                                <div class="card-body table-full-width table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>Email</th>

                                            <th>status</th>
                                            <th>Remove</th>
                                            <th>Update Status</th>
                                        </tr>
                                        </thead>
                                        <tbody id="customerTableBody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>


                        <!-- User Details Card -->





                        <script>
                            refreshTable();

                            $('#customerTableBody').on('click', 'tr', function () {
                                const customerId = $(this).find('td:eq(0)').text();
                                const firstName = $(this).find('td:eq(1)').text();
                                const lastName = $(this).find('td:eq(2)').text();
                                const email = $(this).find('td:eq(3)').text();

                                // Populate the user details card
                                $('#customerId').val(customerId);
                                $('#firstName').val(firstName);
                                $('#lastName').val(lastName);
                                $('#email').val(email);

                                // Show the user details card
                                $('#userDetailsCard').show();
                            });


                            $('#customerTableBody').on('click', '.delete-button', function () {
                                const customerId = $(this).closest('tr').find('td:eq(0)').text();
                                const button = $(this);
                                button.text('Processing...');
                                const url = 'http://localhost:8080/echonosenserest_war_exploded/api/users/' + customerId;
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
                                                message: "Customer deleted successfully"
                                            },{
                                                type: 'warning',
                                                timer: 4000,
                                                placement: {
                                                    from: 'top',
                                                    align: 'center'
                                                }
                                            });


                                            refreshTable();
                                        } else {
                                            button.text('Delete');
                                            alert(`Failed to delete customer: ${response.status}`);
                                        }
                                    })
                                    .catch(error => {
                                        console.error(error);
                                        button.text('Delete');



                                        $.notify({
                                            icon: "pe-7s-gift",
                                            message: "An error occurred"
                                        },{
                                            type: 'danger',
                                            timer: 4000,
                                            placement: {
                                                from: 'top',
                                                align: 'center'
                                            }
                                        });
                                    });
                            });

                            $('#customerTableBody').on('click', '.update-status-button', function () {
                                const customerId = $(this).closest('tr').find('td:eq(0)').text();
                                const currentStatus = $(this).closest('tr').find('td:eq(4)').text(); // Assuming status is in the 5th column
                                const newStatus = currentStatus === 'active' ? 'inactive' : 'active'; // Toggle status

                                const url = 'http://localhost:8080/echonosenserest_war_exploded/api/users/status/' + customerId + '/' + newStatus;
                                const options = {
                                    method: 'PUT',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    }
                                };

                                fetch(url, options)
                                    .then(response => {
                                        if (response.ok) {




                                            $.notify({
                                                icon: "pe-7s-gift",
                                                message: "User status updated successfully"
                                            },{
                                                type: 'success',
                                                timer: 4000,
                                                placement: {
                                                    from: 'top',
                                                    align: 'center'
                                                }
                                            });
                                            refreshTable();
                                        } else {


                                            $.notify({
                                                icon: "pe-7s-gift",
                                                message: "Failed to update user status: ${response.status}"
                                            },{
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

                                        $.notify({
                                            icon: "pe-7s-gift",
                                            message: "An error occurred"
                                        },{
                                            type: 'danger',
                                            timer: 4000,
                                            placement: {
                                                from: 'top',
                                                align: 'center'
                                            }
                                        });
                                    });
                            });

                            function refreshTable() {
                                const url = 'http://localhost:8080/echonosenserest_war_exploded/api/users';
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
                                        $('#customerTableBody').empty();
                                        // Populate the table with the data
                                        $.each(data, function (index, user) {
                                            const row = '<tr>' +
                                                '<td>' + user.userId + '</td>' +
                                                '<td>' + user.fname + '</td>' +
                                                '<td>' + user.lName + '</td>' +
                                                '<td>' + user.email + '</td>' +
                                                '<td>' + user.status + '</td>' +
                                                '<td>' +
                                                '<button type="button" class="btn btn-danger delete-button">Delete</button>' +
                                                '</td>' +
                                                '<td>' +
                                                '<button type="button" class="btn btn-primary update-status-button">Update Status</button>' +
                                                '</td>' +
                                                '</tr>';
                                            $('#customerTableBody').append(row);
                                        });
                                    })
                                    .catch(error => console.error(error));
                            }

                            // Show the update password card when a user row is clicked
                            $('#customerTableBody').on('click', 'tr', function () {
                                const customerId = $(this).find('td:eq(0)').text();
                                $('#updateCustomerId').val(customerId);
                                $('#updatePasswordCard').show();
                            });

                            // Handle the password update form submission
                            $('#updatePasswordForm').on('submit', function (e) {
                                e.preventDefault();

                                const customerId = $('#updateCustomerId').val();
                                const newPassword = $('#newPassword').val();



                                var passhash = CryptoJS.MD5(newPassword).toString();


                                const url = 'http://localhost:8080/echonosenserest_war_exploded/api/users/' + customerId + '/password';
                                const options = {
                                    method: 'PUT',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    body: passhash
                                };

                                fetch(url, options)
                                    .then(response => {
                                        if (response.ok) {

                                            $('#newPassword').val(''); // Clear the password input


                                            $.notify({
                                                icon: "pe-7s-gift",
                                                message: "Password updated successfully"
                                            },{
                                                type: 'success',
                                                timer: 4000,
                                                placement: {
                                                    from: 'top',
                                                    align: 'center'
                                                }
                                            });

                                        } else {
                                            alert(`Failed to update password: ${response.status}`);
                                        }
                                    })
                                    .catch(error => {
                                        console.error(error);

                                        $.notify({
                                            icon: "pe-7s-gift",
                                            message: "An error occurred"
                                        },{
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


        </div>
    </div>
    </body>
    </html>
