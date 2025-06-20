<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Complaint Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="bg-light">
<main class="d-flex">
    <%
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/signin.jsp?error=session");
            return;
        }
    %>

    <!-- Sidebar -->
    <div class="border-end p-3 position-fixed top-0 left-0" style="min-width: 250px; height: 100vh; background-color: #153c61">
        <div class="mb-4 text-white">
            <%
                String role = user.getRole();
                String imagePath = "ADMIN".equalsIgnoreCase(role)
                        ? "/assets/image/images.png"
                        : "/assets/image/Employee Icon with Blue Accents.png";
            %>
            <img src="<%= request.getContextPath() + imagePath %>"
                 alt="<%= role %> image"
                 style="border-radius: 50%; width: 200px; height: 200px;">
            <p><i>Email:</i> <a style="color: white" href="mailto:<%= user.getEmail() %>"><%= user.getEmail() %></a></p>
            <h3 class="mt-3" style="font-size: 1.3rem">Welcome,</h3>
            <h3 class="fw-bold"><%= user.getFull_name() %></h3>
        </div>
        <ul class="nav flex-column mt-5 gap-3">
            <li class="nav-item"><a class="nav-link text-white"
                                    href="${pageContext.request.contextPath}/pages/adminDashboardHome.jsp"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                    <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/house-black-silhouette-without-door.png">
                    Home
                </a>
            </li>
            <li class="nav-item"><a class="nav-link text-white"
                                    href="${pageContext.request.contextPath}/pages/adminDashboardComplaint.jsp"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                    <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/complain.png">
                    Complaint
                </a>
            </li>
            <li class="nav-item"><a class="nav-link text-white"
                                    href="${pageContext.request.contextPath}/pages/complaintTables.jsp"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                    <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/tablet.png">
                    Complaint View
                </a>
            </li>
            <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>
            <li class="nav-item"><a class="nav-link text-white"
                                    href="${pageContext.request.contextPath}/pages/userTable.jsp"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                    <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/user(2).png">
                    User details
                </a>
            </li>
            <% } %>
            <li class="nav-item"><a class="nav-link text-white"
                                    href="#"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                    <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/setting.png">
                    Settings
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-danger"
                   href="${pageContext.request.contextPath}/logout"
                   style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                    <img src="${pageContext.request.contextPath}/assets/icon/exit.png"
                         style="width: 20px; height: 20px;" alt="Logout">
                    Logout
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div id="main-content" class="p-4 w-100" style="margin-left: 250px; background-color: #e9eaf0;">
        <h2 class="mb-4">Complaint Dashboard</h2>

        <!-- Refresh Button -->
        <form action="${pageContext.request.contextPath}/dashboard/home" method="post">
            <button type="submit" class="btn btn-primary mb-4">Refresh Dashboard</button>
        </form>

        <!-- Dashboard Boxes -->
        <div class="d-flex flex-wrap justify-content-evenly px-3 gap-4">
            <div id="box1" class="bg-white shadow d-flex flex-column justify-content-center align-items-center"
                 style="width: 300px; height: 250px; border-radius: 15px;">
                <h4 class="text-warning">PENDING</h4>
                <h1><%= request.getAttribute("pendingCount") != null ? request.getAttribute("pendingCount") : 0 %></h1>
            </div>
            <div id="box2" class="bg-white shadow d-flex flex-column justify-content-center align-items-center"
                 style="width: 300px; height: 250px; border-radius: 15px;">
                <h4 class="text-primary">IN PROGRESS</h4>
                <h1><%= request.getAttribute("inProgressCount") != null ? request.getAttribute("inProgressCount") : 0 %></h1>
            </div>
            <div id="box3" class="bg-white shadow d-flex flex-column justify-content-center align-items-center"
                 style="width: 300px; height: 250px; border-radius: 15px;">
                <h4 class="text-success">RESOLVED</h4>
                <h1><%= request.getAttribute("resolvedCount") != null ? request.getAttribute("resolvedCount") : 0 %></h1>
            </div>
            <div id="box4" class="bg-white shadow d-flex flex-column justify-content-center align-items-center"
                 style="width: 300px; height: 250px; border-radius: 15px;">
                <h4 class="text-danger">REJECTED</h4>
                <h1><%= request.getAttribute("rejectedCount") != null ? request.getAttribute("rejectedCount") : 0 %></h1>
            </div>
        </div>
        <div class="mt-5 d-flex justify-content-center">
            <div class="bg-white shadow p-4 rounded" style="max-width: 500px; width: 100%;">
                <h5 class="text-center mb-4">Complaint Status Distribution</h5>
                <canvas id="complaintPieChart" style="width: 100%; height: 400px;"></canvas>
            </div>
        </div>
    </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('complaintPieChart').getContext('2d');

    const data = {
        labels: ['PENDING', 'IN_PROGRESS', 'RESOLVED', 'REJECTED'],
        datasets: [{
            label: 'Complaint Status Distribution',
            data: [
                <%= request.getAttribute("pendingCount") != null ? request.getAttribute("pendingCount") : 0 %>,
                <%= request.getAttribute("inProgressCount") != null ? request.getAttribute("inProgressCount") : 0 %>,
                <%= request.getAttribute("resolvedCount") != null ? request.getAttribute("resolvedCount") : 0 %>,
                <%= request.getAttribute("rejectedCount") != null ? request.getAttribute("rejectedCount") : 0 %>
            ],
            backgroundColor: ['#f0ad4e', '#0275d8', '#5cb85c', '#d9534f'],
            hoverOffset: 10
        }]
    };

    new Chart(ctx, {
        type: 'pie',
        data: data,
        options: {
            responsive: true,
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let total = context.dataset.data.reduce((a, b) => a + b, 0);
                            let value = context.raw;
                            let percentage = total ? ((value / total) * 100).toFixed(1) : 0;
                            return `${context.label}: ${value} (${percentage}%)`;
                        }
                    }
                }
            }
        }
    });
</script>
</body>
</html>
