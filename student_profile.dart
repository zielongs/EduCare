/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : 
Tested by   : 
Date        : 28 December 2025
Description : 
Student Profile Screen for the EduCare App.
- Displays student profile information
- Allows editing of profile details
- Provides security and account settings
- Includes bottom navigation for student modules
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'update_student_profile.dart';
import 'student_dashboard.dart';
// import 'student_overview.dart';        // Attendance screen (future use)
// import 'student_notifications.dart';  // Notifications screen (future use)

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  // Toggle for biometric authentication
  bool isBiometricEnabled = false;

  // Student profile data
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
      /* ---------------- Bottom Navigation Bar ---------------- */
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        currentIndex: 3, // Profile tab
        // Handle navigation when a tab is tapped
        onTap: (index) {
          if (index == 3) return; // Stay on Profile screen

          switch (index) {
            case 0:
              // Navigate to Student Dashboard (Home)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentDashboardScreen(),
                ),
              );
              break;

            /* Future implementation
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentOverviewScreen(),
                ),
              );
              break;

            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentNotificationsScreen(),
                ),
              );
              break;
            */
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),

      /* ---------------- Main Body ---------------- */
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // App gradient background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF53E1E1), Color(0xFF1A237E)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),

            /* ---------------- Header ---------------- */
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

            /* ---------------- User Info Card ---------------- */
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
                      // Navigate to Update Student Profile screen
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateStudentProfileScreen(
                            firstName: firstName,
                            lastName: lastName,
                            phone: phone,
                            gender: gender,
                            dateOfBirth: dateOfBirth,
                          ),
                        ),
                      );

                      // Update profile data after returning
                      if (result != null && result is Map<String, String>) {
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

            /* ---------------- Settings Section ---------------- */
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
                      _buildSettingsTile(
                        Icons.person_outline,
                        "My Account",
                        subtitle: "Make changes to your account",
                        hasWarning: true,
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        Icons.person_add_alt,
                        "Saved Beneficiary",
                        subtitle: "Manage your saved account",
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        Icons.lock_outline,
                        "Face ID / Touch ID",
                        subtitle: "Manage your device security",
                        hasSwitch: true,
                        switchValue: isBiometricEnabled,
                        onSwitchChanged: (value) {
                          setState(() {
                            isBiometricEnabled = value;
                          });
                        },
                      ),
                      _buildSettingsTile(
                        Icons.verified_user_outlined,
                        "Two-Factor Authentication",
                        subtitle: "Further secure your account for safety",
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        Icons.logout_outlined,
                        "Log out",
                        subtitle: "Log out of your account",
                        onTap: () {
                          _showLogoutDialog(context);
                        },
                      ),
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

  /* ---------------- Reusable Settings Tile ---------------- */
  Widget _buildSettingsTile(
    IconData icon,
    String title, {
    String? subtitle,
    bool hasWarning = false,
    bool hasSwitch = false,
    bool switchValue = false,
    Function(bool)? onSwitchChanged,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: hasSwitch ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF3E5F5),
              child: Icon(icon, color: Colors.indigo, size: 20),
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
            if (hasWarning)
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 20,
              ),
            if (hasSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeColor: Colors.indigo,
              ),
            if (!hasSwitch)
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /* ---------------- Logout Confirmation Dialog ---------------- */
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
