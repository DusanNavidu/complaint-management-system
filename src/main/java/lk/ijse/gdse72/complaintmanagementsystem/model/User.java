package lk.ijse.gdse72.complaintmanagementsystem.model;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class User {
    private String userId;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String role;         // 'EMPLOYEE' or 'ADMIN'
    private boolean isActive;

}
