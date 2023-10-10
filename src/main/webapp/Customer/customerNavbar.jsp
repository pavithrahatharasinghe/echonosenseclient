<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%--
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
<nav class="navbar navbar-expand-lg " color-on-scroll="500">
  <div class="container-fluid">
    <a class="navbar-brand" href="#pablo">
      <%
        // Define a map of page names and their corresponding display names
        Map<String, String> pageDisplayNames = new HashMap<>();
        pageDisplayNames.put("customerDashboard.jsp", "Dashboard");
        pageDisplayNames.put("customerProfile.jsp", "My Profile");
        pageDisplayNames.put("customersubscriptions.jsp", "My Subscriptions");
        pageDisplayNames.put("newsAndInsights.jsp", "News & Insights");
        pageDisplayNames.put("coinPredictions.jsp", "Coin Predictions");
        pageDisplayNames.put("notifications.jsp", "Notifications");
        pageDisplayNames.put("supportAndFeedback.jsp", "Support & Feedback");

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

        // Get the display name for the current page
        String displayName = pageDisplayNames.get(currentPage);

        // If the display name is null, default to "Dashboard"
        if (displayName == null) {
          displayName = "Dashboard";
        }

        // Output the display name
        out.print(displayName);
      %>
    </a>
    <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
            aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-bar burger-lines"></span>
      <span class="navbar-toggler-bar burger-lines"></span>
      <span class="navbar-toggler-bar burger-lines"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navigation">
      <ul class="nav navbar-nav mr-auto">
        <li class="nav-item">
          <a href="#" class="nav-link" data-toggle="dropdown">
            <i class="nc-icon nc-palette"></i>
            <span class="d-lg-none">Dashboard</span>
          </a>
        </li>
        <li class="dropdown nav-item">
          <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
            <i class="nc-icon nc-planet"></i>
            <span class="notification">5</span>
            <span class="d-lg-none">Notification</span>
          </a>
          <ul class="dropdown-menu">
            <a class="dropdown-item" href="#">Notification 1</a>
            <a class="dropdown-item" href="#">Notification 2</a>
            <a class="dropdown-item" href="#">Notification 3</a>
            <a class="dropdown-item" href="#">Notification 4</a>
            <a class="dropdown-item" href="#">Another notification</a>
          </ul>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">
            <i class="nc-icon nc-zoom-split"></i>
            <span class="d-lg-block">&nbsp;Search</span>
          </a>
        </li>
      </ul>
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <a class="nav-link" href="#pablo">
            <span class="no-icon">Account</span>
          </a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink"
             data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <span class="no-icon">Dropdown</span>
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <a class="dropdown-item" href="#">Something</a>
            <a class="dropdown-item" href="#">Something else here</a>
            <div class="divider"></div>
            <a class="dropdown-item" href="#">Separated link</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#pablo">
            <span class="no-icon">Log out</span>
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>