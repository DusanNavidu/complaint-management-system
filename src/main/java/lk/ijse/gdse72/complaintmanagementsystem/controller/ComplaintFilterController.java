package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO;
import lk.ijse.gdse72.complaintmanagementsystem.model.ComplaintModel;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/complaint/filter")
public class ComplaintFilterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        String searchId = req.getParameter("searchId");

        ComplaintModel model = new ComplaintModel();
        List<ComplaintDTO> complaints = new ArrayList<>();

        try {
            if (searchId != null && !searchId.trim().isEmpty()) {
                // If complaint_id is provided, ignore status and search by ID
                ComplaintDTO complaint = model.getComplaintById(searchId.trim());
                if (complaint != null) {
                    complaints.add(complaint);
                }
            } else {
                // No searchId provided — apply status filter
                if (status == null || status.equalsIgnoreCase("ALL")) {
                    complaints = model.getComplaintsAll();
                } else if (status.equalsIgnoreCase("RECENT")) {
                    complaints = model.getRecentComplaints();
                } else {
                    complaints = model.getComplaintsByStatus(status);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error filtering complaints", e);
        }

        req.setAttribute("complaints", complaints);
        req.setAttribute("status", status != null ? status : "ALL");
        req.setAttribute("searchId", searchId != null ? searchId.trim() : "");

        req.getRequestDispatcher("/pages/complaintTables.jsp").forward(req, resp);
    }
}
