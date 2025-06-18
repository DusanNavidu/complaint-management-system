package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.gdse72.complaintmanagementsystem.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/dashboard/home")
public class DashBoardHomeServlet extends HttpServlet {
    ComplaintModel complaintModel = new ComplaintModel();

    private void loadCounts(HttpServletRequest req) {
        int pendingCount = complaintModel.countByStatus("PENDING");
        int inProgressCount = complaintModel.countByStatus("IN_PROGRESS");
        int resolvedCount = complaintModel.countByStatus("RESOLVED");
        int rejectedCount = complaintModel.countByStatus("REJECTED");

        req.setAttribute("pendingCount", pendingCount);
        req.setAttribute("inProgressCount", inProgressCount);
        req.setAttribute("resolvedCount", resolvedCount);
        req.setAttribute("rejectedCount", rejectedCount);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        loadCounts(req);
        req.getRequestDispatcher("/pages/adminDashboardHome.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        loadCounts(req);
        req.getRequestDispatcher("/pages/adminDashboardHome.jsp").forward(req, resp);
    }
}
