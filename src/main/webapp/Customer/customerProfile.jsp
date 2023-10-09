<jsp:include page="customerHeader.jsp" />

<body>
<div class="wrapper">
    <jsp:include page="customerSidebar.jsp" />
    <div class="main-panel">
        <jsp:include page="customerNavbar.jsp" />
        <div class="content">
            <div class="container-fluid">

                <!-- View and Update Personal Details -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">My Profile</h4>
                        </div>
                        <div class="card-body">
                            <form id="updateProfileForm">
                                <div class="form-group">
                                    <label>Name</label>
                                    <input type="text" required class="form-control" placeholder="Name" name="Name">
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" required class="form-control" placeholder="Email" name="Email">
                                </div>
                                <button id="updateProfileBtn" type="submit" class="btn btn-primary">Update Profile</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Change Password -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Change Password</h4>
                        </div>
                        <div class="card-body">
                            <form id="changePasswordForm">
                                <div class="form-group">
                                    <label>Current Password</label>
                                    <input type="password" required class="form-control" placeholder="Current Password" name="currentPassword">
                                </div>
                                <div class="form-group">
                                    <label>New Password</label>
                                    <input type="password" required class="form-control" placeholder="New Password" name="newPassword">
                                </div>
                                <div class="form-group">
                                    <label>Confirm New Password</label>
                                    <input type="password" required class="form-control" placeholder="Confirm New Password" name="confirmNewPassword">
                                </div>
                                <button id="changePasswordBtn" type="submit" class="btn btn-primary">Change Password</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Scripts for Profile Operations -->
                <script>
                    document.getElementById("updateProfileBtn").addEventListener("click", function(event) {
                        event.preventDefault();

                        // Add logic to send the updated profile information to the server.
                    });

                    document.getElementById("changePasswordBtn").addEventListener("click", function(event) {
                        event.preventDefault();

                        const newPassword = document.querySelector('input[name="newPassword"]').value;
                        const confirmNewPassword = document.querySelector('input[name="confirmNewPassword"]').value;

                        if (newPassword !== confirmNewPassword) {
                            alert("New passwords do not match!");
                            return;
                        }

                        // Add logic to send the password change request to the server.
                    });
                </script>

            </div>
        </div>
    </div>
</div>
</body>

<jsp:include page="customerFooter.jsp" />
