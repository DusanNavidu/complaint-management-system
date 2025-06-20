<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.model.UserModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">

<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/signin.jsp?error=session");
        return;
    }
%>

<a href="${pageContext.request.contextPath}/pages/adminDashboardHome.jsp" style="text-decoration: none; background-color: #153c61; border-radius: 10px; width: 300px; height: 45px; display: flex; justify-content: center; align-items: center; margin-bottom: 40px;">
    <img src="${pageContext.request.contextPath}/assets/icon/house-black-silhouette-without-door.png" alt="home icon" style="width: 35px; height: 35px">
    <h4 class="text-white ms-3">Home</h4>
</a>

<div class="container">
    <h2 class="mb-4">User List</h2>

    <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
        <table class="table table-bordered table-hover m-0">
            <thead class="table-dark sticky-top">
            <tr>
                <th>User ID</th>
                <th>Full Name</th>
                <th>Birthday</th>
                <th>NIC Number</th>
                <th>Email</th>
                <th>Role</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<UserDTO> userDTOList = null;
                try {
                    userDTOList = new UserModel().getAllUsers();
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (userDTOList != null) {
                    for (UserDTO u : userDTOList) {
            %>
            <tr>
                <td><%= u.getUser_id() %></td>
                <td><%= u.getFull_name() %></td>
                <td><%= u.getBirthday() %></td>
                <td><%= u.getNic_number() %></td>
                <td><%= u.getEmail() %></td>
                <td><%= u.getRole() %></td>
                <td><%= u.getCreated_at() %></td>
                <td class="d-flex gap-2">
                    <%
                        if ("ADMIN".equals(user.getRole())) {
                    %>
                    <a class="btn btn-warning btn-sm w-50"
                       href="${pageContext.request.contextPath}/user/update?userId=<%= u.getUser_id() %>">Update</a>
                    <a class="btn btn-danger btn-sm w-50"
                       href="${pageContext.request.contextPath}/user/delete?userId=<%= u.getUser_id() %>"
                       onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                    <%
                    } else {
                    %>
                    <span class="text-muted">No actions</span>
                    <%
                        }
                    %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8" class="text-center text-muted">No users found.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
