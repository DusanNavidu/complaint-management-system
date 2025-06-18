package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO;
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
        // ✅ Fixed: parameter name now matches the form field
        String complaintId = req.getParameter("complaintId");
        String subject = req.getParameter("subject");
        String description = req.getParameter("description");
        String category = req.getParameter("category");
        String department = req.getParameter("department");
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        ComplaintDTO complaint = new ComplaintDTO();
        complaint.setComplaint_id(complaintId);
        complaint.setSubject(subject);
        complaint.setDescription(description);
        complaint.setCategory(category);
        complaint.setDepartment(department);
        complaint.setStatus(status);
        complaint.setRemarks(remarks);

        try {
            if (complaintModel.updateComplaint(complaint)) {
                System.out.println("Complaint updated successfully: " + complaintId);
                resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?success=update");
            } else {
                System.out.println("Update failed for complaint ID: " + complaintId);
                resp.sendRedirect(req.getContextPath() + "/pages/update-complaint.jsp?error=update");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin-dashboard.jsp?error=exception");
        }
    }
}
