<%-- Include the common header --%>
<%@ include file="header.jsp" %>


<main class="main">
    <!--==================== DASHBOARD ====================-->
    <section class="home" id="home">
        <img src="assets/img/finance-bg.jpg" alt="Financial Dashboard" class="home__img">

        <div class="home__container container grid">
            <div class="home__data">
                <span class="home__data-subtitle">Latest Market Trends</span>
                <h1 class="home__data-title">Stay Ahead with <b>Real-Time <br> Financial Insights</b></h1>
                <a href="login.jsp" class="button">View Reports</a>
            </div>

            <div class="home__social">
                <a href="https://www.linkedin.com/" target="_blank" class="home__social-link">
                    <i class="ri-linkedin-box-fill"></i>
                </a>
                <a href="https://www.twitter.com/" target="_blank" class="home__social-link">
                    <i class="ri-twitter-fill"></i>
                </a>
            </div>

            <div class="home__info">
                <div>
                    <span class="home__info-title">Featured Analysis</span>
                    <a href="" class="button button--flex button--link home__info-button">
                        More <i class="ri-arrow-right-line"></i>
                    </a>
                </div>

                <div class="home__info-overlay">
                    <img src="assets/img/finance-report.png" alt="Financial Report" class="home__info-img">
                </div>
            </div>
        </div>
    </section>

    <!--==================== MARKET OVERVIEW ====================-->
    <section class="about section" id="about">
        <div class="about__container container grid">
            <div class="about__data">
                <h2 class="section__title about__title">Market Overview</h2>
                <p class="about__description">Get a comprehensive view of the global financial markets, including key indices, currencies, commodities, and stocks.</p>
                <a href="#" class="button">Detailed Analysis</a>
            </div>

            <div class="about__img">
                <div class="about__img-overlay">
                    <img src="assets/img/market1.jpg" alt="" class="about__img-one">
                </div>

                <div class="about__img-overlay">
                    <img src="assets/img/market2.avif" alt="" class="about__img-two">
                </div>
            </div>
        </div>
    </section>

    <!--==================== STOCK ANALYSIS ====================-->
    <section class="discover section" id="discover">
        <h2 class="section__title">Stock Analysis</h2>

        <div class="discover__container container swiper-container">
            <div class="swiper-wrapper">
                <!--==================== STOCK 1: Apple Inc. ====================-->
                <div class="discover__card swiper-slide">
                    <img src="assets/img/bitcoin-coin.png" alt="Bitcoin coin" class="discover__img">
                    <div class="discover__data">
                        <h2 class="discover__title">Bitcoin . (BTC)</h2>
                        <span class="discover__description">$145.96 (+1.42%)</span>
                    </div>
                </div>

                <!--==================== STOCK 2: Microsoft Corp. ====================-->
                <div class="discover__card swiper-slide">
                    <img src="assets/img/monero-coin.png" alt="Monero Coin" class="discover__img">
                    <div class="discover__data">
                        <h2 class="discover__title">Monero . (XMR)</h2>
                        <span class="discover__description">$282.51 (+2.33%)</span>
                    </div>
                </div>

                <!--==================== STOCK 3: Amazon Inc. ====================-->
                <div class="discover__card swiper-slide">
                    <img src="assets/img/stellar.jpg" alt="Stellar Coin" class="discover__img">
                    <div class="discover__data">
                        <h2 class="discover__title">Stellar . (XML)</h2>
                        <span class="discover__description">$3,461.62 (-0.56%)</span>
                    </div>
                </div>

                <!--==================== STOCK 4: Tesla Inc. ====================-->
                <div class="discover__card swiper-slide">
                    <img src="assets/img/Ethereum-coin.png" alt="Ethereum Coin" class="discover__img">
                    <div class="discover__data">
                        <h2 class="discover__title">Ethereum . (ETH)</h2>
                        <span class="discover__description">$687.20 (+4.69%)</span>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!--==================== FORECASTS ====================-->
    <section class="experience section" id="place">
        <h2 class="section__title">Forecasts & Projections</h2>

        <div class="experience__container container grid">
            <div class="experience__content grid">
                <!-- Add content related to market forecasts, projections, etc. -->
            </div>

            <div class="experience__img grid">
                <div class="experience__overlay">
                    <img src="assets/img/chart1.jpg" alt="" class="experience__img-one">
                </div>

                <div class="experience__overlay">
                    <img src="assets/img/chart2.jpg" alt="" class="experience__img-two">
                </div>
            </div>


        </div>
    </section>

    <!--==================== SPONSORS (Rename to PARTNERS or AFFILIATES) ====================-->
    <section class="sponsor section">
        <div class="sponsor__container container grid">
            <!-- Update these to reflect financial partners or affiliates -->
        </div>
    </section>
</main>
<!--==================== SUBSCRIBE ====================-->
<section class="subscribe section">
    <div class="subscribe__bg">
        <div class="subscribe__container container">
            <h2 class="section__title subscribe__title">Subscribe To <br> Get in Touch</h2>


            <form action="" class="subscribe__form">


                <button class="button">
                    Subscribe
                </button>
            </form>
        </div>
    </div>
</section>


<%-- Include the common footer --%>
<%@ include file="footer.jsp" %>
