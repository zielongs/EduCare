import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const EduCareApp());
}

class EduCareApp extends StatelessWidget {
  const EduCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduCare',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(), // homepage.dart
    );
  }
}
