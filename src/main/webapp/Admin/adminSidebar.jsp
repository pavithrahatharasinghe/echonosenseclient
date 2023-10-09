<%
    // Get the current URI
    String requestURI = request.getRequestURI();

// Extract the page name or relevant information from the URI
    String currentPage = "";

// Example: Extract the page name from the URI
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
            <li class="nav-item <%= currentPage.equals("adminDashboard.jsp") ? "active" : "" %>">
                <a class="nav-link" href="adminDashboard.jsp">
                    <i class="nc-icon nc-chart-pie-35"></i>
                    <p>Dashboard</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("manageUsers.jsp") ? "active" : "" %>">
                <a class="nav-link" href="manageUsers.jsp">
                    <i class="nc-icon nc-circle-09"></i>
                    <p>User Management</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("manageSubscriptions.jsp") ? "active" : "" %>">
                <a class="nav-link" href="manageSubscriptions.jsp">
                    <i class="nc-icon nc-notes"></i>
                    <p>Subscriptions </p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("manageCoins.jsp") ? "active" : "" %>">
                <a class="nav-link" href="manageCoins.jsp">
                    <i class="nc-icon nc-planet"></i>
                    <p>Coin Management</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("manageNews.jsp") ? "active" : "" %>">
                <a class="nav-link" href="manageNews.jsp">
                    <i class="nc-icon nc-single-copy-04"></i>
                    <p>News Management</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("managePayments.jsp") ? "active" : "" %>">
                <a class="nav-link" href="managePayments.jsp">
                    <i class="nc-icon nc-money-coins"></i>
                    <p>Payment Overview</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("manageNotifications.jsp") ? "active" : "" %>">
                <a class="nav-link" href="manageNotifications.jsp">
                    <i class="nc-icon nc-bell-55"></i>
                    <p>Notifications</p>
                </a>
            </li>
            <li class="nav-item <%= currentPage.equals("adminLogs.jsp") ? "active" : "" %>">
                <a class="nav-link" href="adminLogs.jsp">
                    <i class="nc-icon nc-single-copy-04"></i>
                    <p>Admin Logs</p>
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
