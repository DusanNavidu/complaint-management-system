package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.model.UserModel;
import lk.ijse.gdse72.complaintmanagementsystem.util.ValidationUtil;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "signup", value = "/signup")
public class SignUpController extends HttpServlet {

    private UserModel userModel = new UserModel();

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        httpServletRequest.getRequestDispatcher("/pages/signup.jsp").forward(httpServletRequest, httpServletResponse);
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String fullName = httpServletRequest.getParameter("name");
        String birthday = httpServletRequest.getParameter("birthday");
        String nic = httpServletRequest.getParameter("nic_number");
        String username = httpServletRequest.getParameter("username");
        String email = httpServletRequest.getParameter("email");
        String password = httpServletRequest.getParameter("password");
        String confirmPassword = httpServletRequest.getParameter("confirm_password");
        String role = httpServletRequest.getParameter("role");

        boolean hasError = false;

        if (!ValidationUtil.isValidName(fullName)) {
            httpServletRequest.setAttribute("nameError", "Full name is required.");
            hasError = true;
        }

        if (!ValidationUtil.isValidBirthday(birthday)) {
            httpServletRequest.setAttribute("birthdayError", "Birthday is required.");
            hasError = true;
        }

        if (!ValidationUtil.isValidNIC(nic)) {
            httpServletRequest.setAttribute("nicNumberError", "NIC number is required.");
            hasError = true;
        }

//        if (!ValidationUtil.doesNICBirthdayMatch(nic, birthday)) {
//            httpServletRequest.setAttribute("birthdayError", "Birthday does not match NIC.");
//            httpServletRequest.setAttribute("nicNumberError", "NIC does not match Birthday.");
//            hasError = true;
//        }

        if (!ValidationUtil.isValidUsername(username)) {
            httpServletRequest.setAttribute("usernameError", "Invalid username.");
            hasError = true;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            httpServletRequest.setAttribute("emailError", "Invalid email address.");
            hasError = true;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            httpServletRequest.setAttribute("passwordError", "Password must meet criteria.");
            hasError = true;
        }

        if (!password.equals(confirmPassword)) {
            httpServletRequest.setAttribute("confirmPasswordError", "Passwords do not match.");
            hasError = true;
        }

        if (!(role != null && (role.equalsIgnoreCase("EMPLOYEE") || role.equalsIgnoreCase("ADMIN")))) {
            httpServletRequest.setAttribute("roleError", "Role must be EMPLOYEE or ADMIN.");
            hasError = true;
        }

        httpServletRequest.setAttribute("oldName", fullName);
        httpServletRequest.setAttribute("oldNICNumber", nic);
        httpServletRequest.setAttribute("oldUsername", username);
        httpServletRequest.setAttribute("oldEmail", email);
//        httpServletRequest.setAttribute("oldRole", role);

        if (hasError) {
            System.out.println("Validation failed ... forwarding back to form");
            httpServletRequest.getRequestDispatcher("/pages/signup.jsp").forward(httpServletRequest, httpServletResponse);
            return;
        }

        UserDTO userDTO = new UserDTO(
                UserModel.generateUserId(),
                fullName,
                birthday,
                nic,
                username,
                email,
                password,
                role,
                LocalDateTime.now()
        );

        System.out.println("UserDTO created: " + userDTO);
        System.out.println("Before call dao");
        boolean isUserAdded = userModel.saveUser(userDTO);
        System.out.println("After Call dao");

        if (isUserAdded) {
            System.out.println("User created successfully");
            httpServletRequest.setAttribute("successMessage", "User created successfully.");
            httpServletRequest.getRequestDispatcher("pages/signin.jsp").forward(httpServletRequest, httpServletResponse);
        } else {
            System.out.println("Failed to create user");
            httpServletRequest.setAttribute("errorMessage", "Failed to create user. Please try again.");
            httpServletRequest.getRequestDispatcher("pages/signup.jsp").forward(httpServletRequest, httpServletResponse);
        }
    }
}