<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 6/15/2025
  Time: 8:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
        .information-box{
            display: flex;
            flex-direction: column;
        }
        .information-box-container{
            display: flex;
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
            <h1>COMPLAINT MANAGEMENT SYSTEM</h1>
            <h3>Dashboard complaint</h3>
            <form action="${pageContext.request.contextPath}/admindashbordsave" method="post" class="complaint-form">
                <div class="information-box-container">
                    <div>
                        <div class="information-box">
                            <label for="subject">subject</label>
                            <input type="text" id="subject" name="subject" class="${not empty subjectError ? 'invalid' : ''}"
                                   placeholder="Enter subject" required>
                            <p class="error">${subjectError}</p>
                        </div>
                        <div class="information-box">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" class="${not empty descriptionError ? 'invalid' : ''}"
                                      placeholder="Enter description" required></textarea>
                            <p class="error">${descriptionError}</p>
                        </div>
                    </div>
                    <div>
                        <div class="information-box">
                            <label for="category">Complaint Category:</label>
                            <select name="category" id="category" required>
                                <option value="">-- Select Category --</option>
                                <option value="ROADS">Road Maintenance</option>
                                <option value="WASTE">Waste Management</option>
                                <option value="DRAINAGE">Drainage and Sewage</option>
                                <option value="WATER">Water Supply Issues</option>
                                <option value="ELECTRIC">Street Lighting / Electricity</option>
                                <option value="BUILDING">Unauthorized Constructions</option>
                                <option value="PARKS">Public Parks & Recreation</option>
                                <option value="ANIMALS">Stray Animals</option>
                                <option value="NOISE">Noise Pollution</option>
                                <option value="SANITATION">Public Toilets / Cleanliness</option>
                                <option value="TRAFFIC">Traffic and Parking</option>
                                <option value="SIGNBOARD">Damaged / Missing Signboards</option>
                                <option value="GRANTS">Public Welfare/Grant Issues</option>
                                <option value="LAND">Land Use or Disputes</option>
                                <option value="OTHER">Other</option>
                            </select>
                            <p class="error">${categoryError}</p>
                        </div>
                        <div class="information-box">
                            <label for="department">Department (District):</label>
                            <select name="department" id="department" required>
                                <option value="">-- Select District --</option>
                                <option value="Ampara">Ampara</option>
                                <option value="Anuradhapura">Anuradhapura</option>
                                <option value="Badulla">Badulla</option>
                                <option value="Batticaloa">Batticaloa</option>
                                <option value="Colombo">Colombo</option>
                                <option value="Galle">Galle</option>
                                <option value="Gampaha">Gampaha</option>
                                <option value="Hambantota">Hambantota</option>
                                <option value="Jaffna">Jaffna</option>
                                <option value="Kalutara">Kalutara</option>
                                <option value="Kandy">Kandy</option>
                                <option value="Kegalle">Kegalle</option>
                                <option value="Kilinochchi">Kilinochchi</option>
                                <option value="Kurunegala">Kurunegala</option>
                                <option value="Mannar">Mannar</option>
                                <option value="Matale">Matale</option>
                                <option value="Matara">Matara</option>
                                <option value="Monaragala">Monaragala</option>
                                <option value="Mullaitivu">Mullaitivu</option>
                                <option value="Nuwara Eliya">Nuwara Eliya</option>
                                <option value="Polonnaruwa">Polonnaruwa</option>
                                <option value="Puttalam">Puttalam</option>
                                <option value="Ratnapura">Ratnapura</option>
                                <option value="Trincomalee">Trincomalee</option>
                                <option value="Vavuniya">Vavuniya</option>
                            </select>
                            <p class="error">${departmentError}</p>
                        </div>
                        <div class="information-box">
                            <label for="status">Complaint Status:</label>
                            <select name="status" id="status" required>
                                <option value="">-- Select Status --</option>
                                <option value="PENDING">Pending</option>
                                <option value="IN_PROGRESS">In Progress</option>
                                <option value="RESOLVED">Resolved</option>
                                <option value="REJECTED">Rejected</option>
                            </select>
                            <p class="error">${statusError}</p>
                        </div>
                    </div>
                </div>
                <button type="submit" class="save-com-btn">Save</button>
            </form>
        </div>
    </section>
</main>
</body>
</html>
