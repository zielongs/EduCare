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
import 'screen_launcher.dart';
import 'home_page.dart';
import 'login_user_roles.dart';

// Admin Screens
import 'admin_login.dart';
import 'admin_menu.dart';
import 'admin_dashboard.dart';
import 'admin_schedule_screen.dart';
import 'admin_attendance_screen.dart';

// Tutor Screens
import 'tutor_login.dart';
import 'tutor_menu.dart';
import 'tutor_profile.dart';
import 'update_tutor_profile.dart';
import 'tutor_availability_screen.dart';

// Student Screens
import 'student_login.dart';
import 'student_register.dart';
import 'student_menu.dart';
import 'student_dashboard.dart';
import 'student_profile.dart';
import 'update_student_profile.dart';

// Data
import 'data/mock_tutors.dart';

void main() {
  runApp(const EduCareApp());
}

class EduCareApp extends StatelessWidget {
  const EduCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduCare System',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),

      // Change this if you want HomePage instead
      initialRoute: '/',

      routes: {
        // Core Routes
        '/': (context) => const ScreenLauncher(),
        '/home': (context) => const HomePage(),
        '/roles': (context) => const LoginUserRolesScreen(),

        // Admin Routes
        '/admin': (context) => const AdminLoginScreen(),
        '/admin_menu': (context) => const AdminMenuScreen(),
        '/admin_dashboard': (context) => const AdminDashboardScreen(),
        '/admin-schedule': (context) => const AdminScheduleScreen(),
        '/admin-attendance': (context) => const AdminAttendanceScreen(),

        // Tutor Routes
        '/tutor': (context) => const TutorLoginScreen(),
        '/tutor_menu': (context) => const TutorMenuScreen(),
        '/tutor_profile': (context) => const TutorProfileScreen(),
        '/update_tutor_profile': (context) =>
            const UpdateTutorProfileScreen(),
        '/tutor-availability': (context) =>
            TutorAvailabilityScreen(tutors: mockTutors),

        // Student Routes
        '/student': (context) => const StudentLoginScreen(),
        '/register': (context) => const StudentRegisterScreen(),
        '/student_menu': (context) => const StudentMenuScreen(),
        '/student_dashboard': (context) => const StudentDashboardScreen(),
        '/student_profile': (context) => const StudentProfileScreen(),
        '/update_student_profile': (context) =>
            const UpdateStudentProfileScreen(),
      },
    );
  }
}
