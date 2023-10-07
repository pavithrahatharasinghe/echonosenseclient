<%-- Include the common header --%>
<%@ include file="header.jsp" %>

<div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">Login</h4>
            </div>
            <div class="card-body">
                <form class="login-form">
                    <div class="form-group">
                        <label for="usernameInput">Username</label>
                        <input type="text" class="form-control" id="usernameInput" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="passwordInput">Password</label>
                        <input type="password" class="form-control" id="passwordInput" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Login</button>
                </form>
            </div>
        </div>
    </div>
    <script>
        // ... Your JavaScript code ...
    </script>
    <div class="col-md-4"></div>
</div>

<%-- Include the common footer --%>
<%@ include file="footer.jsp" %>
