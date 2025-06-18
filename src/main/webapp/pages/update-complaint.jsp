<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ComplaintDTO complaint = (ComplaintDTO) request.getAttribute("complaint");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">
<h2>Update Complaint</h2>
<form action="<%= request.getContextPath() %>/complaint/update" method="post">
    <!-- ✅ Fixed hidden field name to match servlet -->
    <input type="hidden" name="complaintId" value="<%= complaint.getComplaint_id() %>">

    <div class="mb-3">
        <label>Subject</label>
        <input type="text" name="subject" class="form-control" value="<%= complaint.getSubject() %>" required>
    </div>

    <div class="mb-3">
        <label>Description</label>
        <textarea name="description" class="form-control" required><%= complaint.getDescription() %></textarea>
    </div>

    <div class="mb-3">
        <label>Category</label>
        <select name="category" class="form-select" required>
            <option value="Road Maintenance" <%= complaint.getCategory().equals("ROADS") ? "selected" : "" %>>Road Maintenance</option>
            <option value="Waste Management" <%= complaint.getCategory().equals("Waste Management") ? "selected" : "" %>>Waste Management</option>
            <option value="Drainage and Sewage" <%= complaint.getCategory().equals("Drainage and Sewage") ? "selected" : "" %>>Drainage and Sewage</option>
            <option value="Water Supply Issues" <%= complaint.getCategory().equals("Water Supply Issues") ? "selected" : "" %>>Water Supply Issues</option>
            <option value="Electricity" <%= complaint.getCategory().equals("Electricity") ? "selected" : "" %>>Electricity</option>
            <option value="Unauthorized Constructions" <%= complaint.getCategory().equals("Unauthorized Constructions") ? "selected" : "" %>>Unauthorized Constructions</option>
            <option value="Public Parks" <%= complaint.getCategory().equals("Public Parks") ? "selected" : "" %>>Public Parks</option>
            <option value="Stray Animals" <%= complaint.getCategory().equals("Stray Animals") ? "selected" : "" %>>Stray Animals</option>
            <option value="Noise Pollution" <%= complaint.getCategory().equals("Noise Pollution") ? "selected" : "" %>>Noise Pollution</option>
            <option value="Sanitation" <%= complaint.getCategory().equals("Sanitation") ? "selected" : "" %>>Sanitation</option>
            <option value="Traffic" <%= complaint.getCategory().equals("Traffic") ? "selected" : "" %>>Traffic</option>
            <option value="Signboards" <%= complaint.getCategory().equals("Signboards") ? "selected" : "" %>>Signboards</option>
            <option value="Grants" <%= complaint.getCategory().equals("Grants") ? "selected" : "" %>>Grants</option>
            <option value="Land" <%= complaint.getCategory().equals("Land") ? "selected" : "" %>>Land</option>
            <option value="OTHER" <%= complaint.getCategory().equals("OTHER") ? "selected" : "" %>>Other</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Department</label>
        <select name="department" class="form-select" required>
            <option value="Ampara" <%= complaint.getDepartment().equals("Ampara") ? "selected" : "" %>>Ampara</option>
            <option value="Anuradhapura" <%= complaint.getDepartment().equals("Anuradhapura") ? "selected" : "" %>>Anuradhapura</option>
            <option value="Badulla" <%= complaint.getDepartment().equals("Badulla") ? "selected" : "" %>>Badulla</option>
            <option value="Batticaloa" <%= complaint.getDepartment().equals("Batticaloa") ? "selected" : "" %>>Batticaloa</option>
            <option value="Colombo" <%= complaint.getDepartment().equals("Colombo") ? "selected" : "" %>>Colombo</option>
            <option value="Galle" <%= complaint.getDepartment().equals("Galle") ? "selected" : "" %>>Galle</option>
            <option value="Gampaha" <%= complaint.getDepartment().equals("Gampaha") ? "selected" : "" %>>Gampaha</option>
            <option value="Hambantota" <%= complaint.getDepartment().equals("Hambantota") ? "selected" : "" %>>Hambantota</option>
            <option value="Jaffna" <%= complaint.getDepartment().equals("Jaffna") ? "selected" : "" %>>Jaffna</option>
            <option value="Kalutara" <%= complaint.getDepartment().equals("Kalutara") ? "selected" : "" %>>Kalutara</option>
            <option value="Kandy" <%= complaint.getDepartment().equals("Kandy") ? "selected" : "" %>>Kandy</option>
            <option value="Kegalle" <%= complaint.getDepartment().equals("Kegalle") ? "selected" : "" %>>Kegalle</option>
            <option value="Kilinochchi" <%= complaint.getDepartment().equals("Kilinochchi") ? "selected" : "" %>>Kilinochchi</option>
            <option value="Kurunegala" <%= complaint.getDepartment().equals("Kurunegala") ? "selected" : "" %>>Kurunegala</option>
            <option value="Mannar" <%= complaint.getDepartment().equals("Mannar") ? "selected" : "" %>>Mannar</option>
            <option value="Matale" <%= complaint.getDepartment().equals("Matale") ? "selected" : "" %>>Matale</option>
            <option value="Matara" <%= complaint.getDepartment().equals("Matara") ? "selected" : "" %>>Matara</option>
            <option value="Monaragala" <%= complaint.getDepartment().equals("Monaragala") ? "selected" : "" %>>Monaragala</option>
            <option value="Mullaitivu" <%= complaint.getDepartment().equals("Mullaitivu") ? "selected" : "" %>>Mullaitivu</option>
            <option value="Nuwara Eliya" <%= complaint.getDepartment().equals("Nuwara Eliya") ? "selected" : "" %>>Nuwara Eliya</option>
            <option value="Polonnaruwa" <%= complaint.getDepartment().equals("Polonnaruwa") ? "selected" : "" %>>Polonnaruwa</option>
            <option value="Puttalam" <%= complaint.getDepartment().equals("Puttalam") ? "selected" : "" %>>Puttalam</option>
            <option value="Ratnapura" <%= complaint.getDepartment().equals("Ratnapura") ? "selected" : "" %>>Ratnapura</option>
            <option value="Trincomalee" <%= complaint.getDepartment().equals("Trincomalee") ? "selected" : "" %>>Trincomalee</option>
            <option value="Vavuniya" <%= complaint.getDepartment().equals("Vavuniya") ? "selected" : "" %>>Vavuniya</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Status</label>
        <select name="status" class="form-select" required>
            <option value="PENDING" <%= complaint.getStatus().equals("PENDING") ? "selected" : "" %>>Pending</option>
            <option value="IN_PROGRESS" <%= complaint.getStatus().equals("IN_PROGRESS") ? "selected" : "" %>>In Progress</option>
            <option value="RESOLVED" <%= complaint.getStatus().equals("RESOLVED") ? "selected" : "" %>>Resolved</option>
            <option value="REJECTED" <%= complaint.getStatus().equals("REJECTED") ? "selected" : "" %>>Rejected</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Remarks</label>
        <textarea name="remarks" class="form-control"><%= complaint.getRemarks() %></textarea>
    </div>

    <button type="submit" class="btn btn-primary" onclick="return confirm('Are you sure you want to update this complaint?')">Update</button>
</form>
</body>
</html>
