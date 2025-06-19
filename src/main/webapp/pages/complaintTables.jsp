<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO" %>
<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Complaint Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<main class="mt-5">
    <%
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/signin.jsp?error=session");
            return;
        }

        String selectedStatus = request.getParameter("status") != null ? request.getParameter("status") : "ALL";
        List<ComplaintDTO> complaints = (List<ComplaintDTO>) request.getAttribute("complaints");
    %>

    <a href="${pageContext.request.contextPath}/pages/adminDashboardHome.jsp">
        <div style="background-color: #153c61; border-radius: 10px; width: 300px; height: 70px; display: flex; justify-content: center; align-items: center; margin-top: 20px;">
            <img src="${pageContext.request.contextPath}/assets/icon/house-black-silhouette-without-door.png" alt="home icon" style="width: 50px; height: 50px">
            <h4 class="text-white ms-3">Home</h4>
        </div>
    </a>

    <h2 class="mb-4">Complaint Management</h2>

    <!-- Filter Dropdown -->
    <form action="${pageContext.request.contextPath}/complaint/filter" method="get" class="d-flex gap-2 mb-3">
        <select name="status" class="form-select" style="width: 200px;">
            <option value="ALL" <%= "ALL".equals(selectedStatus) ? "selected" : "" %>>All</option>
            <option value="RECENT" <%= "RECENT".equals(selectedStatus) ? "selected" : "" %>>Recently</option>
            <option value="PENDING" <%= "PENDING".equals(selectedStatus) ? "selected" : "" %>>Pending</option>
            <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(selectedStatus) ? "selected" : "" %>>In Progress</option>
            <option value="RESOLVED" <%= "RESOLVED".equals(selectedStatus) ? "selected" : "" %>>Resolved</option>
            <option value="REJECTED" <%= "REJECTED".equals(selectedStatus) ? "selected" : "" %>>Rejected</option>
        </select>
        <button type="submit" class="btn btn-primary">OK</button>
    </form>

    <!-- Complaint Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover m-0">
            <thead class="table-dark sticky-top">
            <tr>
                <th>Complaint ID</th>
                <th>User ID</th>
                <th>Subject</th>
                <th>Description</th>
                <th>Category</th>
                <th>Department</th>
                <th>Status</th>
                <th>Remarks</th>
                <th>Created At</th>
                <th>Updated At</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (complaints != null && !complaints.isEmpty()) {
                    for (ComplaintDTO c : complaints) {
            %>
            <tr>
                <td><%= c.getComplaint_id() %></td>
                <td><%= c.getUser_id() %></td>
                <td><%= c.getSubject() %></td>
                <td><%= c.getDescription() %></td>
                <td><%= c.getCategory() %></td>
                <td><%= c.getDepartment() %></td>
                <td>
                    <span class="badge
                        <%= "PENDING".equals(c.getStatus()) ? "text-bg-success" :
                             "IN_PROGRESS".equals(c.getStatus()) ? "text-bg-warning" :
                             "RESOLVED".equals(c.getStatus()) ? "text-bg-primary" :
                             "REJECTED".equals(c.getStatus()) ? "text-bg-danger" :
                             "text-bg-secondary" %>">
                        <%= c.getStatus() %>
                    </span>
                </td>
                <td>
                    <%= (c.getRemarks() == null || "null".equalsIgnoreCase(c.getRemarks())) ? "No Remarks" : c.getRemarks() %>
                </td>
                <td><%= c.getCreated_at() %></td>
                <td><%= c.getUpdated_at() %> (by: <%= user.getUser_id() %>)</td>
                <td class="d-flex gap-2">
                    <a class="btn btn-warning btn-sm w-50"
                       href="${pageContext.request.contextPath}/complaint/update?complaintId=<%= c.getComplaint_id() %>">Update</a>
                    <a class="btn btn-danger btn-sm w-50"
                       href="${pageContext.request.contextPath}/complaint/delete?complaintId=<%= c.getComplaint_id() %>"
                       onclick="return confirm('Are you sure you want to delete this complaint?');">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="11" class="text-center">No complaints found for this filter.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
