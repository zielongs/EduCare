import 'package:flutter/material.dart';

import 'tutorlogin.dart';
import 'tutormenu.dart';
import 'adminmenu.dart';
import 'studentregister.dart';
import 'studentmenu.dart';
import 'admindashboard.dart';
import 'studentdashboard.dart';
import 'profile.dart';
import 'updateprofile.dart';

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
      theme: ThemeData(useMaterial3: true),


      initialRoute: '/update_profile',

      routes: {
        '/': (context) => const TutorLoginScreen(),
        '/tutor_menu': (context) => const TutorMenuScreen(),
        '/admin_menu': (context) => const AdminMenuScreen(),
        '/admin_dashboard': (context) => const AdminDashboard(),
        '/register': (context) => const StudentRegisterScreen(),
        '/student_menu': (context) => const StudentMenuScreen(),
        '/student_dashboard': (context) => const StudentDashboard(),
        '/profile': (context) => const ProfileScreen(),
        '/update_profile': (context) => const UpdateProfileScreen(),
      },
    );
  }
}
