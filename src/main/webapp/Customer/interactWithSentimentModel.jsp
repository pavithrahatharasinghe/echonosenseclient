<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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


    Properties properties = new Properties();
    try {
        // Load the configuration file
        String configFilePath = application.getRealPath("/WEB-INF/config.properties");
        properties.load(new FileInputStream(configFilePath));
    } catch (Exception e) {
        e.printStackTrace();
    }
    String host = properties.getProperty("host.url");
    String sentimentModel = properties.getProperty("model.sentiment");
    String userId = ""; // Initialize userId
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = cookie.getValue();
                break;
            }
        }
    }
    // Fetch user details using userId from a server endpoint
    String userDetails = ""; // Initialize userDetails
    try {
        String userDetailsUrl = host + "users/" + userId; // Replace with your API endpoint
        java.net.URL url = new java.net.URL(userDetailsUrl);
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        if (conn.getResponseCode() == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
            String output;
            while ((output = br.readLine()) != null) {
                userDetails += output;
            }
        } else {
            userDetails = null;
        }
        conn.disconnect();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<jsp:include page="customerHeader.jsp"/>
<body>
<div class="wrapper">
    <jsp:include page="customerSidebar.jsp"/>
    <div class="main-panel">
        <!-- Navbar -->
        <jsp:include page="customerNavbar.jsp"/>
        <!-- End Navbar -->
        <div class="content">
            <div class="container-fluid">
                <!-- Sentiment Analysis Form -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h4 class="card-title">EchonoSense Sentiment Analyzer</h4>
                            </div>
                            <div class="card-body">
                                <form id="sentimentAnalysisForm">
                                    <div class="form-group">
                                        <label for="text">Enter Text</label>
                                        <textarea style="height: 500px" class="form-control" id="text" name="text"
                                                  rows="3" required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Analyze Sentiment</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sentiment Analysis Results -->
                <div class="row">
                    <div class="col-md-12" id="sentimentResults">
                        <!-- Results will be displayed here -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById('sentimentAnalysisForm').addEventListener('submit', function (event) {
        event.preventDefault();
        const text = document.getElementById('text').value;
        const sentimentUrl = "<%= sentimentModel %>";

        // Construct the payload
        const data = {
            text: text
        };

        // Print the payload to the console
        console.log("Payload to be sent:", JSON.stringify(data));

        fetch(sentimentUrl, {
            method: 'POST',

            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
            },
            body: JSON.stringify(data),
        })
            .then((response) => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then((data) => {
                const sentimentResults = document.getElementById('sentimentResults');
                let backgroundColor = '';
                if (data.sentiment_class === 'positive') {
                    backgroundColor = '#9ABB90';
                } else if (data.sentiment_class === 'negative') {
                    backgroundColor = '#BA6069';
                } else {
                    backgroundColor = '#20466A';
                }
                sentimentResults.innerHTML = '<h4>Sentiment Analysis Result</h4>' +
                    '<p><strong>Polarity:</strong> ' + data.polarity + '</p>' +
                    '<p><strong>Sentiment Class:</strong> ' + data.sentiment_class + '</p>';
                sentimentResults.style.backgroundColor = backgroundColor;
            })
            .catch((error) => {
                console.error('Error:', error);
                alert('An error occurred while analyzing sentiment.');
            });
    });
</script>


<jsp:include page="customerFooter.jsp"/>
</body>
