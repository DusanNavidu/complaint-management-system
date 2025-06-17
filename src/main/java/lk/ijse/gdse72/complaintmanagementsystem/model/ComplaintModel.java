package lk.ijse.gdse72.complaintmanagementsystem.model;

import lk.ijse.gdse72.complaintmanagementsystem.dto.ComplaintDTO;
import lk.ijse.gdse72.complaintmanagementsystem.util.DatabaseConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class ComplaintModel {
    public static String generateComplaintId() {
        String id;
        do {
            id = "CMP-" + UUID.randomUUID().toString().substring(0, 15).toUpperCase();
        } while (complaintIdExists(id));
        return id;
    }

    private static boolean complaintIdExists(String id) {
        String sql = "SELECT complaint_id FROM complaint WHERE complaint_id = ?";
        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
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

    public List<ComplaintDTO> getComplaintsAll() throws SQLException {
        List<ComplaintDTO> complaintDTO = new ArrayList<>();
        String sql = "SELECT * FROM complaint";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ComplaintDTO complaint = new ComplaintDTO();
                complaint.setComplaint_id(resultSet.getString("complaint_id"));
                complaint.setUser_id(resultSet.getString("user_id"));
                complaint.setSubject(resultSet.getString("subject"));
                complaint.setDescription(resultSet.getString("description"));
                complaint.setCategory(resultSet.getString("category"));
                complaint.setDepartment(resultSet.getString("department"));
                complaint.setStatus(resultSet.getString("status"));
                complaint.setCreated_at(resultSet.getString("created_at"));
                complaint.setUpdated_at(resultSet.getString("updated_at"));

                complaintDTO.add(complaint);
            }
        }
        return complaintDTO;
    }

    public boolean deleteComplaints(String complaintId) {
        String sql = "DELETE FROM complaint WHERE complaint_id = ?";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, complaintId);
            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting complaint with ID: " + complaintId, e);
        }
    }

    public boolean updateComplaint(ComplaintDTO complaintDTO) {
        String sql = "UPDATE complaint SET subject = ?, description = ?, category = ?, department = ?, status = ? " +
                     "WHERE complaint_id = ?";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, complaintDTO.getSubject());
            preparedStatement.setString(2, complaintDTO.getDescription());
            preparedStatement.setString(3, complaintDTO.getCategory());
            preparedStatement.setString(4, complaintDTO.getDepartment());
            preparedStatement.setString(5, complaintDTO.getStatus());
            preparedStatement.setString(6, complaintDTO.getComplaint_id());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error updating complaint with ID: " + complaintDTO.getComplaint_id(), e);
        }
    }
}
