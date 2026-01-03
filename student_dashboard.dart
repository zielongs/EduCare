/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : 
Tested by   : 
Date        : 28 December 2025
Description : 
Student Dashboard Screen for the EduCare App.
- Displays student overview information
- Shows upcoming classes, notifications, and statistics
- Provides quick access menu for attendance and replacement
- Includes bottom navigation for student modules
--------------------------------------------------*/

import 'package:flutter/material.dart';
// import 'student_schedule.dart';      // Attendance & schedule screen
// import 'student_profile.dart';       // Student profile screen
// import 'student_replacement.dart';   // Replacement request screen

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* ---------------- Bottom Navigation Bar ---------------- */
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Home tab
        // Navigation handling (COMMENTED for future use)
        onTap: (index) {
          if (index == 0) return; // Stay on Home

          switch (index) {
            /* 
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentScheduleScreen(),
                ),
              );
              break;

            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentProfileScreen(),
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
            icon: Icon(Icons.calendar_today_outlined),
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

      /* ---------------- Main Body ---------------- */
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Gradient background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF53E1E1), Color(0xFF1A237E)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                /* ---------------- Top Bar ---------------- */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Icon(Icons.grid_view_rounded, color: Colors.white),
                    ),
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://tinyurl.com/student-avatar-demo',
                      ), // Replace with local asset later
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /* ---------------- Greeting ---------------- */
                const Text(
                  'Good morning, James ☁️',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                /* ---------------- Upcoming Class ---------------- */
                const Text(
                  'Upcoming Class',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                _buildUpcomingClassCard(),

                const SizedBox(height: 20),

                /* ---------------- Notifications ---------------- */
                const Text(
                  'Notifications',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                _buildNotificationTile(),

                const SizedBox(height: 20),

                /* ---------------- Statistics ---------------- */
                const Text(
                  'Statistics',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                _buildStatisticsCard(),

                const SizedBox(height: 20),

                /* ---------------- Quick Menu ---------------- */
                const Text(
                  'Quick Menu',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildQuickMenuButton(
                      "Manage\nAttendance",
                      const Color(0xFFB2EBF2),
                      /* onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StudentScheduleScreen(),
                          ),
                        );
                      }, */
                    ),
                    const SizedBox(width: 15),
                    _buildQuickMenuButton(
                      "Manage\nReplacement",
                      const Color(0xFF81D4FA),
                      /* onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StudentReplacementScreen(),
                          ),
                        );
                      }, */
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* ---------------- Upcoming Class Card ---------------- */
  Widget _buildUpcomingClassCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F5FE).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saturday | 29 November 2025 |',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 10),
          const Text(
            'Mathematics (Physical)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'English (Physical)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'Bahasa Melayu (Online)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF81D4FA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'View Details',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ---------------- Notification Tile ---------------- */
  Widget _buildNotificationTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFB2EBF2).withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Icons.notifications_active, color: Colors.orangeAccent),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notices from admin',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '30 minutes ago',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_circle_right_outlined),
        ],
      ),
    );
  }

  /* ---------------- Statistics Card ---------------- */
  Widget _buildStatisticsCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFB2EBF2).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _progressBarRow("Monthly Attendance", 0.6, "60%"),
          const SizedBox(height: 15),
          _progressBarRow("Today class completion", 0.33, "1/3"),
        ],
      ),
    );
  }

  /* ---------------- Progress Bar Row ---------------- */
  Widget _progressBarRow(String label, double value, String trailingText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 16),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.black12,
          color: Colors.greenAccent,
          minHeight: 8,
          borderRadius: BorderRadius.circular(5),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(trailingText, style: const TextStyle(fontSize: 10)),
        ),
      ],
    );
  }

  /* ---------------- Quick Menu Button ---------------- */
  Widget _buildQuickMenuButton(String label, Color color) {
    return Container(
      height: 70,
      width: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
      ),
    );
  }
}
