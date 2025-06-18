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
        String sql = "INSERT INTO complaint (complaint_id, user_id, subject, description, category, department, status, remarks) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
            var preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, complaintDTO.getComplaint_id());
            preparedStatement.setString(2, complaintDTO.getUser_id());
            preparedStatement.setString(3, complaintDTO.getSubject());
            preparedStatement.setString(4, complaintDTO.getDescription());
            preparedStatement.setString(5, complaintDTO.getCategory());
            preparedStatement.setString(6, complaintDTO.getDepartment());
            preparedStatement.setString(7, complaintDTO.getStatus());
            preparedStatement.setString(8, complaintDTO.getRemarks());

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
                complaint.setRemarks(resultSet.getString("remarks"));
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

    public boolean updateComplaint(ComplaintDTO complaint) throws SQLException {
        String sql = "UPDATE complaint SET subject=?, description=?, category=?, department=?, status=?, remarks=?, updated_at=NOW() WHERE complaint_id=?";
        try (Connection con = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, complaint.getSubject());
            ps.setString(2, complaint.getDescription());
            ps.setString(3, complaint.getCategory());
            ps.setString(4, complaint.getDepartment());
            ps.setString(5, complaint.getStatus());
            ps.setString(6, complaint.getRemarks());
            ps.setString(7, complaint.getComplaint_id());

            return ps.executeUpdate() > 0;
        }
    }


    public ComplaintDTO getComplaintById(String complaintId) throws SQLException {
        String sql = "SELECT * FROM complaint WHERE complaint_id = ?";
        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, complaintId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ComplaintDTO dto = new ComplaintDTO();
                dto.setComplaint_id(rs.getString("complaint_id"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setSubject(rs.getString("subject"));
                dto.setDescription(rs.getString("description"));
                dto.setCategory(rs.getString("category"));
                dto.setDepartment(rs.getString("department"));
                dto.setStatus(rs.getString("status"));
                dto.setRemarks(rs.getString("remarks"));
                dto.setCreated_at(rs.getString("created_at"));
                dto.setUpdated_at(rs.getString("updated_at"));
                return dto;
            }
        }
        return null;
    }
}
