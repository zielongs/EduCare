/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   : 
Date        : 02 January 2026
Description : 
Provides mock attendance data for testing and development.
- Each record contains student name, date, check-in/out time, and status (present/absent)
- Used for displaying attendance in AdminAttendanceScreen
--------------------------------------------------*/

import '../models/attendance.dart';

/// Current date used to assign to mock data
final DateTime today = DateTime.now();

/// List of mock attendance records
final List<Attendance> mockAttendanceList = [
  Attendance(
    studentName: "Ariana Rahman",
    date: DateTime(today.year, today.month, today.day),
    checkIn: "08:34 AM",
    checkOut: "11:01 AM",
    status: AttendanceStatus.present,
  ),
  Attendance(
    studentName: "Adrian Lim",
    date: DateTime(today.year, today.month, today.day),
    status: AttendanceStatus.absent,
  ),
  Attendance(
    studentName: "Bella Swan",
    date: DateTime(today.year, today.month, today.day),
    checkIn: "08:06 AM",
    checkOut: "11:00 AM",
    status: AttendanceStatus.present,
  ),
  Attendance(
    studentName: "Charlie Tan",
    date: DateTime(today.year, today.month, today.day),
    checkIn: "08:15 AM",
    checkOut: "11:05 AM",
    status: AttendanceStatus.present,
  ),
  Attendance(
    studentName: "Diana Lee",
    date: DateTime(today.year, today.month, today.day),
    status: AttendanceStatus.absent,
  ),
];
