<jsp:include page="adminHeader.jsp"/>
<body>
<div class="wrapper">
    <jsp:include page="adminSidebar.jsp"/> <!-- This will include the sidebar -->
    <div class="main-panel">
        <!-- Navbar -->
        <jsp:include page="adminNavbar.jsp"/>
        <!-- End Navbar -->
        <div class="main-panel">
            <!-- Navbar -->
            <!-- End Navbar -->
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Add Notification</h4>
                                </div>
                                <div class="card-body">
                                    <form id="addNotificationForm">
                                        <div class="form-group">
                                            <label>Message</label>
                                            <textarea type="text" required class="form-control" placeholder="Notification Message"
                                                      name="Notification_Message" style="height: 250px;"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>User Selection</label>
                                            <div>
                                                <input type="radio" id="allUsers" name="userSelection" value="all" checked>
                                                <label for="allUsers">All Users</label>
                                            </div>
                                            <div>
                                                <input type="radio" id="specificUser" name="userSelection" value="specific">
                                                <label for="specificUser">Specific User:</label>
                                                <input type="number" class="form-control" placeholder="User ID" name="UserID_Add" disabled>
                                            </div>
                                        </div>

                                        <button id="addNotificationBtn" type="submit" class="btn btn-primary">Add Notification</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <script>
                            const currentDate = new Date().toISOString();
                            const vurl = "http://localhost:8080/echonosenserest_war_exploded/api/notifications";

                            document.querySelectorAll('input[name="userSelection"]').forEach(radio => {
                                radio.addEventListener('change', function () {
                                    const userIdInput = document.querySelector('input[name="UserID_Add"]');
                                    if (this.value === 'all') {
                                        userIdInput.disabled = true;
                                        userIdInput.value = '0'; // Set to default value of 0 for "All Users"
                                    } else {
                                        userIdInput.disabled = false;
                                        userIdInput.value = ''; // Clear the input
                                    }
                                });
                            });

                            function submitForm(event) {
                                event.preventDefault(); // Prevent the default form submission

                                const userSelection = document.querySelector('input[name="userSelection"]:checked').value;

                                let formData = {
                                    message: document.querySelector('textarea[name="Notification_Message"]').value.toString(),
                                    date: currentDate,
                                    updatedAt: currentDate,
                                };

                                if (userSelection === 'specific') {
                                    formData.userID = parseInt(document.querySelector('input[name="UserID_Add"]').value);
                                } else {
                                    // Default to "All Users"
                                    formData.userID = 0;
                                }

                                console.log(formData);

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
                                            alert("Notification added successfully");
                                            document.querySelector('#addNotificationForm').reset();
                                            refreshTable();
                                        } else {
                                            alert("An error occurred while adding the notification. Please try again later.");
                                        }
                                    });
                            }

                            document.getElementById("addNotificationBtn").addEventListener("click", submitForm);
                        </script>


                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Update Notification</h4>
                                </div>
                                <div class="card-body">
                                    <form>
                                        <div class="form-group">
                                            <label>Notification ID</label>
                                            <input type="text" class="form-control"
                                                   placeholder="Existing Notification ID" id="notificationIdInput"
                                                   name="notificationIdInput"
                                                   disabled
                                                   value="3">
                                        </div>
                                        <div class="form-group">
                                            <label>Message</label>
                                            <input type="text" class="form-control" placeholder="New Notification Message"
                                                   name="newNotificationMessage" required>
                                        </div>
                                        <div class="form-group">
                                            <label>User Selection</label>
                                            <div>
                                                <input type="radio" id="allUsers" name="userSelection" value="all" checked>
                                                <label for="allUsers">All Users</label>
                                            </div>
                                            <div>
                                                <input type="radio" id="specificUser" name="userSelection" value="specific">
                                                <label for="specificUser">Specific User:</label>
                                                <input type="number" class="form-control" placeholder="User ID" name="UserID_Update" disabled>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Date</label>
                                            <input type="date" required class="form-control" name="Date_Update">
                                        </div>
                                        <button id="updateNotificationBtn" type="submit" class="btn btn-primary">Update Notification</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <script>
                            document.querySelectorAll('input[name="userSelection"]').forEach(radio => {
                                radio.addEventListener('change', function() {
                                    const userIdInput = document.querySelector('input[name="UserID_Update"]');
                                    if (this.value === 'all') {
                                        userIdInput.disabled = true;
                                        userIdInput.value = '0'; // Set to default value of 0 for "All Users"
                                    } else {
                                        userIdInput.disabled = false;
                                        userIdInput.value = ''; // Clear the input
                                    }
                                });
                            });

                            const vucurl = "http://localhost:8080/echonosenserest_war_exploded/api/notifications/";

                            function submitUpdateForm(event) {
                                event.preventDefault();

                                const formData = {
                                    message: document.querySelector('input[name="newNotificationMessage"]').value,
                                    userID: parseInt(document.querySelector('input[name="UserID_Update"]').value),
                                    date: new Date(document.querySelector('input[name="Date_Update"]').value).toISOString()
                                };

                                console.log(formData);

                                const notificationId = document.querySelector('input[name="notificationIdInput"]').value;

                                const options = {
                                    method: "PUT",
                                    headers: {
                                        "content-type": "application/json"
                                    },
                                    body: JSON.stringify(formData)
                                };

                                fetch(vucurl + notificationId, options)
                                    .then(response => {
                                        if (response.ok) {
                                            alert("Notification updated successfully");
                                            refreshTable();
                                            document.querySelector('form').reset();
                                        } else {
                                            alert("An error occurred while updating the notification. Please try again later.");
                                        }
                                    });
                            }

                            document.getElementById("updateNotificationBtn").addEventListener("click", submitUpdateForm);
                        </script>


                    </div>
                    <div class="container-fluid">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">All Notifications</h4>
                                </div>
                                <div class="card-body table-full-width table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Message</th>
                                            <th>Senet Date</th>
                                            <th>updated At</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody id="notificationTableBody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <script>
                            refreshTable();

                            $('#notificationTableBody').on('click', 'tr', function () {
                                const notificationId = $(this).find('td:eq(0)').text();
                                const notificationMessage = $(this).find('td:eq(1)').text();

                                $('input[placeholder="Existing Notification ID"]').val(notificationId);
                                $('input[placeholder="New Notification Message"]').val(notificationMessage);
                            });

                            $('#notificationTableBody').on('click', 'button', function () {
                                const notificationId = $(this).closest('tr').find('td:eq(0)').text();
                                const button = $(this);
                                button.text('Processing...');
                                const url = 'http://localhost:8080/echonosenserest_war_exploded/api/notifications/' + notificationId;
                                const options = {
                                    method: 'DELETE',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    }
                                };
                                fetch(url, options)
                                    .then(response => {
                                        if (response.ok) {
                                            const message = 'Notification deleted successfully';
                                            alert(message);
                                            refreshTable();
                                        } else {
                                            button.text('Delete');
                                            alert(`Failed to delete notification: ${response.status}`);
                                        }
                                    })
                                    .catch(error => {
                                        console.error(error);
                                        button.text('Delete');
                                        alert('An error occurred');
                                    });
                            });

                            function refreshTable() {
                                const url = 'http://localhost:8080/echonosenserest_war_exploded/api/notifications';
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
                                        $('#notificationTableBody').empty();
                                        $.each(data, function (index, notification) {
                                            const row = '<tr>' +
                                                '<td>' + notification.notificationID + '</td>' +
                                                '<td>' + notification.message + '</td>' +
                                                '<td>' + notification.date + '</td>' +
                                                '<td>' + notification.updatedAt + '</td>' +
                                                '<td>' +
                                                '<button type="button" class="btn btn-danger">Delete</button>' +
                                                '</td>' +
                                                '</tr>';
                                            $('#notificationTableBody').append(row);
                                        });
                                    })
                                    .catch(error => console.error(error));
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<jsp:include page="adminFooter.jsp"/>
