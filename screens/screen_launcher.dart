/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   : 
Date        : 02 January 2026
Description : 
This screen provides navigation buttons to launch
different admin/tutor screens for testing or demo
purposes: Tutor Availability, Admin Schedule, and
Admin Attendance.
--------------------------------------------------*/
import 'package:flutter/material.dart';
import 'package:tutor/data/mock_tutors.dart';
import 'admin_schedule_screen.dart';
import 'tutor_availability_screen.dart';
import 'admin_attendance_screen.dart';

/// Launcher screen to navigate to other screens
class ScreenLauncher extends StatelessWidget {
  const ScreenLauncher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Screen Launcher")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TutorAvailabilityScreen(tutors: mockTutors),
                ),
              );
            },
            child: const Text("Tutor Availability Screen"),
          ),
          const SizedBox(height: 12), // Space between buttons
          // Button to go to Admin Schedule Screen
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminScheduleScreen()),
              );
            },
            child: const Text("Admin Schedule Screen"),
          ),
          const SizedBox(height: 12),

          // Button to go to Admin Attendance Screen
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminAttendanceScreen(),
                ),
              );
            },
            child: const Text("Admin Attendance Screen"),
          ),
        ],
      ),
    );
  }
}
