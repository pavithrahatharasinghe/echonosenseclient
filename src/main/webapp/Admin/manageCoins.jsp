<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="adminHeader.jsp"/>
<body>
<div class="wrapper">
    <jsp:include page="adminSidebar.jsp"/> <!-- This will include the sidebar -->
    <div class="main-panel">
        <!-- Navbar -->
        <jsp:include page="adminNavbar.jsp"/>
        <!-- End Navbar -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <!-- Add Coin Section -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Add Coin</h4>
                            </div>
                            <div class="card-body">
                                <form id="addCoinForm">
                                    <div class="form-group">
                                        <label>Name</label>
                                        <input type="text" class="form-control" placeholder="Coin Name" name="coinName" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Symbol</label>
                                        <input type="text" class="form-control" placeholder="Coin Symbol" name="coinSymbol" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea class="form-control" placeholder="Coin Description" name="coinDescription" required></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>Image URL</label>
                                        <input type="text" class="form-control" placeholder="Coin Image URL" name="coinImageUrl" required>
                                    </div>
                                    <button id="addCoinBtn" type="submit" class="btn btn-primary">Add Coin</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Update Coin Section -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Update Coin</h4>
                            </div>
                            <div class="card-body">
                                <form id="updateCoinForm">
                                    <div class="form-group">
                                        <label>Coin ID</label>
                                        <input type="text" class="form-control" placeholder="Coin ID" name="updateCoinId" required readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Name</label>
                                        <input type="text" class="form-control" placeholder="Updated Coin Name" name="updateCoinName">
                                    </div>
                                    <div class="form-group">
                                        <label>Symbol</label>
                                        <input type="text" class="form-control" placeholder="Updated Coin Symbol" name="updateCoinSymbol">
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea class="form-control" placeholder="Updated Coin Description" name="updateCoinDescription"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>Image URL</label>
                                        <input type="text" class="form-control" placeholder="Updated Coin Image URL" name="updateCoinImageUrl">
                                    </div>
                                    <button id="updateCoinBtn" type="submit" class="btn btn-primary">Update Coin</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Coin Table View -->
                <div class="container-fluid">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">All Coins</h4>
                            </div>
                            <div class="card-body table-full-width table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Symbol</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                        <th>Image</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody id="coinTableBody">
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
<script>// Add Coin Script
document.getElementById("addCoinBtn").addEventListener("click", function(event) {
    event.preventDefault();

    const coinData = {
        name: document.querySelector('input[name="coinName"]').value,
        symbol: document.querySelector('input[name="coinSymbol"]').value,
        description: document.querySelector('textarea[name="coinDescription"]').value,
        imageUrl: document.querySelector('input[name="coinImageUrl"]').value,
        status: "Active"  // Default status for new coins
    };

    fetch('http://localhost:8080/echonosenserest_war_exploded/api/coins', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(coinData)
    })

        .then(response => {
            if (response.status === 201) { // 201 Created status code
                alert("Coin added successfully!");
                refreshCoinTable();
            } else if (response.status === 500) { // 500 Internal Server Error status code
                alert("Failed to add the coin. Internal server error.");
            } else {
                alert("An error occurred while adding the coin.");
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while adding the coin.');
        });

});

// Update Coin Script
document.getElementById("updateCoinBtn").addEventListener("click", function(event) {
    event.preventDefault();

    const coinData = {
        id: document.querySelector('input[name="updateCoinId"]').value,
        name: document.querySelector('input[name="updateCoinName"]').value,
        symbol: document.querySelector('input[name="updateCoinSymbol"]').value,
        description: document.querySelector('textarea[name="updateCoinDescription"]').value,
        imageUrl: document.querySelector('input[name="updateCoinImageUrl"]').value
    };

    fetch('http://localhost:8080/echonosenserest_war_exploded/api/coins/' + coinData.id, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(coinData)
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("Coin updated successfully!");
                refreshCoinTable();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while updating the coin.');
        });
});

// Display Coins in Table
function refreshCoinTable() {

    const url = 'http://localhost:8080/echonosenserest_war_exploded/api/coins';
    const options = {
        method: 'GET',


        headers: {
            'Content-Type': 'application/json'
        }
    };

    fetch(url,options)
        .then(response => response.json())
        .then(data => {
            let tableBody = document.getElementById("coinTableBody");
            tableBody.innerHTML = ''; // Clear existing rows

            data.forEach(coin => {
                let row = tableBody.insertRow();
                row.insertCell(0).textContent = coin.id;
                row.insertCell(1).textContent = coin.name;
                row.insertCell(2).textContent = coin.symbol;
                row.insertCell(3).textContent = coin.description;
                row.insertCell(4).textContent = coin.status;

                let imageUrlCell = row.insertCell(5);
                imageUrlCell.textContent = coin.imageUrl;
                imageUrlCell.classList.add("overflow-hidden");

                let actionCell = row.insertCell(6);
                let toggleButton = document.createElement("button");
                toggleButton.textContent = coin.status === "Active" ? "Disable" : "Enable";
                toggleButton.addEventListener("click", function() {
                    toggleCoinStatus(coin.id, coin.status);
                });
                actionCell.appendChild(toggleButton);
            });
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while fetching coins.');
        });
}

// Toggle Coin Status
function toggleCoinStatus(coinId, currentStatus) {
    let newStatus = currentStatus === "Active" ? "Inactive" : "Active";

    fetch('http://localhost:8080/echonosenserest_war_exploded/api/coins/' + coinId + '/status', {
        method: 'PUT',
        mode: 'no-cors',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ status: newStatus })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("Coin status updated successfully!");
                refreshCoinTable();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while updating coin status.');
        });
}

refreshCoinTable();

</script>
</body>
<jsp:include page="adminFooter.jsp"/>
