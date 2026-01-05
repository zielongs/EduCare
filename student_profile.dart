/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : Noraziela Binti Jepsin
Tested by   : 
Date        : 28 December 2025
Description : 
Student Profile Screen for the EduCare App.
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'update_student_profile.dart';
import 'student_dashboard.dart';
import 'student_overview.dart';
import 'student_notifications.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  bool isBiometricEnabled = false;

  String firstName = 'STUDENT';
  String lastName = '';
  String username = '@student123';
  String email = 'student123@educare.my';
  String phone = '';
  String gender = '';
  String dateOfBirth = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        onTap: (index) {
          if (index == 3) return;
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentDashboardScreen(),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentAttendanceOverviewScreen(),
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const StudentNotifications()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),

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
                        'PROFILE',
                        style: TextStyle(
                          fontSize: 20,
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

            // User card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFB2EBF2).withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 30),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lastName.isEmpty ? firstName : '$firstName $lastName',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          username,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpdateStudentProfileScreen(
                            firstName: firstName,
                            lastName: lastName,
                            phone: phone,
                            gender: gender,
                            dateOfBirth: dateOfBirth,
                          ),
                        ),
                      );

                      if (result is Map<String, String>) {
                        setState(() {
                          firstName = result['firstName'] ?? firstName;
                          lastName = result['lastName'] ?? lastName;
                          phone = result['phone'] ?? phone;
                          gender = result['gender'] ?? gender;
                          dateOfBirth = result['dateOfBirth'] ?? dateOfBirth;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Settings
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _tile(
                        Icons.person_outline,
                        "My Account",
                        subtitle: "Make changes to your account",
                        warning: true,
                      ),
                      _tile(
                        Icons.person_add_alt,
                        "Saved Beneficiary",
                        subtitle: "Manage your saved account",
                      ),
                      _tile(
                        Icons.lock_outline,
                        "Face ID / Touch ID",
                        isSwitch: true,
                      ),
                      _tile(
                        Icons.verified_user_outlined,
                        "Two-Factor Authentication",
                        subtitle: "Further secure your account",
                      ),
                      _tile(
                        Icons.logout_outlined,
                        "Log out",
                        subtitle: "Log out of your account",
                        onTap: () => _showLogoutDialog(context),
                      ),

                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      _tile(Icons.notifications_none, "Help & Support"),
                      _tile(Icons.favorite_border, "About App"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title, {
    String? subtitle,
    bool warning = false,
    bool isSwitch = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: isSwitch ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF3E5F5),
              child: Icon(icon, color: Colors.indigo),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                    ),
                ],
              ),
            ),
            if (warning)
              const Icon(Icons.warning_amber_rounded, color: Colors.red),
            if (isSwitch)
              Switch(
                value: isBiometricEnabled,
                onChanged: (value) {
                  setState(() => isBiometricEnabled = value);
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          value
                              ? 'Biometric authentication enabled'
                              : 'Biometric authentication disabled',
                        ),
                      ),
                    );
                },
              ),
            if (!isSwitch)
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
