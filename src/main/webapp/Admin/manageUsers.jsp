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

                        <!-- ... (previous code) -->

                        <!-- ... (previous code) -->

                        <script>
                            refreshTable();

                            $('#customerTableBody').on('click', 'tr', function () {
                                const customerId = $(this).find('td:eq(0)').text();
                                const firstName = $(this).find('td:eq(1)').text();
                                const lastName = $(this).find('td:eq(2)').text();
                                const email = $(this).find('td:eq(3)').text();

                                $('input[placeholder="Existing Customer ID"]').val(customerId);
                                $('input[placeholder="New First Name"]').val(firstName);
                                $('input[placeholder="New Last Name"]').val(lastName);
                                $('input[placeholder="New Email"]').val(email);
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
                                            const message = 'Customer deleted successfully';
                                            alert(message);
                                            refreshTable();
                                        } else {
                                            button.text('Delete');
                                            alert(`Failed to delete customer: ${response.status}`);
                                        }
                                    })
                                    .catch(error => {
                                        console.error(error);
                                        button.text('Delete');
                                        alert('An error occurred');
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
                                            const message = 'User status updated successfully';
                                            alert(message);
                                            refreshTable();
                                        } else {
                                            alert(`Failed to update user status: ${response.status}`);
                                        }
                                    })
                                    .catch(error => {
                                        console.error(error);
                                        alert('An error occurred');
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
                        </script>

                        <!-- ... (remaining code) -->


                    </div>

                </div>
            </div>


        </div>
    </div>
    </body>
    </html>
