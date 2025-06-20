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
    <div class="border-end p-3 position-fixed top-0 left-0" style="min-width: 250px; height: 100vh; background-color: #153c61">
        <div class="mb-4 text-white">
            <%
                String role = user.getRole();
                String imagePath = "ADMIN".equalsIgnoreCase(role)
                        ? "/assets/image/images.png"
                        : "/assets/image/Employee Icon with Blue Accents.png";
            %>
            <img src="<%= request.getContextPath() + imagePath %>"
                 alt="<%= role %> image"
                 style="border-radius: 50%; width: 200px; height: 200px;">
<%--            <p class="text-white text-center mt-2"><%= role %></p>--%>
            <p><i>Email:</i> <a style="color: white" href="mailto:<%= user.getEmail() %>"><%= user.getEmail() %></a></p>
            <h3 class="mt-3" style="font-size: 1.3rem">Welcome,</h3>
            <h3 class="fw-bold"><%= user.getFull_name() %></h3>
        </div>
        <ul class="nav flex-column mt-5 gap-3">
            <li class="nav-item"><a class="nav-link text-white"
                                    href="${pageContext.request.contextPath}/pages/adminDashboardHome.jsp"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/house-black-silhouette-without-door.png">
                Home</a>
            </li>
            <li class="nav-item"><a class="nav-link text-white"
                                    href="${pageContext.request.contextPath}/pages/adminDashboardComplaint.jsp"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/complain.png">
                Complaint</a></li>
            <li class="nav-item"><a class="nav-link text-white"
                                    href="${pageContext.request.contextPath}/pages/complaintTables.jsp"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/tablet.png">
                Complaint View</a></li>
            <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>
            <li class="nav-item"><a class="nav-link text-white"
                                    href="${pageContext.request.contextPath}/pages/userTable.jsp"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/user(2).png">
                User details</a></li>
            <% } %>
            <li class="nav-item"><a class="nav-link text-white"
                                    href="#"
                                    style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                <img style="width: 20px; height: 20px;" src="${pageContext.request.contextPath}/assets/icon/setting.png">
                Settings</a></li>
            <li class="nav-item">
                <a class="nav-link text-danger"
                   href="${pageContext.request.contextPath}/logout"
                   style="display: flex; justify-content: start; align-items: center; font-size: 1.1rem; gap: 10px">
                    <img src="${pageContext.request.contextPath}/assets/icon/exit.png"
                         style="width: 20px; height: 20px;" alt="Logout">
                    Logout
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="flex-grow-1 p-5" style="height: 100vh ; margin-left: 250px; background-color: #e9eaf0;">
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

                <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>
                    <div class="col-md-6">
                        <label for="remarks" class="form-label">Remarks</label>
                        <textarea id="remarks" name="remarks" class="form-control" rows="4" placeholder="Enter remarks (Admin only)"></textarea>
                        <div class="text-danger">${remarksError}</div>
                    </div>
                <% } %>

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
            <div class="mt-4 d-flex justify-content-end gap-3">
                <a href="${pageContext.request.contextPath}/pages/complaintTables.jsp" class="btn btn-primary">Complaint Table View</a>
                <button type="submit" class="btn btn-success">Save Complaint</button>
                <p class="text-primary">${complainMassage}</p>
            </div>
        </form>

        <!-- Complaint Table -->
        <div>
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
                    <tbody style="background-color: white">
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
                                    ? "text-bg-dark" : "text-danger fs-6" %>">
                                <%= (c.getRemarks() == null || "null".equalsIgnoreCase(c.getRemarks())) ? "No Remarks" : c.getRemarks() %>
                            </span>
                        </td>
                        <td><%= c.getCreated_at() %></td>
                        <td><%= c.getUpdated_at() %> last update user : <%= user.getUser_id() %></td>
                        <td class="d-flex gap-2">
                            <%
                                boolean isAdmin = user.isAdmin();
                                boolean isEmployee = user.isEmployee();
                                boolean isPending = "PENDING".equalsIgnoreCase(c.getStatus());

                                if (isAdmin || (isEmployee && isPending)) {
                            %>
                            <a class="btn btn-warning btn-sm w-50"
                               href="${pageContext.request.contextPath}/complaint/update?complaintId=<%= c.getComplaint_id() %>">Update</a>
                            <a class="btn btn-danger btn-sm w-50"
                               href="${pageContext.request.contextPath}/complaint/delete?complaintId=<%= c.getComplaint_id() %>"
                               onclick="return confirm('Are you sure you want to delete this complaint?');">Delete</a>
                            <%
                            } else {
                            %>
                            <span class="text-dark fw-bold bg-light">No actions</span>
                            <%
                                }
                            %>
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