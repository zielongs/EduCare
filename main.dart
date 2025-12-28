import 'package:flutter/material.dart';
import 'tutorlogin.dart';

void main() {
  runApp(const EduCareApp());
}

class EduCareApp extends StatelessWidget {
  const EduCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduCare App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/',

      routes: {
        '/': (context) => const TutorLogin(),
      },
    );
  }
}
