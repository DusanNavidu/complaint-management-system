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

    private ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        httpServletRequest.getRequestDispatcher("/pages/adminDashboardComplaint.jsp").forward(httpServletRequest, httpServletResponse);
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String subject = httpServletRequest.getParameter("subject");
        System.out.println("Subject: " + subject);
        String description = httpServletRequest.getParameter("description");
        String category = httpServletRequest.getParameter("category");
        String department = httpServletRequest.getParameter("department");
        String status = httpServletRequest.getParameter("status");
        String remarks = httpServletRequest.getParameter("remarks");
        remarks = (remarks != null && !remarks.trim().isEmpty()) ? remarks.trim() : null;

        boolean hasError = false;

        if (!ValidationUtil.isValidSubject(subject)) {
            httpServletRequest.setAttribute("subjectError", "Use letters and numbers only");
            hasError = true;
        }
        if (!ValidationUtil.isValidDescription(description)) {
            httpServletRequest.setAttribute("descriptionError", "UTry again... minimum 5 characters");
            hasError = true;
        }
        if (!ValidationUtil.isValidCategory(category)) {
            httpServletRequest.setAttribute("categoryError", "Invalid category");
            hasError = true;
        }
        if (!ValidationUtil.isValidDepartment(department)) {
            httpServletRequest.setAttribute("departmentError", "Invalid department");
            hasError = true;
        }
        if (!ValidationUtil.isValidStatus(status)) {
            httpServletRequest.setAttribute("statusError", "Invalid status");
            hasError = true;
        }
//        if (!ValidationUtil.isValidRemarks(remarks)) {
//            httpServletRequest.setAttribute("remarksError" , "Try again... minimum 5 characters");
//            hasError = true;
//        }

        if (hasError) {
            System.out.println("Validation errors found, redirecting to form.");
            httpServletRequest.getRequestDispatcher("/pages/adminDashboardComplaint.jsp").forward(httpServletRequest, httpServletResponse);
            return;
        }
        UserDTO user = (UserDTO) httpServletRequest.getSession().getAttribute("user");
        if (user == null) {
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/signin.jsp?error=sessionExpired");
            return;
        }
        String userId = user.getUser_id();
        System.out.println("User ID: " + userId);
        if (userId == null || userId.isEmpty()) {
            System.out.println("User ID is null or empty.");
            httpServletRequest.setAttribute("errorMessage", "User session expired. Please log in again.");
            httpServletRequest.getRequestDispatcher("/pages/signin.jsp").forward(httpServletRequest, httpServletResponse);
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
            System.out.println("Complaint saved successfully.");
            httpServletRequest.setAttribute("successMessage", "Complaint saved successfully.");
            httpServletRequest.getRequestDispatcher("/pages/adminDashboardComplaint.jsp").forward(httpServletRequest, httpServletResponse);
        } else {
            System.out.println("Failed to save complaint.");
            httpServletRequest.setAttribute("errorMessage", "Failed to save complaint. Please try again.");
            httpServletRequest.getRequestDispatcher("/pages/adminDashboardComplaint.jsp").forward(httpServletRequest, httpServletResponse);
        }
    }
}
