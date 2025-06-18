<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO" %>
<%
    ComplaintDTO complaint = (ComplaintDTO) request.getAttribute("complaint");
%>
<html>
<head>
    <title>Update Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4 bg-light">
<div class="container">
    <h2>Update Complaint</h2>
    <form action="${pageContext.request.contextPath}/complaint/update" method="post">
        <input type="hidden" name="complaint_id" value="<%= complaint.getComplaint_id() %>">

        <div class="mb-3">
            <label for="subject">Subject</label>
            <input type="text" class="form-control" id="subject" name="subject" value="<%= complaint.getSubject() %>" required>
        </div>

        <div class="mb-3">
            <label for="description">Description</label>
            <textarea name="description" class="form-control" required><%= complaint.getDescription() %></textarea>
        </div>

        <div class="mb-3">
            <label for="category">Category</label>
            <input type="text" class="form-control" name="category" value="<%= complaint.getCategory() %>" required>
        </div>

        <div class="mb-3">
            <label for="department">Department</label>
            <input type="text" class="form-control" name="department" value="<%= complaint.getDepartment() %>" required>
        </div>

        <div class="mb-3">
            <label for="status">Status</label>
            <select name="status" class="form-select">
                <option value="PENDING" <%= "PENDING".equals(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>In Progress</option>
                <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                <option value="REJECTED" <%= "REJECTED".equals(complaint.getStatus()) ? "selected" : "" %>>Rejected</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="remarks">Remarks</label>
            <textarea name="remarks" class="form-control"><%= complaint.getRemarks() %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
    </form>
</div>
</body>
</html>
