<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Complaint Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <div class="border-end p-3" style="min-width: 250px; height: 100vh; background-color: #153c61">
        <div class="mb-4 text-white">
            <img src="${pageContext.request.contextPath}/assets/image/images.png" alt="user image"
                 style="border-radius: 50%; width: 200px; height: 200px;">
            <p><i>Email:</i> <%= user.getEmail() %></p>
            <h3 class="mt-3" style="font-size: 1.3rem">Welcome,</h3>
            <h5><%= user.getFull_name() %></h5>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/pages/adminDashboardHome.jsp">Home</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/pages/adminDashboardComplaint.jsp">Complaint</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="#">Settings</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="p-4 w-100">
        <h2 class="mb-4">Complaint Dashboard</h2>

        <!-- Refresh Button -->
        <form action="${pageContext.request.contextPath}/dashboard/home" method="post">
        </form>

        <!-- Dashboard Boxes -->
        <div class="d-flex flex-wrap justify-content-evenly px-3 gap-4">
            <div class="bg-white shadow d-flex flex-column justify-content-center align-items-center"
                 style="width: 300px; height: 300px; border-radius: 15px;">
                <h4 class="text-warning">PENDING</h4>
                <h1><%= request.getAttribute("pendingCount") != null ? request.getAttribute("pendingCount") : 0 %></h1>
            </div>
            <div class="bg-white shadow d-flex flex-column justify-content-center align-items-center"
                 style="width: 300px; height: 300px; border-radius: 15px;">
                <h4 class="text-primary">IN PROGRESS</h4>
                <h1><%= request.getAttribute("inProgressCount") != null ? request.getAttribute("inProgressCount") : 0 %></h1>
            </div>
            <div class="bg-white shadow d-flex flex-column justify-content-center align-items-center"
                 style="width: 300px; height: 300px; border-radius: 15px;">
                <h4 class="text-success">RESOLVED</h4>
                <h1><%= request.getAttribute("resolvedCount") != null ? request.getAttribute("resolvedCount") : 0 %></h1>
            </div>
            <div class="bg-white shadow d-flex flex-column justify-content-center align-items-center"
                 style="width: 300px; height: 300px; border-radius: 15px;">
                <h4 class="text-danger">REJECTED</h4>
                <h1><%= request.getAttribute("rejectedCount") != null ? request.getAttribute("rejectedCount") : 0 %></h1>
            </div>
        </div>
    </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
