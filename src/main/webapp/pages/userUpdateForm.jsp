<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserDTO u = (UserDTO) request.getAttribute("user");
    if (u == null) {
        response.sendRedirect("userList.jsp?message=no_user");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">

<a href="${pageContext.request.contextPath}/pages/adminDashboardHome.jsp" style="text-decoration: none; background-color: #153c61; border-radius: 10px; width: 300px; height: 45px; display: flex; justify-content: center; align-items: center; margin-bottom: 40px;">
    <img src="${pageContext.request.contextPath}/assets/icon/house-black-silhouette-without-door.png" alt="home icon" style="width: 35px; height: 35px">
    <h4 class="text-white ms-3">Home</h4>
</a>

<div class="container">
    <h2>Update User</h2>
    <form method="post" action="${pageContext.request.contextPath}/user/update">
        <input type="hidden" name="user_id" value="<%= u.getUser_id() %>">
        <div class="mb-3">
            <label>Full Name</label>
            <input class="form-control" name="full_name" value="<%= u.getFull_name() %>" required>
        </div>
        <div class="mb-3">
            <label>Birthday</label>
            <input type="date" class="form-control" name="birthday" value="<%= u.getBirthday() %>" required>
        </div>
        <div class="mb-3">
            <label>NIC Number</label>
            <input class="form-control" name="nic_number" value="<%= u.getNic_number() %>" required>
        </div>
        <div class="mb-3">
            <label>Email</label>
            <input class="form-control" name="email" value="<%= u.getEmail() %>" required>
        </div>
        <div class="mb-3">
            <label>Role</label>
            <select class="form-select" name="role">
                <option value="ADMIN" <%= "ADMIN".equals(u.getRole()) ? "selected" : "" %>>ADMIN</option>
                <option value="EMPLOYEE" <%= "EMPLOYEE".equals(u.getRole()) ? "selected" : "" %>>EMPLOYEE</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Update</button>
        <a href="${pageContext.request.contextPath}/pages/userList.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
