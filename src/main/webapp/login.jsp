<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>

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
%>

<html>
<head>
    <!-- ... (rest of your head content) ... -->
</head>
<body>

<div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">Login</h4>
            </div>
            <div class="card-body">
                <form class="login-form">
                    <div class="form-group">
                        <label for="emailInput">Email</label>
                        <input type="email" class="form-control" id="emailInput" name="email" required placeholder="user@example.com">
                    </div>
                    <div class="form-group">
                        <label for="passwordInput">Password</label>
                        <input type="password" class="form-control" id="passwordInput" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Login</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        const loginUrl = "<%= host %>" + "users/login";

        function submitLoginForm(event) {
            event.preventDefault();

            const formData = {
                email: document.querySelector('input[name="email"]').value,
                password: document.querySelector('input[name="password"]').value
            };

            const requestOptions = {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(formData)
            };

            fetch(loginUrl, requestOptions)
                .then(response => response.text())  // Change this to get the response as text
                .then(role => {


                    if (role) {
                        alert("Login successful");
                        document.cookie = `admin_username=${usernameInput.value}`;
                        document.cookie = `isLoggedIn=1`;
                        console.log(role);
                        //window.location.href = "adminDashboard.jsp";
                            if (role === "admin") {
                            window.location.href = "admin/adminDashboard.jsp";
                        } else if (role === "customer") {
                            window.location.href = "Customer/customerDashboard.jsp";
                        } else {
                            alert("Invalid user role");
                        }
                    } else {
                        alert("Login failed. Please try again.");
                    }
                })
                .catch(error => {
                    console.error("Error during login:", error);
                    alert("Login failed. Please try again.");
                });

        }

        document.querySelector(".login-form").addEventListener("submit", submitLoginForm);
    </script>

    <div class="col-md-4"></div>
</div>

</body>
</html>
