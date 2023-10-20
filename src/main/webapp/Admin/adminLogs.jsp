<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<jsp:include page="adminHeader.jsp"/>
<div class="wrapper">
  <%@ include file="adminSidebar.jsp" %>
  <div class="main-panel">
    <jsp:include page="adminNavbar.jsp"/>
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title">All Admin Logs</h4>
              </div>
              <div class="card-body table-full-width table-responsive">
                <table class="table table-hover table-striped">
                  <thead>
                  <tr>
                    <th>ID</th>
                    <th>Admin User ID</th>
                    <th>Action</th>
                    <th>Description</th>
                    <th>Date</th>
                  </tr>
                  </thead>
                  <tbody id="adminLogTableBody">
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  <%
    Properties properties = new Properties();
    try {
        // Load the configuration file
        String configFilePath = application.getRealPath("/WEB-INF/config.properties");
        properties.load(new FileInputStream(configFilePath));
    } catch (Exception e) {
        e.printStackTrace();
    }
    String logsURL = properties.getProperty("admin.log.get");
%>
  refreshTable();

  function refreshTable() {
    const url = '<%= logsURL %>';
    const options = {
      method: 'GET',

      headers: {
        'Content-Type': 'application/json'
      }
    };

    fetch(url, options)
            .then(response => response.json())
            .then(data => {
              console.log(data);
              // Clear the table body
              $('#adminLogTableBody').empty();
              // Populate the table with the data
              $.each(data, function (index, adminLog) {
                const row = '<tr>' +
                        '<td>' + adminLog.logID + '</td>' +
                        '<td>' + adminLog.adminUserID + '</td>' +
                        '<td>' + adminLog.action + '</td>' +
                        '<td>' + adminLog.description + '</td>' +
                        '<td>' + new Date(adminLog.date).toLocaleString() + '</td>' +
                        '</tr>';
                $('#adminLogTableBody').append(row);
              });
            })
            .catch(error => console.error(error));
  }
</script>
<!-- Include Bootstrap JS and jQuery here if needed -->
</body>
</html>
