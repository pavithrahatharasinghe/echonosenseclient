<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>

<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%
    Properties properties = new Properties();
    try {
        // Load the configuration file
        String configFilePath = application.getRealPath("/WEB-INF/config.properties");
        properties.load(new FileInputStream(configFilePath));
    } catch (Exception e) {
        e.printStackTrace();
    }
    String host = properties.getProperty("host.url");
    String userId = ""; // Initialize userId
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = cookie.getValue();
                break;
            }
        }
    }
    // Fetch user details using userId from a server endpoint
    String userDetails = ""; // Initialize userDetails
    try {
        String userDetailsUrl = host + "users/" + userId; // Replace with your API endpoint
        java.net.URL url = new java.net.URL(userDetailsUrl);
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        if (conn.getResponseCode() == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
            String output;
            while ((output = br.readLine()) != null) {
                userDetails += output;
            }
        } else {
            userDetails = null;
        }
        conn.disconnect();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
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
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Change Password</h4>
                        </div>
                        <div class="card-body">
                            <form id="updatePasswordForm">
                                <div class="form-group">
                                    <label for="currentPassword">Current Password</label>
                                    <input type="password" required class="form-control" id="currentPassword" name="currentPassword">
                                </div>
                                <div class="form-group">
                                    <label for="newPassword">New Password</label>
                                    <input type="password" required class="form-control" id="newPassword" name="newPassword">
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">Confirm New Password</label>
                                    <input type="password" required class="form-control" id="confirmPassword" name="confirmPassword">
                                </div>
                                <button id="updatePasswordBtn" type="submit" class="btn btn-primary">Update Password</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<script>
    // Function to handle the form submission for updating the password
    function submitUpdatePasswordForm(event) {
        event.preventDefault();

        const currentPassword = document.querySelector('input[name="currentPassword"]').value;
        const newPassword = document.querySelector('input[name="newPassword"]').value;
        const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;

        // Check if the new password and confirm password match
        if (newPassword !== confirmPassword) {
            alert("New password and confirm password do not match.");
            return;
        }

        const userId = <%= userId %>;

        const formData = {
            currentPassword: currentPassword,
            newPassword: newPassword
        };

        sendpw =  newPassword;

        const options = {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: sendpw
        };

        // Replace 'vucurl' with the appropriate API endpoint
        const vucurl = "http://localhost:8080/echonosenserestnew_war_exploded/api/users/" + userId + "/password";

        // Add password validation on the client side
        if (currentPassword === newPassword) {
            alert("New password should be different from the current password.");
        } else {
            fetch(vucurl, options)
                .then(response => {
                    if (response.ok) {
                        return response.text();
                    } else {
                        return response.text().then(error => Promise.reject(error));
                    }
                })
                .then(message => {
                    alert(message);
                })
                .catch(error => {
                    alert("An error occurred while updating the password. Please try again later.\nError: " + error);
                });
        }
    }

    // Attach the form submission event handler
    document.getElementById("updatePasswordBtn").addEventListener("click", submitUpdatePasswordForm);
</script>



<script>
    const userDetails = <%= userDetails %>;

    // Function to populate the form with user details
    function populateUserDetails() {
        if (userDetails) {
            document.querySelector('input[name="firstName"]').value = userDetails.fname;
            document.querySelector('input[name="lastName"]').value = userDetails.lName;
            document.querySelector('input[name="email"]').value = userDetails.email;
            document.querySelector('input[name="userId"]').value = userDetails.userId;
        }
    }

    // Function to handle the form submission for updating user information
    function submitUpdateUserForm(event) {
        event.preventDefault();

        const formData = {
            firstName: document.querySelector('input[name="firstName"]').value,
            lastName: document.querySelector('input[name="lastName"]').value,
            email: document.querySelector('input[name="email"]').value
        };

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

    // Populate the form with user details
    window.addEventListener('load', populateUserDetails);
</script>

<jsp:include page="customerFooter.jsp" />