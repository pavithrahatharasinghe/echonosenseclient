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
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("isLoggedIn")) {
                if (cookie.getValue().equals("1")) {
                    isLoggedIn = true;
                }
                break;
            }
        }
    }
    // If user is not logged in, redirect to login page
    if (!isLoggedIn) {
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
    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="../assets/img/favicon.ico">
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
</head>
