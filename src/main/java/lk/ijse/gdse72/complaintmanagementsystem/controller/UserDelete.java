package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.model.UserModel;

import java.io.IOException;

@WebServlet("/user/delete")
public class UserDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        if (userId != null && !userId.isEmpty()) {
            try {
                UserModel userModel = new UserModel();
                boolean isDeleted = userModel.deleteUser(userId);

                if (isDeleted) {
                    resp.sendRedirect(req.getContextPath() + "/pages/userTable.jsp?message=deleted");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/pages/userTable.jsp?message=not_deleted");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/pages/userTable.jsp?message=error");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/pages/userTable.jsp?message=invalid");
        }
    }
}