package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO;
import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.model.ComplaintModel;
import lk.ijse.gdse72.complaintmanagementsystem.util.ValidationUtil;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "admindashbordsave", value = "/admindashbordsave")
public class AdminDashboardComplaintSave extends HttpServlet {

    private final ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/adminDashboardComplaint.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String subject = req.getParameter("subject");
        String description = req.getParameter("description");
        String category = req.getParameter("category");
        String department = req.getParameter("department");
        String status = req.getParameter("status");

        // Check session user
        UserDTO user = (UserDTO) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/signin.jsp?error=sessionExpired");
            return;
        }

        String userId = user.getUser_id();
        String role = user.getRole(); // You must have this method in UserDTO

        if (userId == null || userId.isEmpty()) {
            req.setAttribute("errorMessage", "User session expired. Please log in again.");
            req.getRequestDispatcher("/pages/signin.jsp").forward(req, resp);
            return;
        }

        // Role-based remarks logic
        String remarks = null;
        if ("ADMIN".equalsIgnoreCase(role)) {
            remarks = req.getParameter("remarks");
            remarks = (remarks != null && !remarks.trim().isEmpty()) ? remarks.trim() : null;
        }

        // Validations
        boolean hasError = false;

        if (!ValidationUtil.isValidSubject(subject)) {
            req.setAttribute("subjectError", "Use letters and numbers only");
            hasError = true;
        }
        if (!ValidationUtil.isValidDescription(description)) {
            req.setAttribute("descriptionError", "Try again... minimum 5 characters");
            hasError = true;
        }
        if (!ValidationUtil.isValidCategory(category)) {
            req.setAttribute("categoryError", "Invalid category");
            hasError = true;
        }
        if (!ValidationUtil.isValidDepartment(department)) {
            req.setAttribute("departmentError", "Invalid department");
            hasError = true;
        }
        if (!ValidationUtil.isValidStatus(status)) {
            req.setAttribute("statusError", "Invalid status");
            hasError = true;
        }

        if (hasError) {
            req.getRequestDispatcher("/pages/adminDashboardComplaint.jsp").forward(req, resp);
            return;
        }

        ComplaintDTO complaintDTO = new ComplaintDTO(
                ComplaintModel.generateComplaintId(),
                userId,
                subject,
                description,
                category,
                department,
                status,
                remarks,
                LocalDateTime.now().toString(),
                null
        );

        boolean isSaved = complaintModel.saveComplaint(complaintDTO);

        if (isSaved) {
            req.setAttribute("complainMassage", "Complaint saved successfully.");
        } else {
            req.setAttribute("complainMassage", "Failed to save complaint. Please try again.");
        }

        req.getRequestDispatcher("/pages/adminDashboardComplaint.jsp").forward(req, resp);
    }
}
