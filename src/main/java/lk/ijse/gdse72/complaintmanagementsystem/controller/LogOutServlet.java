package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogOutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // Avoid creating a new session
        if (session != null) {
            session.invalidate(); // Destroy session
        }

        // Optional: clear cache so back button doesn't reopen session-protected pages
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        resp.setHeader("Pragma", "no-cache"); // HTTP 1.0
        resp.setDateHeader("Expires", 0); // Proxies

        // Redirect to login page
        resp.sendRedirect(req.getContextPath() + "/pages/signin.jsp");
    }
}
