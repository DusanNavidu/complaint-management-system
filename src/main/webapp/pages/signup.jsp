<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SignUp page</title>
    <link rel="stylesheet" href="css/signup.css">
</head>
<body>
<main>
    <section class="container">
        <img src="assets/image/personal-information-form-identity-concept.jpg" alt="signup image" class="signup-image">
        <form>
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" placeholder="Enter your full name" required>
            <label for="birthday">Birthday</label>
            <input type="date" id="birthday" name="birthday" placeholder="Enter your birthday" required>
            <label for="nic_number">Email</label>
            <input type="text" id="nic_number" name="nic_number" placeholder="Enter your nic number" required>
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your username" required>
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
            <label for="confirm_password">Confirm Password</label>
            <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm your password" required>
            <label for="role">Role:</label>
            <select name="role" id="role" required>
                <option value="EMPLOYEE">EMPLOYEE</option>
                <option value="ADMIN">ADMIN</option>
            </select>
            <div>
                <button type="submit" class="signup-button">Sign Up</button>
                <div>
                    <label for="signin">Do you have already existed account?</label>
                    <a href="signin.jsp" id="signin">Sign In</a>
                </div>
            </div>
        </form>
    </section>
</main>
</body>
</html>
