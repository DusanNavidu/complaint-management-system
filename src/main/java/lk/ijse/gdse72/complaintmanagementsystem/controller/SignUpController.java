package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.dao.UserDAO;
import lk.ijse.gdse72.complaintmanagementsystem.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.UUID;

@WebServlet(name = "signup", value = "/signup")
public class SignUpController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource dataSource = (BasicDataSource) servletContext.getAttribute("ds");

        // Build User object
        User user = new User();
        user.setUserId(UUID.randomUUID().toString());
        user.setUsername(req.getParameter("username"));
        user.setPassword(req.getParameter("password"));
        user.setFullName(req.getParameter("full_name"));
        user.setEmail(req.getParameter("email"));
        user.setRole(req.getParameter("role"));
        user.setActive(Boolean.parseBoolean(req.getParameter("is_active")));

        // Call DAO
        UserDAO userDAO = new UserDAO(dataSource);
        boolean result = userDAO.saveUser(user);

        if (result) {
            resp.sendRedirect(req.getContextPath() + "/pages/signup.jsp?message=User registered successfully");
        } else {
            resp.getWriter().println("User registration failed");
        }
    }
}