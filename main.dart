import 'package:flutter/material.dart';
import 'tutorlogin.dart';
import 'tutormenu.dart';
import 'adminmenu.dart';
import 'studentregister.dart';

void main() {
  runApp(const EduCareApp());
}

class EduCareApp extends StatelessWidget {
  const EduCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/register',
      routes: {
        '/': (context) => const TutorLoginScreen(),
        '/tutor_menu': (context) => const TutorMenuScreen(),
        '/admin_menu': (context) => const AdminMenuScreen(),
        '/register': (context) => const StudentRegisterScreen(),
      },
    );
  }
}
