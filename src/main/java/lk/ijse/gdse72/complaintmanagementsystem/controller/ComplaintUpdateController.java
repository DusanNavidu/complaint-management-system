package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO;
import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/complaint/update")
public class ComplaintUpdateController extends HttpServlet {

    private final ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String complaintId = req.getParameter("complaintId");

        if (complaintId != null && !complaintId.isEmpty()) {
            try {
                ComplaintDTO complaint = complaintModel.getComplaintById(complaintId);
                if (complaint != null) {
                    req.setAttribute("complaint", complaint);
                    req.getRequestDispatcher("/pages/update-complaint.jsp").forward(req, resp);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin-dashboard.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String complaintId = req.getParameter("complaintId");
        String subject = req.getParameter("subject");
        String description = req.getParameter("description");
        String category = req.getParameter("category");
        String department = req.getParameter("department");
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        UserDTO user = (UserDTO) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/signin.jsp?error=session");
            return;
        }

        try {
            ComplaintDTO existingComplaint = complaintModel.getComplaintById(complaintId);
            if (existingComplaint == null) {
                resp.sendRedirect(req.getContextPath() + "/pages/update-complaint.jsp?error=notFound");
                return;
            }

            if (user.isEmployee()) {
                if (!"PENDING".equalsIgnoreCase(existingComplaint.getStatus())) {
                    // Employee is not allowed to update non-pending complaints
                    resp.sendRedirect(req.getContextPath() + "/pages/update-complaint.jsp?error=notAllowed");
                    return;
                }
            }

            ComplaintDTO complaint = new ComplaintDTO();
            complaint.setComplaint_id(complaintId);
            complaint.setSubject(subject);
            complaint.setDescription(description);
            complaint.setCategory(category);
            complaint.setDepartment(department);

            if (user.isAdmin()) {
                complaint.setStatus(status);
                complaint.setRemarks(remarks);
            } else {
                // Employee cannot change status or remarks — preserve them
                complaint.setStatus(existingComplaint.getStatus());
                complaint.setRemarks(existingComplaint.getRemarks());
            }

            if (complaintModel.updateComplaint(complaint)) {
                resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?success=update");
            } else {
                resp.sendRedirect(req.getContextPath() + "/pages/update-complaint.jsp?error=updateFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin-dashboard.jsp?error=exception");
        }
    }
}
