<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 10/7/2023
  Time: 9:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if the login cookie is set
    boolean isLoggedIn = false;
    String userRole = null; // Assuming user role is stored in a cookie or session attribute
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("isLoggedIn")) {
                if (cookie.getValue().equals("1")) {
                    isLoggedIn = true;
                }
            }
            if (cookie.getName().equals("role")) {
                userRole = cookie.getValue();
            }
        }
    }

    // If user is not logged in or not an admin, redirect to login page
    if (!isLoggedIn || !("admin".equals(userRole))) {
        response.sendRedirect("../login.jsp");
    }

    if (isLoggedIn && request.getParameter("logout") != null) {
        Cookie logoutCookie = new Cookie("isLoggedIn", "0");
        logoutCookie.setMaxAge(0);
        response.addCookie(logoutCookie);
        response.sendRedirect("../login.jsp");
    }
%>
<html>

<head>
    <meta charset="utf-8"/>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>Admin Dashboard</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
          name='viewport'/>
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"/>
    <!-- CSS Files -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="../assets/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet"/>
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="../assets/css/demo.css" rel="stylesheet"/>
    <!-- Include jQuery from a CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../assets/js/core/jquery.3.2.1.min.js"></script>
    <script src="../assets/js/core/bootstrap.min.js"></script>
    <script src="../assets/js/core/popper.min.js"></script>
    <script src="../assets/js/plugins/bootstrap-notify.js"></script>
    <script src="../assets/js/plugins/bootstrap-datepicker.js"></script>
    <script src="../assets/js/plugins/bootstrap-switch.js"></script>

</head>
