<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 4/6/2023
  Time: 8:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Cookie[] cookies = request.getCookies(); // Get all cookies sent by the client
  if (cookies != null) {
    for (Cookie cookie : cookies) {
      if (cookie.getName().equals("isLoggedIn")) { // Check if the cookie with name "isLoggedIn" exists
        cookie.setValue("0"); // Update the cookie value to "0"
        response.addCookie(cookie); // Add the updated cookie to the response object

      }
      if (cookie.getName().equals("customer_email")) { // Check if the cookie with name "isLoggedIn" exists
        cookie.setValue(""); // Update the cookie value to "0"
        response.addCookie(cookie); // Add the updated cookie to the response object
      }
      if (cookie.getName().equals("admin_email")) { // Check if the cookie with name "isLoggedIn" exists
        cookie.setValue("0"); // Update the cookie value to "0"
        response.addCookie(cookie); // Add the updated cookie to the response object

      }
    }
  }
  response.sendRedirect("login.jsp"); // Redirect the user to login.jsp page
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
