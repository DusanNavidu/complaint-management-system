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
import java.util.List;

@WebServlet("/complaint/filter")
public class ComplaintFilterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");

        ComplaintModel model = new ComplaintModel();
        List<ComplaintDTO> complaints;

        try {
            if (status == null || status.equalsIgnoreCase("ALL")) {
                complaints = model.getComplaintsAll();
            } else if (status.equalsIgnoreCase("RECENT")) {
                complaints = model.getRecentComplaints(); // You'll implement this
            } else {
                complaints = model.getComplaintsByStatus(status);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        req.setAttribute("complaints", complaints);
        req.setAttribute("status", status); // to keep the dropdown selected

        req.getRequestDispatcher("/pages/complaintTables.jsp").forward(req, resp);
    }
}

