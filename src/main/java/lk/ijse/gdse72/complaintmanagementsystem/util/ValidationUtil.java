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
//    public static LocalDate extractBirthdayFromNIC(String nic) {
//        int year;
//        int dayOfYear;
//
//        try {
//            if (nic.matches("\\d{9}[VXvx]")) {
//                year = 1900 + Integer.parseInt(nic.substring(0, 2));
//                dayOfYear = Integer.parseInt(nic.substring(2, 5));
//            } else if (nic.matches("\\d{12}")) {
//                year = Integer.parseInt(nic.substring(0, 4));
//                dayOfYear = Integer.parseInt(nic.substring(4, 7));
//            } else {
//                return null;
//            }
//
//            if (dayOfYear > 500) {
//                dayOfYear -= 500; // Female adjustment
//            }
//
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
}
