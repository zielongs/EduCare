/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 02 January 2026
Description : 
Main entry point for the Educare App.
- Initializes the app
- Sets the home screen to ScreenLauncher or HomePage
- Defines named routes for admin, tutor, and student screens
--------------------------------------------------*/

import 'package:flutter/material.dart';

// Core Screens
import 'package:tutor/screen_launcher.dart';
import 'package:tutor/home_page.dart';
import 'package:tutor/login_user_roles.dart';

// Admin Screens
import 'package:tutor/admin_login.dart';
import 'package:tutor/admin_menu.dart';
import 'package:tutor/admin_dashboard.dart';
import 'package:tutor/admin_schedule_screen.dart';
import 'package:tutor/admin_attendance_screen.dart';

// Tutor Screens
import 'package:tutor/tutor_login.dart';
import 'package:tutor/tutor_menu.dart';
import 'package:tutor/tutor_profile.dart';
import 'package:tutor/update_tutor_profile.dart';
import 'package:tutor/tutor_availability_screen.dart';

// Student Screens
import 'package:tutor/student_login.dart';
import 'package:tutor/student_register.dart';
import 'package:tutor/student_menu.dart';
import 'package:tutor/student_dashboard.dart';

// Data
import 'package:tutor/data/mock_tutors.dart';

/// Entry point of the app
void main() {
  runApp(const EduCareApp());
}

/// Root widget of the Educare App
class EduCareApp extends StatelessWidget {
  const EduCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'EduCare System', // App title
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),

      // Initial screen - change this to your preferred starting screen
      // Options: ScreenLauncher(), HomePage(), StudentDashboard(), etc.
      initialRoute: '/',
      
      // Named routes for navigation
      routes: {
        // Core Routes
        '/': (context) => const ScreenLauncher(), // or HomePage()
        '/home': (context) => const HomePage(),
        '/roles': (context) => const LoginUserRolesScreen(),

        // Admin Routes
        '/admin': (context) => const AdminLoginScreen(),
        '/admin_menu': (context) => const AdminMenuScreen(),
        '/admin_dashboard': (context) => const AdminDashboard(),
        '/admin-schedule': (context) => const AdminScheduleScreen(),
        '/admin-attendance': (context) => const AdminAttendanceScreen(),

        // Tutor Routes
        '/tutor': (context) => const TutorLoginScreen(),
        '/tutor_menu': (context) => const TutorMenuScreen(),
        '/tutor_profile': (context) => const TutorProfileScreen(),
        '/update_tutor_profile': (context) => const UpdateTutorProfileScreen(),
        '/tutor-availability': (context) =>
            TutorAvailabilityScreen(tutors: mockTutors),

        // Student Routes
        '/student': (context) => const StudentLoginScreen(),
        '/register': (context) => const StudentRegisterScreen(),
        '/student_menu': (context) => const StudentMenuScreen(),
        '/student_dashboard': (context) => const StudentDashboard(),
      },
    );
  }
}
