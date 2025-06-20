<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is already logged in
    lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO user =
            (lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO) session.getAttribute("user");

    if (user != null) {
        // If already logged in, redirect to dashboard
        response.sendRedirect(request.getContextPath() + "/pages/adminDashboardHome.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">

    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

        // Optional: force dashboard if back button used
        window.addEventListener("pageshow", function (event) {
            const userLoggedIn = <%= session.getAttribute("user") != null %>;
            if (userLoggedIn && event.persisted) {
                window.location.href = "<%= request.getContextPath() %>/pages/adminDashboardHome.jsp";
            }
        });
    </script>

    <style>
        .bg-login-side {
            background-color: #153c61;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            height: 100%;
            text-align: center;
            padding: 2rem;
        }

        .slide-out {
            animation: slideLeftFadeOut 0.7s forwards;
        }

        @keyframes slideLeftFadeOut {
            0% {
                opacity: 1;
                transform: translateX(0);
            }
            100% {
                opacity: 0;
                transform: translateX(-100%);
            }
        }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid">
    <div id="sign-in-container" class="row min-vh-100 justify-content-center align-items-center">
        <div class="col-lg-8 row- shadow-lg rounded overflow-hidden bg-white">
            <div class="row">
                <!-- Left Side -->
                <div class="col-lg-6 d-none d-lg-block p-0">
                    <div class="bg-login-side">
                        <h1 class="mb-4">Welcome Back!</h1>
                        <p>Sign in to access the Complaint Management System</p>
                    </div>
                </div>

                <!-- Right Side -->
                <div class="col-lg-6 col-12 p-5">
                    <h3 class="mb-4">Sign In</h3>
                    <form action="${pageContext.request.contextPath}/signin" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="Enter your username" required>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Enter your password" required>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary">Sign In</button>
                        </div>

                        <div class="text-center">
                            <span>Don't have an account?</span>
                            <a href="#" id="go-to-signup">Sign Up</a>
                        </div>

                        <% String error = request.getParameter("error"); %>
                        <% if (error != null) { %>
                        <div class="alert alert-danger mt-3 text-center">
                            <% if ("invalid".equals(error)) { %>Invalid username or password.
                            <% } else if ("role".equals(error)) { %>Unauthorized role.
                            <% } else { %>Unknown error occurred.<% } %>
                        </div>
                        <% } %>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("go-to-signup").addEventListener("click", function (e) {
        e.preventDefault();
        const container = document.getElementById("sign-in-container");
        container.classList.add("slide-out");
        setTimeout(function () {
            window.location.href = "${pageContext.request.contextPath}/pages/signup.jsp";
        }, 700);
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
