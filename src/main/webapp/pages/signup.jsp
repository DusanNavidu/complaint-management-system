<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign Up</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
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
                transform: translateX(100%);
            }
        }

        .full-height {
            height: 100vh;
        }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid full-height">
    <div id="sign-up-container" class="row full-height">
        <!-- Left Side - Sign Up Form -->
        <div class="col-lg-6 d-flex align-items-center justify-content-center bg-white p-4">
            <div class="w-100" style="max-width: 500px;">
                <h2 class="text-center mb-4">Sign Up</h2>
                <form action="${pageContext.request.contextPath}/signup" method="post">
                    <div class="mb-3">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" id="name" name="name" class="form-control"
                               value="${not empty oldName ? oldName : ''}" required>
                        <small class="text-danger">${nameError}</small>
                    </div>

                    <div class="mb-3">
                        <label for="birthday" class="form-label">Birthday</label>
                        <input type="date" id="birthday" name="birthday" class="form-control" required>
                        <small class="text-danger">${birthdayError}</small>
                    </div>

                    <div class="mb-3">
                        <label for="nic_number" class="form-label">NIC Number</label>
                        <input type="text" id="nic_number" name="nic_number" class="form-control"
                               value="${not empty oldNICNumber ? oldNICNumber : ''}" required>
                        <small class="text-danger">${nicNumberError}</small>
                    </div>

                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" id="username" name="username" class="form-control"
                               value="${not empty oldUsername ? oldUsername : ''}" required>
                        <small class="text-danger">${usernameError}</small>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" class="form-control"
                               value="${not empty oldEmail ? oldEmail : ''}" required>
                        <small class="text-danger">${emailError}</small>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" class="form-control" required>
                        <small class="text-danger">${passwordError}</small>
                    </div>

                    <div class="mb-3">
                        <label for="confirm_password" class="form-label">Confirm Password</label>
                        <input type="password" id="confirm_password" name="confirm_password" class="form-control" required>
                        <small class="text-danger">${confirmPasswordError}</small>
                    </div>

                    <div class="mb-3">
                        <label for="role" class="form-label">Role</label>
                        <select name="role" id="role" class="form-select" required>
                            <option value="EMPLOYEE">EMPLOYEE</option>
                            <option value="ADMIN">ADMIN</option>
                        </select>
                        <small class="text-danger">${roleError}</small>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary">Sign Up</button>
                    </div>

                    <div class="text-center">
                        <label>Already have an account?
                            <a href="#" id="go-to-signin">Sign In</a>
                        </label>
                    </div>
                </form>
            </div>
        </div>

        <!-- Right Side - Welcome Panel -->
        <div class="col-lg-6 d-none d-lg-flex bg-login-side">
            <div>
                <h1 class="mb-4">Welcome!</h1>
                <p>Create your account to access the Complaint Management System</p>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("go-to-signin").addEventListener("click", function (e) {
        e.preventDefault();
        const container = document.getElementById("sign-up-container");
        container.classList.add("slide-out");

        setTimeout(function () {
            window.location.href = "${pageContext.request.contextPath}/pages/signin.jsp";
        }, 700);
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
