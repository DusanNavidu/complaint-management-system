package lk.ijse.gdse72.complaintmanagementsystem.model;

import lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO;
import lk.ijse.gdse72.complaintmanagementsystem.util.DatabaseConfig;

import java.sql.Connection;

public class ComplaintModel {
    public static String generateComplaintId() {
        return "CMP" + java.util.UUID.randomUUID().toString().substring(0, 15).toUpperCase();  // Example format: CMP-1234567890ABCDEF
    }

    public boolean saveComplaint(ComplaintDTO complaintDTO) {
        String sql = "INSERT INTO complaint (complaint_id, user_id, subject, description, category, department, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
            var preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, complaintDTO.getComplaint_id());
            preparedStatement.setString(2, complaintDTO.getUser_id());
            preparedStatement.setString(3, complaintDTO.getSubject());
            preparedStatement.setString(4, complaintDTO.getDescription());
            preparedStatement.setString(5, complaintDTO.getCategory());
            preparedStatement.setString(6, complaintDTO.getDepartment());
            preparedStatement.setString(7, complaintDTO.getStatus());

            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
