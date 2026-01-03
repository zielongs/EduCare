/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : 
Tested by   : 
Date        : 28 December 2025
Description : 
Admin Dashboard Screen for the EduCare App.
- Main landing page for admin users
- Displays urgent actions, schedule snapshot, and tutor availability
- Provides bottom navigation for Schedule, Attendance, and Tutors
- Navigation routes are prepared and commented for future integration
--------------------------------------------------*/

import 'package:flutter/material.dart';
// Import your screens here
// import 'admin_schedule_screen.dart';
// import 'admin_attendance_screen.dart';
// import 'tutor_availability_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      /* ---------------- Bottom Navigation Bar ---------------- */
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Home page
        selectedItemColor: const Color(0xFF3F51B5),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Navigation Logic (commented for now)
          if (index == 1) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const AdminScheduleScreen(),
            //   ),
            // );
          } else if (index == 2) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const AdminAttendanceScreen(),
            //   ),
            // );
          } else if (index == 3) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const TutorAvailabilityScreen(),
            //   ),
            // );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Tutors',
          ),
        ],
      ),

      /* ---------------- Main Body ---------------- */
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF80DEEA), Color(0xFF3949AB)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            _buildHeader(context),
            const SizedBox(height: 20),

            // Welcome message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome, Admin ☁️',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // Urgent actions
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Urgent Actions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            const SizedBox(height: 12),
            _buildActionCards(screenWidth),

            const SizedBox(height: 25),

            // Schedule snapshot
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Today's Schedule Snapshot",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(child: _buildScheduleList()),
          ],
        ),
      ),
    );
  }

  /* ---------------- Header Section ---------------- */
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF303F9F),
            child: Icon(Icons.grid_view_rounded, color: Colors.white, size: 20),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/admin_menu'),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withOpacity(0.4),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ---------------- Urgent Action Cards ---------------- */
  Widget _buildActionCards(double screenWidth) {
    return SizedBox(
      height: 145,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        children: [
          _actionCard(
            "1 Schedule\nConflicts Today",
            const Color(0xFFFF8A80),
            Icons.person_remove_outlined,
            screenWidth,
          ),
          _actionCard(
            "4 Attendance\nPending Review",
            const Color(0xFFFFD54F),
            Icons.access_time_rounded,
            screenWidth,
          ),
          _actionCard(
            "3/4 Tutors\nAvailable Today",
            const Color(0xFF66BB6A),
            Icons.fact_check_outlined,
            screenWidth,
          ),
        ],
      ),
    );
  }

  Widget _actionCard(
    String text,
    Color color,
    IconData icon,
    double screenWidth,
  ) {
    return Container(
      width: screenWidth * 0.33,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "View",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ---------------- Schedule List ---------------- */
  Widget _buildScheduleList() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          _scheduleItem(
            "Science (Online)",
            "8.00am - 11.00am",
            "Tutor Norlie",
            Colors.green,
            "On time",
            Icons.science_outlined,
          ),
          _scheduleItem(
            "Mathematics (Physical)",
            "9.00am - 11.00am",
            "Tutor Amir",
            Colors.red,
            "Tutor Unavailable",
            Icons.error_outline,
          ),
          _scheduleItem(
            "Malay (Online)",
            "1.00pm - 3.00pm",
            "Tutor Amir",
            Colors.green,
            "On time",
            Icons.translate_rounded,
          ),
        ],
      ),
    );
  }

  Widget _scheduleItem(
    String title,
    String time,
    String tutor,
    Color statusColor,
    String statusText,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: statusColor, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                Text(
                  tutor,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Review",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  CircleAvatar(radius: 3, backgroundColor: statusColor),
                  const SizedBox(width: 4),
                  Text(
                    statusText,
                    style: const TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
