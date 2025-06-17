<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center align-items-center bg-white p-4 rounded shadow">
        <div class="col-lg-6 d-none d-lg-block">
            <img src="${pageContext.request.contextPath}/assets/image/personal-information-form-identity-concept.jpg"
                 alt="signin" class="img-fluid rounded-start">
        </div>
        <div class="col-lg-6 col-md-8 col-sm-12">
            <h2 class="text-center mb-4">Sign In</h2>
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
                    <a href="${pageContext.request.contextPath}/pages/signup.jsp">Sign Up</a>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
