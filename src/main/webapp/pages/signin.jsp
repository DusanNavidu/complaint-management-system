<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign In Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signIn.css">
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
            border-top-left-radius: 20px;
            border-bottom-left-radius: 20px;
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
        #signin-lable{
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
        <img src="${pageContext.request.contextPath}/assets/image/personal-information-form-identity-concept.jpg" alt="signin image" class="signup-image">

        <form action="${pageContext.request.contextPath}/signin" method="post">
            <h1>Sign In</h1>

            <div class="information-box">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>

            <div class="information-box">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <div class="information-box">
                <button type="submit" class="sign-in-button">Sign In</button>

                <div class="information-box2">
                    <label id="signup-label" for="signup">Don't have an account?</label>
                    <a href="pages/signup.jsp" id="signup">Signup</a>
                </div>
            </div>

            <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
            <p style="color: red; text-align: center;">
                <% if ("invalid".equals(error)) { %>
                Invalid username or password.
                <% } else if ("role".equals(error)) { %>
                Unauthorized role.
                <% } else { %>
                Unknown error occurred.
                <% } %>
            </p>
            <% } %>
        </form>
    </section>
</main>
</body>
</html>
