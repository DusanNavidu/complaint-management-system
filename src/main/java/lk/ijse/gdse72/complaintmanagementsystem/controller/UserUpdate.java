package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.model.UserModel;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user/update")
public class UserUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");

        try {
            UserModel userModel = new UserModel();
            UserDTO userDTO = userModel.getUserById(userId);

            if (userDTO != null) {
                req.setAttribute("user", userDTO);
                req.getRequestDispatcher("/pages/userUpdateForm.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/pages/userTable.jsp?message=not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/pages/userTable.jsp?message=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDTO dto = new UserDTO();
        dto.setUser_id(req.getParameter("user_id"));
        dto.setFull_name(req.getParameter("full_name"));
        dto.setBirthday(req.getParameter("birthday"));
        dto.setNic_number(req.getParameter("nic_number"));
        dto.setEmail(req.getParameter("email"));
        dto.setRole(req.getParameter("role"));

        try {
            boolean updated = new UserModel().updateUser(dto);
            if (updated) {
                resp.sendRedirect(req.getContextPath() + "/pages/userTable.jsp?message=updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/pages/userUpdateForm.jsp?message=not_updated");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/pages/userTable.jsp.jsp?message=error");
        }
    }
}
