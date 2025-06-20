package lk.ijse.gdse72.complaintmanagementsystem.model;

import lk.ijse.gdse72.complaintmanagementsystem.dto.UserDTO;
import lk.ijse.gdse72.complaintmanagementsystem.util.DatabaseConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    public List<UserDTO> getAllUsers() throws SQLException {
        List<UserDTO> userList = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection connection = DatabaseConfig.getDataSource().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                UserDTO userDTO = new UserDTO();

                userDTO.setUser_id(resultSet.getString("user_id"));
                userDTO.setFull_name(resultSet.getString("full_name"));
                userDTO.setBirthday(resultSet.getString("birthday"));
                userDTO.setNic_number(resultSet.getString("nic_number"));
                userDTO.setUsername(resultSet.getString("username"));
                userDTO.setEmail(resultSet.getString("email"));
                userDTO.setPassword(null);  // do not expose password
                userDTO.setRole(resultSet.getString("role"));
                Timestamp createdAt = resultSet.getTimestamp("created_at");

                userList.add(userDTO);
            }
        }
        return userList;
    }

    public boolean deleteUser(String userId) throws SQLException {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateUser(UserDTO user) throws SQLException {
        String sql = "UPDATE users SET full_name=?, birthday=?, nic_number=?, email=?, role=? WHERE user_id=?";
        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFull_name());
            ps.setDate(2, java.sql.Date.valueOf(user.getBirthday()));
            ps.setString(3, user.getNic_number());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getUser_id());
            return ps.executeUpdate() > 0;
        }
    }

    public UserDTO getUserById(String userId) throws SQLException {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DatabaseConfig.getDataSource().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        }
        return null;
    }

}