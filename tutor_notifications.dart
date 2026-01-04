/*--------------------------------------------------
Author      : Nur 'Aainaa Hamraa binti Hamka
Updated by  : 
Tested by   : 
Date        : 29 December 2025
Description : 
Tutor Notifications Screen for the EduCare App.
- Displays notifications sent by admin
- Includes class reminders and replacement class requests
- Allows navigation to replacement class confirmation
- Includes bottom navigation for tutor modules
--------------------------------------------------*/
import 'package:flutter/material.dart';
import 'tutor_replacement_class.dart';

class TutorNotifications extends StatefulWidget {
  const TutorNotifications({super.key});

  @override
  State<TutorNotifications> createState() => _TutorNotificationsState();
}

class _TutorNotificationsState extends State<TutorNotifications> {
  int _currentIndex = 2;

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
                          '/tutor-dashboard',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'NOTIFICATIONS',
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    /* Replacement Notification */
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const TutorReplacementClass(),
                          ),
                        );
                      },
                      child: _notificationCard(
                        icon: Icons.notifications_active,
                        iconColor: Colors.orange,
                        title: 'Replacement Class',
                        message:
                            'Admin has assigned a replacement class. Please confirm.',
                        time: '9:41 AM',
                        highlight: true,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _notificationCard(
                      icon: Icons.class_,
                      iconColor: Colors.blue,
                      title: 'Class Reminder',
                      message:
                          'You have class with student James at 10AM tomorrow.',
                      time: '10:00 AM',
                    ),

                    const SizedBox(height: 15),

                    _notificationCard(
                      icon: Icons.class_,
                      iconColor: Colors.blue,
                      title: 'Class Reminder',
                      message:
                          'You have class with student Felyana at 12PM tomorrow.',
                      time: '10:00 AM',
                    ),

                    const SizedBox(height: 25),

                    /* ---------------- END OF NOTIFICATIONS ---------------- */
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
            ],
          ),
        ),
      ),

      /* ---------------- BOTTOM NAV ---------------- */
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == _currentIndex) return;

          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(
                  context, '/tutor-dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(
                  context, '/tutor-availability');
              break;
            case 2:
              return;
            case 3:
              Navigator.pushReplacementNamed(
                  context, '/tutor-profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Availability',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _notificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    bool highlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: highlight
            ? const Color(0xFFB2EBF2)
            : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
