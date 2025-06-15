<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SignUp page</title>
    <link rel="stylesheet" href="css/signup.css">
    <style>
        body{
            margin: 0;
        }
        main{
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }
        .container{
            width: 80vw;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 2px solid black;
            border-radius: 20px;
        }
        .signup-image{
            width:40vw;
            object-fit: cover;
        }
        form{
            width: 40vw;
            padding: 50px;
        }
        .information-box{
            display: flex;
            flex-direction: column;
        }
        .information-box2{
            display: flex;
        }
        h1{
            text-align: center;
            font-family: "Times New Roman";
            font-weight: bold;
            font-size: 2.5rem;
        }
        input{
            height: 40px;
            border-radius: 5px;
        }
        select{
            height: 40px;
            border-radius: 5px;
        }
        button{
            height: 40px;
            border-radius: 5px;
        }
        #signup-lable{
            text-align: center;
        }
        p{
            color: red;
        }
    </style>
</head>
<body>
<main>
    <section class="container">
        <form action="${pageContext.request.contextPath}/signup" method="post" class="signup-form">
            <h1>Sign Up</h1>
            <div class="information-box">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name"
                       value="${not empty oldName ? oldName : ''}"
                ${not empty nameError ? 'class="invalid"' : ''}
                       placeholder="Enter your full name" required>
                <p class="error">${nameError}</p>

            </div>
            <div class="information-box">
                <label for="birthday">Birthday</label>
                <input type="date" id="birthday" name="birthday"
                       class="${not empty birthdayError ? 'invalid' : ''}"
                       placeholder="Enter your birthday" required>
                <p class="error">${birthdayError}</p>
            </div>
            <div class="information-box">
                <label for="nic_number">NIC Number</label>
                <input type="text" id="nic_number" name="nic_number"
                       value="${not empty oldNICNumber ? oldNICNumber : ''}"
                ${not empty nicNumberError ? 'class="invalid"' : ''}
                       placeholder="Enter your NIC number" required>
                <p class="error">${nicNumberError}</p>
            </div>
            <div class="information-box">
                <label for="username">Username</label>
                <input type="text" id="username" name="username"
                       value="${not empty oldUsername ? oldUsername : ''}"
                ${not empty usernameError ? 'class="invalid"' : ''}
                       placeholder="Enter your username" required>
                <p class="error">${usernameError}</p>
            </div>
            <div class="information-box">
                <label for="email">Email</label>
                <input type="email" id="email" name="email"
                       value="${not empty oldEmail ? oldEmail : ''}"
                ${not empty emailError ? 'class="invalid"' : ''}
                       placeholder="Enter your email" required>
                <p class="error">${emailError}</p>
            </div>
            <div class="information-box">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       class="${not empty passwordError ? 'invalid' : ''}"
                       placeholder="Enter your password & min length 6 characters" required>
                <p class="error">${passwordError}</p>
            </div>

            <div class="information-box">
                <label for="confirm_password">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password"
                       class="${not empty confirmPasswordError ? 'invalid' : ''}"
                       placeholder="Confirm your password" required>
                <p class="error">${confirmPasswordError}</p>
            </div>
            <div class="information-box">
                <label for="role">Role:</label>
                <select name="role" id="role" required>
                    <option value="EMPLOYEE">EMPLOYEE</option>
                    <option value="ADMIN">ADMIN</option>
                </select>
                <p class="error">${roleError}</p>
            </div>
            <div class="information-box">
                <button type="submit" class="signup-button">Sign Up</button>
                <div class="information-box2">
                    <label id="signin-lable" for="signin">Do you have already existed account?</label>
                    <a href="pages/signin.jsp" id="signin">Sign In</a>
                </div>
            </div>
        </form>
        <img src="assets/image/personal-information-form-identity-concept.jpg" alt="signup image" class="signup-image">
    </section>
</main>
<script src="js/signup.js"></script>
</body>
</html>
