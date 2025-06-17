package lk.ijse.gdse72.complaintmanagementsystem.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.complaintmanagementsystem.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/complaint/update")
public class ComplaintUpdateController extends HttpServlet {

    private final ComplaintModel complaintModel = new ComplaintModel();

    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException {
        String complaintId = httpServletRequest.getParameter("complaintId");
//        String userId = httpServletRequest.getParameter("userId");


    }
}
