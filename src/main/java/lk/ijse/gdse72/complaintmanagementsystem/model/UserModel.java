package lk.ijse.gdse72.complaintmanagementsystem.model;

import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.util.DatabaseConfig;

import java.sql.*;

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

    public UserDTO userLogin(String username, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE LOWER(username) = LOWER(?)";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String dbPassword = resultSet.getString("password");

                System.out.println("Debug: Retrieved password from DB: " + dbPassword);
                System.out.println("Debug: Provided password: " + password);
                if (dbPassword.equals(password)) {
                    return extractUserFromResultSet(resultSet);
                }
            }
        }
        return null;
    }



    private UserDTO extractUserFromResultSet(ResultSet resultSet) throws SQLException {
        UserDTO userDTO = new UserDTO();
        userDTO.setUser_id(resultSet.getString("user_id"));
        userDTO.setFull_name(resultSet.getString("full_name"));
        Date birthdayDate = resultSet.getDate("birthday");
        if (birthdayDate != null) {
            userDTO.setBirthday(String.valueOf(birthdayDate.toLocalDate()));
        }
        userDTO.setNic_number(resultSet.getString("nic_number"));
        userDTO.setUsername(resultSet.getString("username"));
        userDTO.setEmail(resultSet.getString("email"));
        userDTO.setPassword(null);  // do not expose password
        userDTO.setRole(resultSet.getString("role"));
        Timestamp createdAt = resultSet.getTimestamp("created_at");
        if (createdAt != null) {
            userDTO.setCreated_at(createdAt.toLocalDateTime());
        }
        return userDTO;
    }

}