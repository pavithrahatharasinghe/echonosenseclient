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
    <title>Register</title>
    <meta charset="utf-8"/>
    <script src="assets/js/core/jquery.3.2.1.min.js"></script>
    <script src="assets/js/core/bootstrap.min.js"></script>
    <script src="assets/js/core/popper.min.js"></script>
    <script src="assets/js/plugins/bootstrap-notify.js"></script>
    <script src="assets/js/plugins/bootstrap-datepicker.js"></script>
    <script src="assets/js/plugins/bootstrap-switch.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/core.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/md5.js"></script>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-notify/0.2.0/js/bootstrap-notify.js"></script>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
          name='viewport'/>
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"/>
    <!-- CSS Files -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="assets/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet"/>
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="assets/css/demo.css" rel="stylesheet"/>
    <!-- Include jQuery from a CDN -->

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
            background-color: #AF9700;
            border-color: #AF9700;
            color: #ffffff;
        }

        .btn-primary:hover {
            background-color: #AF9100;
            border-color: #AF9100;
            color: #ffffff;
        }

        .register-form {
            max-width: 400px;
            margin: 50px auto;
        }

        .register-container {
            display: flex;
            align-items: center;
        }

        .register-image {
            flex: 1;
            padding: 20px;
        }

        .register-image img {
            max-width: 100%;
            height: auto;
        }

        .register-form-container {
            flex: 1;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card">
                <div class="card-body">
                    <div class="register-container">
                        <div class="register-image">
                            <img style="width: auto" src="webimages/EchonoSenseLogin.png"/>
                        </div>
                        <div class="register-form-container">
                            <div class="card-header text-center">
                                <h4 class="card-title">Sign Up</h4>
                            </div>
                            <form class="register-form" method="post" action="<%= host %>users/register">
                                <div class="form-group">
                                    <label for="firstNameInput">First Name</label>
                                    <input type="text" class="form-control" id="firstNameInput" name="firstName"
                                           required>
                                </div>
                                <div class="form-group">
                                    <label for="lastNameInput">Last Name</label>
                                    <input type="text" class="form-control" id="lastNameInput" name="lastName" required>
                                </div>
                                <div class="form-group">
                                    <label for="emailInput">Email</label>
                                    <input type="email" class="form-control" id="emailInput" name="email" required
                                           placeholder="user@example.com">
                                </div>
                                <div class="form-group">
                                    <label for="passwordInput">Password</label>
                                    <input type="password" class="form-control" id="passwordInput" name="password"
                                           required>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">Register</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    const registerUrl = "<%= host %>" + "users";

    function setCookie(name, value) {
        document.cookie = `${name}=${value}; path=/`;
    }

    function submitRegistrationForm(event) {
        event.preventDefault();

        var password = document.querySelector('input[name="password"]').value;
        var passhash = CryptoJS.MD5(password).toString();

        const formData = {
          fname: document.querySelector('input[name="firstName"]').value,
          lName: document.querySelector('input[name="lastName"]').value,
          email: document.querySelector('input[name="email"]').value,
          password: passhash,
          status: 'active',
          role : 'customer'
        };







        const requestOptions = {
            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(formData)
        };

        fetch(registerUrl, requestOptions)

                .then(response => {
                  if (response.status === 201){
                    $.notify({
                        icon: "pe-7s-gift",
                        message: "Registration successful"
                    }, {
                        type: 'success',
                        timer: 4000,
                        placement: {
                            from: 'top',
                            align: 'center'
                        }
                    });

                    // Redirect to a success page or perform other actions as needed
                    window.location.replace("login.jsp");
                } else {
                    alert("Registration failed. Please try again.");
                }
            })
            .catch(error => {
                console.error("Error during registration:", error);
                alert("Registration failed. Please try again.");
            });
    }

    document.querySelector(".register-form").addEventListener("submit", submitRegistrationForm);
</script>
</body>
</html>
