package lk.ijse.gdse72.complaintmanagementsystem.dto;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class UserDTO {
    private String user_id;
    private String full_name;
    private String birthday;
    private String nic_number;
    private String username;
    private String email;
    private String password;
    private String role;
    private LocalDateTime created_at;

    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(role);
    }

    public boolean isEmployee() {
        return "EMPLOYEE".equalsIgnoreCase(role);
    }
}
