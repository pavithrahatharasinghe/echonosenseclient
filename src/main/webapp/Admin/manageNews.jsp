<jsp:include page="adminHeader.jsp"/>
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
                            </div>
                        </div>
                    </div>

                    <!-- ... (previous code) -->

                    <!-- ... (previous code) -->

                    <script>
                        function refreshTable() {
                            const url = 'http://localhost:8080/your_news_endpoint'; // Replace with your actual news endpoint
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
                                    $('#customerTableBody').empty();
                                    // Populate the table with the data
                                    $.each(data, function (index, news) {
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

                    </script>

                    <!-- ... (remaining code) -->


                </div>

            </div>
        </div>


    </div>
</div>
</body>
</html>
