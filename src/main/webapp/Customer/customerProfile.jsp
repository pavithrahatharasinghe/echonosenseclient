<jsp:include page="customerHeader.jsp" />

<div class="wrapper">
    <jsp:include page="customerSidebar.jsp" />
    <div class="main-panel">
        <!-- Include the navbar -->
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
                                    <label>First Name</label>
                                    <input type="text" required class="form-control" placeholder="First Name" name="firstName">
                                </div>
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" required class="form-control" placeholder="Last Name" name="lastName">
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" required class="form-control" placeholder="Email" name="email">
                                </div>
                                <!-- Add a hidden input for userId -->
                                <input type="hidden" name="userId" value="1">
                                <button id="updateProfileBtn" type="submit" class="btn btn-primary">Update Profile</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Function to handle the form submission for updating user information
    function submitUpdateUserForm(event) {
        event.preventDefault();

        const formData = {
            firstName: document.querySelector('input[name="firstName"]').value,
            lastName: document.querySelector('input[name="lastName"]').value,
            email: document.querySelector('input[name="email"]').value
        };

        // Assuming you have a hidden input for userId
        const userId = document.querySelector('input[name="userId"]').value;

        const options = {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(formData)
        };

        // Replace 'vucurl' with the appropriate API endpoint
        const vucurl = `http://localhost:8080/echonosenserest_war_exploded/api/users/${userId}`;
        fetch(vucurl, options)
            .then(response => {
                if (response.ok) {
                    alert("User information updated successfully");
                } else {
                    alert("An error occurred while updating user information. Please try again later.");
                }
            });
    }

    // Attach the form submission event handler
    document.getElementById("updateProfileBtn").addEventListener("click", submitUpdateUserForm);
</script>

<jsp:include page="customerFooter.jsp" />