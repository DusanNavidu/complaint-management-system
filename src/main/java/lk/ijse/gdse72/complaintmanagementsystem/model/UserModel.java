package lk.ijse.gdse72.complaintmanagementsystem.model;

import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.util.DatabaseConfig;

import java.sql.Connection;

public class UserModel {
    public static String generateUserId() {
        return "USER_" + java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    public boolean saveUser(UserDTO userDTO) {
        String sql = "INSERT INTO users (user_id, full_name, birthday, nic_number, username, email, password, role, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
             var preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, userDTO.getUser_id());
            preparedStatement.setString(2, userDTO.getFull_name());
            preparedStatement.setDate(3, java.sql.Date.valueOf(userDTO.getBirthday()));
            preparedStatement.setString(4, userDTO.getNic_number());
            preparedStatement.setString(5, userDTO.getUsername());
            preparedStatement.setString(6, userDTO.getEmail());
            preparedStatement.setString(7, userDTO.getPassword());
            preparedStatement.setString(8, userDTO.getRole());

            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}