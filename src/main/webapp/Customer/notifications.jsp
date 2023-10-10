<jsp:include page="customerHeader.jsp" />
<body>
<div class="wrapper">
    <jsp:include page="customerSidebar.jsp" />
    <div class="main-panel">
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Your Notifications</h4>
                            </div>
                            <div class="card-body table-full-width table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Date</th>

                                        <th>Content</th>
                                        <th>Delete</th>
                                    </tr>
                                    </thead>
                                    <tbody id="notificationTableBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <script>
                        const storedEmail = getCookie("Customer_email");
                        const notificationUrl = `http://localhost:8080/echonosenserest_war_exploded/api/notifications/user/123`;

                        function getCookie(name) {
                            const value = `; ${document.cookie}`;
                            const parts = value.split(`; ${name}=`);
                            if (parts.length === 2) return parts.pop().split(';').shift();
                        }

                        function refreshNotificationsTable() {
                            fetch(notificationUrl)
                                .then(response => response.json())
                                .then(data => {
                                    $('#notificationTableBody').empty();
                                    $.each(data, function (index, notification) {
                                        const row = '<tr>' +
                                            '<td>' + notification.notificationID + '</td>' +
                                            '<td>' + notification.date + '</td>' +

                                            '<td>' + notification.message + '</td>' +
                                            '<td>' +
                                            '<button type="button" class="btn btn-danger delete-notification-button">Delete</button>' +
                                            '</td>' +
                                            '</tr>';
                                        $('#notificationTableBody').append(row);
                                    });
                                })
                                .catch(error => console.error(error));
                        }

                        $('#notificationTableBody').on('click', '.delete-notification-button', function () {
                            const notificationId = $(this).closest('tr').find('td:eq(0)').text();
                            const button = $(this);
                            button.text('Processing...');
                            const url = `http://localhost:8080/echonosenserest_war_exploded/api/notifications/${notificationId}`;
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
                                        refreshNotificationsTable();
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

                        refreshNotificationsTable();
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<jsp:include page="customerFooter.jsp" />
