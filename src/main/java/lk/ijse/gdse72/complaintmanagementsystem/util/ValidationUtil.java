package lk.ijse.gdse72.complaintmanagementsystem.util;

import java.time.LocalDate;

public class ValidationUtil {
    public static boolean isValidPassword(String password) {
        return password != null && password.matches("\\d{6,10}");
    }

    public static boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && name.length() >= 3 && name.length() <= 50;
    }
    public static boolean isValidBirthday(String birthday) {
        return birthday != null && !birthday.trim().isEmpty();
    }
    public static boolean isValidNIC(String nic) {
        if (nic == null || nic.trim().isEmpty()) return false;
        return nic.matches("^[0-9]{9}[vVxX]$") || nic.matches("^[0-9]{12}$");
    }
//    public static boolean doesNICBirthdayMatch(String nic, String birthdayInput) {
//        LocalDate birthdayFromNIC = extractBirthdayFromNIC(nic);
//        LocalDate birthdayFromForm;
//
//        try {
//            birthdayFromForm = LocalDate.parse(birthdayInput); // yyyy-MM-dd
//        } catch (Exception e) {
//            return false;
//        }
//
//        return birthdayFromNIC != null && birthdayFromNIC.equals(birthdayFromForm);
//    }
//
//    public static LocalDate extractBirthdayFromNIC(String nic) {
//        int year;
//        int dayOfYear;
//
//        try {
//            if (nic.matches("\\d{9}[vVxX]")) {
//                year = 1900 + Integer.parseInt(nic.substring(0, 2));
//                dayOfYear = Integer.parseInt(nic.substring(2, 5));
//            } else if (nic.matches("\\d{12}")) {
//                year = Integer.parseInt(nic.substring(0, 4));
//                dayOfYear = Integer.parseInt(nic.substring(4, 7));
//            } else {
//                return null;
//            }
//
//            if (dayOfYear > 866 || dayOfYear < 1) return null; // avoid invalid range
//
//            if (dayOfYear > 500) {
//                dayOfYear -= 500; // female NIC
//            }
//
//            // validate if dayOfYear fits in that year
//            return LocalDate.ofYearDay(year, dayOfYear);
//        } catch (Exception e) {
//            return null;
//        }
//    }
    public static boolean isValidUsername(String username) {
        return username != null && !username.trim().isEmpty() && username.length() >= 3 && username.length() <= 20 &&
               username.matches("^[a-zA-Z0-9_]+$");
    }
    public static boolean isValidEmail(String email) {
        return email != null && !email.trim().isEmpty() &&
               email.matches("^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$");
    }
    public static boolean isValidSubject(String subject) {
        return subject != null && subject.matches("[A-Za-z0-9 .,-]{3,}");
    }

    public static boolean isValidDescription(String description) {
        return description != null && description.length() > 5;
    }

    public static boolean isValidRemarks(String remarks) {
        return remarks != null && remarks.length() >= 5;
    }

    public static boolean isValidCategory(String category) {
        return category != null && !category.isBlank();
    }

    public static boolean isValidDepartment(String department) {
        return department != null && !department.isBlank();
    }

    public static boolean isValidStatus(String status) {
        return status != null && (status.equals("PENDING") || status.equals("IN_PROGRESS") || status.equals("RESOLVED") || status.equals("REJECTED"));
    }
}
