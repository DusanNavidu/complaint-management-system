package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.model.UserModel;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/signin")
public class SignInController extends HttpServlet {

    private UserModel userModel = new UserModel();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to signin JSP page
        request.getRequestDispatcher("/pages/signin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDTO userDTO = null;
        try {
            userDTO = userModel.userLogin(username, password);
        } catch (SQLException e) {
            e.printStackTrace();
            // You can forward to an error page or set error message here
            response.sendRedirect(request.getContextPath() + "/pages/signin.jsp?error=unknown");
            return;
        }

        if (userDTO != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", userDTO);

            if (userDTO.isAdmin()) {
                System.out.println("Admin user logged in: " + userDTO.getUsername());
                response.sendRedirect(request.getContextPath() + "/pages/adminDashboardComplaint.jsp");
            } else if (userDTO.isEmployee()) {
                System.out.println("Employee user logged in: " + userDTO.getUsername());
                response.sendRedirect(request.getContextPath() + "/pages/employee-adminDashboardHome.jsp");
            } else {
                // Role not recognized
                System.out.println("User with unrecognized role logged in: " + userDTO.getUsername());
                response.sendRedirect(request.getContextPath() + "/pages/signin.jsp?error=role");
            }
        } else {
            // Invalid username/password
            System.out.println("Invalid login attempt for username: " + username);
            response.sendRedirect(request.getContextPath() + "/pages/signin.jsp?error=invalid");
        }
    }
}