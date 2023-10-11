<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 10/10/2023
  Time: 8:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Cookie adminEmail = new Cookie("admin_email", request.getParameter("email"));

  adminEmail.setPath("/");
  adminEmail.setMaxAge(60 * 60 * 1);
  response.addCookie(adminEmail);

  Cookie userId = new Cookie("userId", request.getParameter("userId"));

  userId.setPath("/");
  userId.setMaxAge(60 * 60 * 1);
  response.addCookie(userId);


  response.sendRedirect("adminDashboard.jsp");
%>