package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/complaint/delete")
public class ComplaintDeleteController extends HttpServlet {

    private final ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserDTO user = (UserDTO) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/signin.jsp?error=session");
            return;
        }

        String complaintId = req.getParameter("complaintId");

        if (complaintId == null || complaintId.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?error=invalidId");
            return;
        }

        try {
            // Get complaint status from DB
            String status = complaintModel.getComplaintStatus(complaintId);

            if (status == null) {
                // complaint not found
                resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?error=notFound");
                return;
            }

            boolean canDelete = false;
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                // Admin can delete any complaint
                canDelete = true;
            } else {
                // Employee can delete only if status = PENDING
                if ("PENDING".equalsIgnoreCase(status)) {
                    canDelete = true;
                }
            }

            if (!canDelete) {
                // Not authorized to delete this complaint
                resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?error=notAuthorized");
                return;
            }

            boolean isDeleted = complaintModel.deleteComplaint(complaintId);
            if (isDeleted) {
                resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?success=deleted");
                req.setAttribute("complainMassage", "Complaint deleted successfully.");
            } else {
                resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?error=deleteFailed");
                req.setAttribute("complainMassage", "Failed to delete complaint. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?error=serverError");
        }
    }
}
