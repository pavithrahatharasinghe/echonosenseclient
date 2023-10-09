<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 10/9/2023
  Time: 6:51 PM
  To change this template use File | Settings | File Templates.
--%>

<%
    // Get the current URI
    String requestURI = request.getRequestURI();

    // Extract the page name or relevant information from the URI
    String currentPage = "";

    // Extract the page name from the URI
    if (requestURI != null && requestURI.length() > 0) {
        int lastIndex = requestURI.lastIndexOf("/");
        if (lastIndex != -1 && lastIndex < requestURI.length() - 1) {
            currentPage = requestURI.substring(lastIndex + 1);
        }
    }
%>

<div class="sidebar">
    <div class="sidebar-wrapper">
        <div class="logo">
            <img style="height: 60px; width: auto" src="../webimages/bumblelogo.png"/>
        </div>
        <ul class="nav">
            <li class="nav-item <%= currentPage.equals("customerDashboard.jsp") ? "active" : "" %>">
                <a class="nav-link" href="customerDashboard.jsp.jsp">
                    <i class="nc-icon nc-chart-pie-35"></i>
                    <p>Dashboard</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("customerProfile.jsp") ? "active" : "" %>">
                <a class="nav-link" href="customerProfile.jsp">
                    <i class="nc-icon nc-single-02"></i>
                    <p>My Profile</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("customersubscriptions.jsp") ? "active" : "" %>">
                <a class="nav-link" href="customersubscriptions.jsp">
                    <i class="nc-icon nc-notes"></i>
                    <p>My Subscriptions</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("newsAndInsights.jsp") ? "active" : "" %>">
                <a class="nav-link" href="newsAndInsights.jsp">
                    <i class="nc-icon nc-single-copy-04"></i>
                    <p>News & Insights</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("coinPredictions.jsp") ? "active" : "" %>">
                <a class="nav-link" href="coinPredictions.jsp">
                    <i class="nc-icon nc-lightbulb-24"></i>
                    <p>Coin Predictions</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("notifications.jsp") ? "active" : "" %>">
                <a class="nav-link" href="notifications.jsp">
                    <i class="nc-icon nc-bell-55"></i>
                    <p>Notifications</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("supportAndFeedback.jsp") ? "active" : "" %>">
                <a class="nav-link" href="supportAndFeedback.jsp">
                    <i class="nc-icon nc-chat-33"></i>
                    <p>Support & Feedback</p>
                </a>
            </li>
            <li class="nav-item active active-pro">
                <a class="nav-link active" href="../logout.jsp">
                    <i class="nc-icon nc-alien-33"></i>
                    <p>Logout</p>
                </a>
            </li>
        </ul>
    </div>
</div>
