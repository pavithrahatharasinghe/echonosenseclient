<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<jsp:include page="adminHeader.jsp"/>
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
    String newsEndpoint = properties.getProperty("newsEndpoint");
%>
<body>
<div class="wrapper">
    <jsp:include page="adminSidebar.jsp"/>
    <div class="main-panel">
        <jsp:include page="adminNavbar.jsp"/>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">All News</h4>
                            </div>

                            <div class="card-body table-full-width table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Content</th>
                                        <th>Polarity</th>
                                        <th>Impact</th>
                                        <th>Related Coin</th>
                                        <th>Date Released</th>
                                        <th>Source</th>
                                    </tr>
                                    </thead>

                                    <tbody id="customerTableBody">
                                    </tbody>
                                </table>
                                <div class="pagination-controls">
                                    <button onclick="previousPage()">Previous</button>
                                    <button onclick="nextPage()">Next</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ... (previous code) -->

                    <!-- ... (previous code) -->

                    <script>
                        let currentPage = 1; // Start on page 1
                        const itemsPerPage = 20; // Display 20 items per page

                        function refreshTable() {
                            const url = '<%=newsEndpoint%>';
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
                                    $('#customerTableBody').empty();

                                    // Calculate start and end indices for slicing the data array
                                    const startIndex = (currentPage - 1) * itemsPerPage;
                                    const endIndex = startIndex + itemsPerPage;

                                    const pageData = data.slice(startIndex, endIndex);

                                    $.each(pageData, function (index, news) {
                                        const row = '<tr>' +
                                            '<td>' + news.newsID + '</td>' +
                                            '<td>' + news.title + '</td>' +
                                            '<td>' + news.content + '</td>' +
                                            '<td>' + news.polarity + '</td>' +
                                            '<td>' + news.impact + '</td>' +
                                            '<td>' + news.relatedCoin + '</td>' +
                                            '<td>' + news.dateReleased + '</td>' +
                                            '<td>' + news.source + '</td>' +
                                            '</tr>';
                                        $('#customerTableBody').append(row);
                                    });
                                })
                                .catch(error => console.error(error));
                        }

                        function nextPage() {
                            currentPage++;
                            refreshTable();
                        }

                        function previousPage() {
                            if (currentPage > 1) {
                                currentPage--;
                                refreshTable();
                            }
                        }

                        refreshTable();

                    </script>

                    <!-- ... (remaining code) -->


                </div>

            </div>
        </div>


    </div>
</div>
</body>
</html>
