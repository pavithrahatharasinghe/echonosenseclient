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
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        .card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border: none;
            border-radius: 5px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            color: #ffffff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            color: #ffffff;
        }

        .login-form {
            max-width: 400px;
            margin: 50px auto;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-5">
            <div class="card">
                <div class="card-header text-center">
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
                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const loginUrl = "<%= host %>" + "users/login";

    function setCookie(name, value) {
        document.cookie = `${name}=${value}; path=/`;
    }

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
            .then(response => response.json()) // Parse the response as JSON
            .then(user => {
                if (user && user.userId) {
                    alert("Login successful");

                    // Set cookies for user information
                    setCookie("userId", user.userId);
                    setCookie("fname", user.fname);
                    setCookie("lName", user.lName);
                    setCookie("email", user.email);
                    setCookie("role", user.role);
                    setCookie("status", user.status);
                    if (user.status === "active") {
                        if (user.role === "admin") {
                            window.location.replace("admin/setAdminLoginCookies.jsp?email=" + formData.email+ "&userId="+user.userId );
                        } else if (user.role === "customer") {
                            window.location.replace("Customer/setCustomerLoginCookies.jsp?email=" + formData.email+ "&userId="+user.userId);
                        } else {
                            alert("Invalid user role");
                        }

                    } else {
                        alert("User Is Inactive Please Contact Site Admin ");
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




</body>
</html>
