<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
        }

        .side-nav-bar {
            display: flex;
            flex-direction: column;
            width: 20vw;
            background-color: #f0f0f0;
            padding: 20px;
            height: 100vh;
        }

        .home-interface {
            width: 80vw;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        ul li {
            margin: 10px 0;
        }

        ul li a {
            text-decoration: none;
            color: black;
            font-weight: bold;
        }

        .user-info {
            margin-bottom: 20px;
        }

        h1 {
            font-size: 1.2rem;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<main>
    <%
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/signin.jsp?error=session");
            return;
        }
    %>

    <section style="display: flex;">
        <div class="side-nav-bar">
            <div class="user-info">
                <%-- Username --%>
                <p><strong>Username:</strong> <%= user.getUsername() %></p>

                <%-- Email --%>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>

                <%-- Full Name --%>
                <h1>Welcome, <%= user.getFull_name() %></h1>
            </div>

            <ul>
                <li><a href="#">Home</a></li>
                <li><a href="#">Complaint</a></li>
                <li><a href="#">Setting</a></li>
                <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>
        </div>

        <div class="home-interface">
            <!-- Dashboard content goes here -->
            <h1>📋 CMS</h1>
        </div>
    </section>
</main>
</body>
</html>
