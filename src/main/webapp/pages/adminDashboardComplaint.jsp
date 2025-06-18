<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO" %>
<%@ page import="lk.ijse.gdse72.complaintmanagementsystem.model.ComplaintModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Complaint Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<main class="d-flex">
    <%
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/signin.jsp?error=session");
            return;
        }
    %>

    <!-- Sidebar -->
    <div class="bg-white border-end p-3" style="min-width: 250px; height: 100vh;">
        <div class="mb-4">
            <img src="${pageContext.request.contextPath}/assets/image/images.png" alt="user image" style="border-radius: 50% ;width: 200px; height: 200px;">
            <p><i>Email : </i> <%= user.getEmail() %></p>
            <h3 class="mt-3"><p style="font-size: 1.3rem">Welcome,</p><br> <%= user.getFull_name() %></h3>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pages/adminDashboardHome.jsp">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Complaint</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Settings</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="flex-grow-1 p-4" style="height: 100vh">
        <h2>Complaint Management System</h2>
        <p class="text-muted">Dashboard Complaint</p>

        <!-- Complaint Form -->
        <form action="${pageContext.request.contextPath}/admindashbordsave" method="post">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="subject" class="form-label">Subject</label>
                    <input type="text" id="subject" name="subject" class="form-control" placeholder="Enter subject" required>
                    <div class="text-danger">${subjectError}</div>
                </div>
                <div class="col-md-6">
                    <label for="category" class="form-label">Complaint Category</label>
                    <select name="category" id="category" class="form-select" required>
                        <option value="">-- Select Category --</option>
                        <option value="Road Maintenance">Road Maintenance</option>
                        <option value="Waste Management">Waste Management</option>
                        <option value="Drainage and Sewage">Drainage and Sewage</option>
                        <option value="Water Supply Issues">Water Supply Issues</option>
                        <option value="Electricity">Electricity</option>
                        <option value="Unauthorized Constructions">Unauthorized Constructions</option>
                        <option value="Public Parks">Public Parks</option>
                        <option value="Stray Animals">Stray Animals</option>
                        <option value="Noise Pollution">Noise Pollution</option>
                        <option value="Sanitation">Sanitation</option>
                        <option value="Traffic">Traffic</option>
                        <option value="Signboards">Signboards</option>
                        <option value="Grants">Grants</option>
                        <option value="Land">Land</option>
                        <option value="OTHER">Other</option>
                    </select>
                    <div class="text-danger">${categoryError}</div>
                </div>

                <div class="col-md-6">
                    <label for="description" class="form-label">Description</label>
                    <textarea id="description" name="description" class="form-control" rows="4" placeholder="Enter description" required></textarea>
                    <div class="text-danger">${descriptionError}</div>
                </div>

                <div class="col-md-6">
                    <label for="remarks" class="form-label">Remarks</label>
                    <textarea id="remarks" name="remarks" class="form-control" rows="4" placeholder="Enter remarks ( Admin only )"></textarea>
                    <div class="text-danger">${remarksError}</div>
                </div>

                <div class="col-md-6">
                    <label for="department" class="form-label">Department</label>
                    <select name="department" id="department" class="form-select" required>
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
                    <div class="text-danger">${departmentError}</div>
                </div>

                <div class="col-md-6">
                    <label for="status" class="form-label">Status</label>
                    <select name="status" id="status" class="form-select" required>
                        <option value="">-- Select Status --</option>
                        <option value="PENDING">Pending</option>
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="RESOLVED">Resolved</option>
                        <option value="REJECTED">Rejected</option>
                    </select>
                    <div class="text-danger">${statusError}</div>
                </div>
            </div>
            <div class="mt-4">
                <button type="submit" class="btn btn-success">Save Complaint</button>
            </div>
        </form>

        <!-- Complaint Table -->
        <div class="mt-5">
            <h4>All Complaints</h4>

            <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
                <table class="table table-bordered table-hover m-0">
                    <thead class="table-dark" style="position: sticky; top: 0; z-index: 1;">
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
                        List<ComplaintDTO> complaints = null;
                        try {
                            complaints = new ComplaintModel().getComplaintsAll();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        if (complaints != null) {
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
                    <span class="badge
                        <%= (c.getRemarks() == null || "null".equalsIgnoreCase(c.getRemarks()))
                            ? "text-bg-dark" : "text-danger" %>">
                        <%= (c.getRemarks() == null || "null".equalsIgnoreCase(c.getRemarks())) ? "No Remarks" : c.getRemarks() %>
                    </span>
                        </td>
                        <td><%= c.getCreated_at() %></td>
                        <td><%= c.getUpdated_at() %> last update user : <%= user.getUser_id() %></td>
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
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>