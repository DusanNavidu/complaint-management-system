package lk.ijse.gdse72.complaintmanagementsystem.dto;
import lombok.*;
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class ComplaintDTO {
    private String complaint_id;
    private String user_id;
    private String subject;
    private String description;
    private String category;
    private String department;
    private String status;
    private String created_at;
    private String updated_at;

    public boolean isPending() {
        return "PENDING".equalsIgnoreCase(status);
    }
    public boolean isInProgress() {
        return "IN_PROGRESS".equalsIgnoreCase(status);
    }
    public boolean isResolved() {
        return "RESOLVED".equalsIgnoreCase(status);
    }
    public boolean isRejected() {
        return "REJECTED".equalsIgnoreCase(status);
    }
}
