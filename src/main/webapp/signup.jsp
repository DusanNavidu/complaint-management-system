<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SignUp page</title>
    <style>
        form {
            margin-top: 20px;
        }

        input, select {
            margin-bottom: 10px;
            padding: 8px;
            width: 250px;
        }

        label {
            display: block;
            margin-top: 10px;
        }

        .container {
            max-width: 400px;
            margin: auto;
        }

        .success {
            color: green;
        }
    </style>
</head>
<body>
<main>
    <section class="container">
        <img src="assets/image/personal-information-form-identity-concept.jpg" alt="Logo" style="width: 100px; height: 100px;">
        <div>
            <h1>Signup Page</h1>
        </div>

        <!-- SIGNUP FORM -->
        <form action="<%= request.getContextPath() %>/signup" method="post">
            <%--@declare id="role"--%><label for="username">Username:</label>
            <input type="text" name="username" id="username" required>

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required>

            <label for="full_name">Full Name:</label>
            <input type="text" name="full_name" id="full_name" required>

            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required>

            <label for="role">Role:</label>
            <select name="role" required>
                <option value="EMPLOYEE">EMPLOYEE</option>
                <option value="ADMIN">ADMIN</option>
            </select>

            <!-- hidden field for is_active -->
            <input type="hidden" name="is_active" value="true">

            <br>
            <input type="submit" value="Sign Up">
        </form>

        <!-- Optional success message -->
        <%
            String message = request.getParameter("message");
            if (message != null) {
        %>
        <p class="success"><%= message %></p>
        <%
            }
        %>
    </section>
</main>
</body>
</html>
