/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : 
Tested by   : 
Date        : 28 December 2025
Description : 
Student Menu Screen for the EduCare App.
- Provides quick access to Student features
- Gradient background consistent with EduCare branding
- Each menu button navigates to the respective screen
- Logout clears the navigation stack and returns to the login/home screen
--------------------------------------------------*/

import 'package:flutter/material.dart';

class StudentMenuScreen extends StatelessWidget {
  const StudentMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF53E1E1), Color(0xFF1A237E)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'MENU',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Senarai Menu Pelajar
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                children: [
                  _menuButton(context, "PROFILE"),
                  _menuButton(context, "DASHBOARD"),
                  _menuButton(context, "VIEW SCHEDULE"),
                  _menuButton(context, "MANAGE ATTENDANCE"),
                  _menuButton(context, "REPLACEMENT REQUEST"),
                  _menuButton(context, "NOTIFICATIONS"),
                  _menuButton(context, "LOGOUT"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFD1F2F9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_circle_right_outlined),
        onTap: () {
          switch (title) {
            case "PROFILE":
              Navigator.pushNamed(context, '/student_profile');
              break;
            case "DASHBOARD":
              Navigator.pushNamed(context, '/student_dashboard');
              break;
            case "VIEW SCHEDULE":
              Navigator.pushNamed(context, '/student_schedule');
              break;
            case "MANAGE ATTENDANCE":
              Navigator.pushNamed(context, '/student_overview');
              break;
            case "REPLACEMENT REQUEST":
              Navigator.pushNamed(context, '/student_replacement');
              break;
            case "NOTIFICATIONS":
              Navigator.pushNamed(context, '/student_notifications');
              break;
            case "LOGOUT":
              // Clears navigation history and returns to Home Page
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              break;
          }
        },
      ),
    );
  }
}
