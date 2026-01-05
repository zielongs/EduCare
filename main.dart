/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : Amir Lukaman, Noraziela Binti Jepsin
Tested by   : Amir Lukman, Noraziela Binti Jepsin
Date        : 02 January 2026
Description : 
Main entry point for the Educare App.
- Initializes the app
- Sets the home screen to ScreenLauncher or HomePage
- Defines named routes for admin, tutor, and student screens
--------------------------------------------------*/

import 'package:flutter/material.dart';

// Core Screens
import 'home_page.dart';
import 'login_user_roles.dart';

// Admin Screens
import 'admin_login.dart';
import 'admin_menu.dart';
import 'admin_home_screen.dart';
import 'admin_notifications.dart';
import 'admin_replacement.dart';
import 'admin_schedule_screen.dart';
import 'admin_attendance_screen.dart';
import 'admin_tutor_availability_screen.dart';

// Tutor Screens
import 'tutor_login.dart';
import 'tutor_menu.dart';
import 'tutor_profile.dart';
import 'update_tutor_profile.dart';
import 'tutor_dashboard.dart';
import 'tutor_view_schedule.dart';
import 'tutor_manage_availability.dart';
import 'tutor_notifications.dart';
import 'tutor_replacement_class.dart';

// Student Screens
import 'student_login.dart';
import 'student_register.dart';
import 'student_menu.dart';
import 'student_dashboard.dart';
import 'student_profile.dart';
import 'update_student_profile.dart';
import 'student_notifications.dart';
import 'student_schedule.dart';
import 'student_attendance.dart';
import 'student_overview.dart';
import 'student_replacement.dart';

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
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),

      // Initial screen
      initialRoute: '/',

      routes: {
        // Core Routes
        '/': (context) => const HomePage(),
        '/roles': (context) => const LoginUserRolesScreen(),

        // Admin Routes
        '/admin_login': (context) => const AdminLoginScreen(),
        '/admin_menu': (context) => const AdminMenuScreen(),
        '/admin_home': (context) => const AdminHomeScreen(),
        '/admin-notifications': (context) => const AdminNotifications(),
        '/admin_replacement': (context) => const AdminReplacementScreen(),
        '/admin_schedule': (context) => const AdminScheduleScreen(),
        '/admin_attendance': (context) => const AdminAttendanceScreen(),
        '/tutor_availability_screen': (context) =>
            TutorAvailabilityScreen(tutors: mockTutors),

        // Tutor Routes
        '/tutor_login': (context) => const TutorLoginScreen(),
        '/tutor_menu': (context) => const TutorMenuScreen(),
        '/tutor_profile': (context) => const TutorProfileScreen(),
        '/update_tutor_profile': (context) => const UpdateTutorProfileScreen(),
        '/tutor-dashboard': (context) => const TutorDashboard(),
        '/view-schedule': (context) => const TutorViewSchedule(),
        '/tutor-availability': (context) => const TutorManageAvailability(),
        '/tutor-notifications': (context) => const TutorNotifications(),
        '/tutor-replacement': (context) => const TutorReplacementClass(),

        // Student Routes
        '/student_login': (context) => const StudentLoginScreen(),
        '/student_register': (context) => const StudentRegisterScreen(),
        '/student_menu': (context) => const StudentMenuScreen(),

        // Dashboard
        '/student_dashboard': (context) => const StudentDashboardScreen(),
        '/profile': (context) => const StudentProfileScreen(),
        '/update_student_profile': (context) =>
            const UpdateStudentProfileScreen(),
        '/notification': (context) => const StudentNotifications(),
        '/student_schedule': (context) => const StudentScheduleScreen(),
        '/student_attendance': (context) => const StudentAttendanceScreen(),
        '/student_overview': (context) =>
            const StudentAttendanceOverviewScreen(),
        '/student_replacement': (context) => const StudentReplacementScreen(),
      },
    );
  }
}
