/*--------------------------------------------------
Author      : Nur 'Aainaa Hamraa binti Hamka
Updated by  : 
Tested by   : 
Date        : 2 January 2026
Description : 
Student Notifications Screen for the EduCare App.
- Displays notifications received from admin
- Includes attendance reminders and class notifications
- Provides bottom navigation for student modules
--------------------------------------------------*/

import 'package:flutter/material.dart';

class StudentNotifications extends StatefulWidget {
  const StudentNotifications({super.key});

  @override
  State<StudentNotifications> createState() => _StudentNotificationsState();
}

class _StudentNotificationsState extends State<StudentNotifications> {
  final int _currentIndex = 2; // Notifications tab

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
        child: SafeArea(
          child: Column(
            children: [
              /* ---------------- HEADER ---------------- */
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/student-dashboard',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              /* ---------------- NOTIFICATION LIST ---------------- */
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      _notificationCard(
                        icon: Icons.error_outline,
                        iconBg: Colors.redAccent,
                        title: 'Confirm Class',
                        message: 'Confirm your attendance for tomorrow class!',
                        time: 'Yesterday',
                      ),
                      const SizedBox(height: 15),
                      _notificationCard(
                        icon: Icons.check_circle_outline,
                        iconBg: Colors.green,
                        title: 'Attendance',
                        message:
                            'You have successfully confirmed your attendance.',
                        time: 'Yesterday',
                      ),
                      const SizedBox(height: 15),
                      _notificationCard(
                        icon: Icons.event_note,
                        iconBg: Colors.blue,
                        title: 'Class Reminder',
                        message:
                            'You have Physical Mathematics class in 1 hour.',
                        time: '8:00 AM',
                      ),
                      const SizedBox(height: 25),

                      /* ---------------- END TEXT ---------------- */
                      Column(
                        children: const [
                          Divider(
                            thickness: 1,
                            color: Colors.black26,
                            indent: 40,
                            endIndent: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'END OF NOTIFICATIONS',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black45,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /* ---------------- BOTTOM NAV (STUDENT) ---------------- */
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == _currentIndex) return;

          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/student-dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/student-attendance');
              break;
            case 2:
              return; // already here
            case 3:
              Navigator.pushReplacementNamed(context, '/student-profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  /* ---------------- NOTIFICATION CARD ---------------- */
  Widget _notificationCard({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String message,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBg,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
