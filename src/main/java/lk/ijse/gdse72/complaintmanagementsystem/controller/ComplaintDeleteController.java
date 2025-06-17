package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/complaint/delete")
public class ComplaintDeleteController extends HttpServlet {

    private final ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String complaintId = req.getParameter("complaintId");

        if (complaintId != null && !complaintId.isEmpty()) {
            boolean isDeleted = complaintModel.deleteComplaints(complaintId);
            if (isDeleted) {
                System.out.println("Complaint deleted: " + complaintId);
                resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?success=deleted");
            } else {
                System.out.println("Complaint delete failed: " + complaintId);
                resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?error=deleteFailed");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/pages/adminDashboardComplaint.jsp?error=invalidId");
        }
    }
}
