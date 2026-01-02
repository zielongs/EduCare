/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   : 
Date        : 02 January 2026
Description : 
Main entry point for the Educare App.
- Initializes the app
- Sets the home screen to ScreenLauncher
- Defines named routes for admin and tutor screens
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'package:tutor/screen_launcher.dart';
import 'package:tutor/admin_schedule_screen.dart';
import 'package:tutor/admin_attendance_screen.dart';
import 'package:tutor/tutor_availability_screen.dart';
import 'package:tutor/data/mock_tutors.dart';

/// Entry point of the app
void main() {
  runApp(const MyApp());
}

/// Root widget of the Educare App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'Educare App', // App title
      home: const ScreenLauncher(), // Initial screen
      // Named routes for navigation using SharedBottomNav
      routes: {
        '/admin-schedule': (context) => const AdminScheduleScreen(),
        '/admin-attendance': (context) => const AdminAttendanceScreen(),
        '/tutor-availability': (context) =>
            TutorAvailabilityScreen(tutors: mockTutors),
        // Add more routes as needed
      },
    );
  }
}
