package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.dao.UserDAO;
import lk.ijse.gdse72.complaintmanagementsystem.model.User;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/sign-up")
public class SignUpController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Generate random UUID for user_id
        String userId = UUID.randomUUID().toString();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String role = req.getParameter("role");

        // Create a new user
        User user = new User(userId, username, password, fullName, email, role, true);

        // Get the datasource from servlet context
        DataSource ds = (DataSource) getServletContext().getAttribute("ds");
        UserDAO userDAO = new UserDAO(ds);

        try {
            boolean success = userDAO.save(user);
            if (success) {
                resp.getWriter().write("User registered successfully!");
            } else {
                resp.getWriter().write("Failed to register user.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("An error occurred while registering user.");
        }
    }
}
