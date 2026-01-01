/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   : 
Date        : 02 January 2026
Description : 
Defines the Attendance model and status enum for students.
- AttendanceStatus: Enum for present or absent
- Attendance class: Stores student name, date, check-in/out, and status
Used to track student attendance records throughout the app.
--------------------------------------------------*/

/// Enum representing attendance status
enum AttendanceStatus { present, absent }

/// Model class for a single attendance record
class Attendance {
  final String studentName; // Name of the student
  final DateTime date; // Date of the attendance
  final String? checkIn; // Check-in time (nullable)
  final String? checkOut; // Check-out time (nullable)
  final AttendanceStatus status; // Present or Absent

  Attendance({
    required this.studentName,
    required this.date,
    this.checkIn,
    this.checkOut,
    required this.status,
  });
}
