<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="customerHeader.jsp" />
<body>
<div class="wrapper">
  <jsp:include page="customerSidebar.jsp" />
  <div class="main-panel">
    <!-- Navbar -->
    <jsp:include page="customerNavbar.jsp" />
    <!-- End Navbar -->
    <div class="content">
      <div class="container-fluid">
        <!-- Sentiment Analysis Form -->
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header bg-primary text-white">
                <h4 class="card-title">Sentiment Analysis</h4>
              </div>
              <div class="card-body">
                <form id="sentimentAnalysisForm">
                  <div class="form-group">
                    <label for="text">Enter Text</label>
                    <textarea class="form-control" id="text" name="text" rows="3" required></textarea>
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

    // Construct the URL for sentiment analysis
    const url = 'http://127.0.0.1:5000/predict_sentiment';
    const data = { text };

    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    })
            .then((response) => response.json())
            .then((data) => {
              const sentimentResults = document.getElementById('sentimentResults');
              let backgroundColor = '';
              if (data.sentiment_class === 'positive') {
                backgroundColor = 'green';
              } else if (data.sentiment_class === 'negative') {
                backgroundColor = 'red';
              } else {
                backgroundColor = 'gray';
              }

              sentimentResults.innerHTML = `<h4>Sentiment Analysis Result</h4>
                <p><strong>Polarity:</strong> ${data.polarity}</p>
                <p><strong>Sentiment Class:</strong> ${data.sentiment_class}</p>`;

              sentimentResults.style.backgroundColor = backgroundColor;
            })
            .catch((error) => {
              console.error('Error:', error);
              alert('An error occurred while analyzing sentiment.');
            });
  });
</script>

<jsp:include page="customerFooter.jsp" />
</body>
