<%--
  Created by IntelliJ IDEA.
  User: PavithraH
  Date: 10/9/2023
  Time: 7:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>News & Insights</title>
    <style>
        /* Variables */
        :root {
            --primary: #ffb535;
            --text-color: #363738;
        }

        .news-card {
            background-color: #f8f8f8;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .news-card h5 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .news-card p {
            margin-bottom: 10px;
        }

        .news-card a {
            color: var(--text-color);
            transition: 200ms ease-in-out;
        }

        .news-card a:hover {
            color: var(--primary);
            text-decoration: none;
        }

        .news-card__image {
            width: 100%;
            height: 200px;
            background-size: cover;
            background-position: center;
            margin-bottom: 15px;
        }

        .date__box {
            position: absolute;
            top: 10px;
            left: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #fff;
            background-color: var(--primary);
            border: none;
            font-weight: bold;
            padding: 5px 10px;
        }

        .date__box .date__day {
            font-size: 22px;
        }

        .btn {
            background: white;
            color: var(--text-color);
            font-weight: bold;
            outline: none;
            box-shadow: 1px 1px 3px 0 rgba(0, 0, 0, 0.2);
            overflow: hidden;
            border-radius: 0;
            height: 50px;
            line-height: 50px;
            display: inline-block;
            padding: 0 15px;
            border: none;
        }

        .btn:focus {
            box-shadow: none;
        }

        .btn:hover {
            background: var(--primary);
            color: #fff;
        }

        .impact-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 5px;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .impact-good {
            background-color: green;
            color: white;
        }

        .impact-bad {
            background-color: red;
            color: white;
        }

        .impact-neutral {
            background-color: gray;
            color: white;
        }

    </style>

</head>
<body>

<jsp:include page="customerHeader.jsp" />

<div class="wrapper">
    <jsp:include page="customerSidebar.jsp" />
    <div class="main-panel">
        <!-- Navbar -->
        <jsp:include page="customerNavbar.jsp"/>
        <!-- End Navbar -->
        <div class="content">
            <div class="container-fluid">
                <!-- News & Insights -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h4 class="card-title">News & Insights</h4>
                            </div>
                            <div class="card-body">
                                <!-- Filters -->
                                <div class="filters mb-3">
                                    <label for="coinSelection">Filter by Coin:</label>
                                    <select id="coinSelection" class="form-control d-inline-block" style="width: auto;">
                                        <option value="all">All Coins</option>
                                        <!-- Options for coins will be populated here -->
                                    </select>

                                    <script>
                                        function populateCoinSelection() {
                                            // Replace 'coinEndpoint' with your actual API endpoint for coin names
                                            const coinEndpoint = 'http://localhost:8080/echonosenserest_war_exploded/api/coins';

                                            fetch(coinEndpoint)
                                                .then(response => response.json())
                                                .then(data => {
                                                    const coinSelection = document.getElementById('coinSelection');

                                                    // Clear existing options
                                                    coinSelection.innerHTML = '';

                                                    // Add an "All Coins" option
                                                    const allCoinsOption = document.createElement('option');
                                                    allCoinsOption.value = 'all';
                                                    allCoinsOption.textContent = 'All Coins';
                                                    coinSelection.appendChild(allCoinsOption);

                                                    // Add options for each coin name
                                                    data.forEach(coin => {
                                                        const option = document.createElement('option');
                                                        option.value = coin.id;  // Use the coin's ID or appropriate identifier
                                                        option.textContent = coin.name;
                                                        coinSelection.appendChild(option);
                                                    });
                                                })
                                                .catch(error => console.error('Error fetching coin names: ', error));
                                        }

                                        // Attach the function to populate the dropdown to the window's load event
                                        window.addEventListener('load', populateCoinSelection);
                                    </script>


                                    <label for="impactSelection" class="ml-3">Sort by Impact:</label>
                                    <select id="impactSelection" class="form-control d-inline-block" style="width: auto;">
                                        <option value="all">All</option>
                                        <option value="positive">Positive</option>
                                        <option value="neutral">Neutral</option>
                                        <option value="negative">Negative</option>
                                    </select>

                                    <!-- Search Button -->
                                    <button id="searchButton" class="btn btn-primary ml-3">Search</button>
                                </div>

                                <!-- News Cards -->
                                <div id="newsCards">
                                    <!-- News cards will be populated here -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('searchButton').addEventListener('click', function() {
        const coinDropdown = document.getElementById('coinSelection');
        const impactDropdown = document.getElementById('impactSelection');

        const coin = coinDropdown.options[coinDropdown.selectedIndex].value;
        const impact = impactDropdown.options[impactDropdown.selectedIndex].value;

// Concatenate coin and impact into a single string
        const message = "Coin: " + coin + "\nImpact: " + impact;

// Display the message in an alert


// Construct the URL based on the selected filters
        var url = "http://localhost:8080/echonosenserest_war_exploded/api/news/coin/" + "LTC" + "/impact/" + "Positive";


        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                // Clear existing cards
                $('#newsCards').empty();

                // Iterate over the fetched data
                $.each(data, function(index, newsItem) {
                    // Determine the impact badge color
                    let impactBadge = '';
                    if (newsItem.impact === 'positive') {
                        impactBadge = '<span class="impact-badge impact-good">Positive</span>';
                    } else if (newsItem.impact === 'negative') {
                        impactBadge = '<span class="impact-badge impact-bad">Negative</span>';
                    } else {
                        impactBadge = '<span class="impact-badge impact-neutral">Neutral</span>';
                    }

                    const cardContent = `
        <article class="news-card">
            <div class="news-card__image" id="newsImage"></div>

            <div class="news-card__info">
                <h5>` + newsItem.title + `</h5>
                <p>` + newsItem.content + `</p>
                ` + impactBadge + `
                <a href="` + newsItem.source + `" class="btn">Read More</a>
            </div>
            <div class="date__box">
                <span class="date__day">` + new Date(newsItem.dateReleased).getDate() + `</span>
                <span class="date__month">` + new Date(newsItem.dateReleased).toLocaleString('default', { month: 'short' }) + `</span>
            </div>
        </article>
    `;

                    // Append the card to the container
                    $('#newsCards').append(cardContent);
                });

            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error fetching news:', errorThrown);
            }
        });



    });
</script>

<jsp:include page="customerFooter.jsp" />

</body>
</html>
