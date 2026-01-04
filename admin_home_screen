/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 02 January 2026
Description : 
Admin home screen with reusable BottomNavigationBar.
Handles navigation between Dashboard, Schedule,
Attendance, and Tutor screens using named routes.
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'widgets/shared_bottom_nav.dart';
import 'admin_dashboard.dart';
import 'admin_schedule_screen.dart';
import 'admin_attendance_screen.dart';
import 'admin_tutor_availability_screen.dart';
import 'data/mock_tutors.dart'; 

class AdminHomeScreen extends StatefulWidget {
  final int initialIndex;

  const AdminHomeScreen({super.key, this.initialIndex = 0});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late int _currentIndex;
  late List<Widget> _screens;

  /// Initializes the current tab index and sets up the list of screens.
  /// Passes a callback to each screen to handle "Back to Dashboard".
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    _screens = [
      const AdminDashboardScreen(),
      AdminScheduleScreen(
        onBackToDashboard: () => setState(() => _currentIndex = 0),
      ),
      AdminAttendanceScreen(
        onBackToDashboard: () => setState(() => _currentIndex = 0),
      ),
      TutorAvailabilityScreen(
        tutors: mockTutors,
        onBackToDashboard: () => setState(() => _currentIndex = 0),
      ),
    ];
  }

  /// Builds the scaffold with the current screen and a shared bottom navigation bar.
  /// Updates the displayed screen when a tab is selected.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: buildSharedBottomNav(
        currentIndex: _currentIndex,
        onTabSelected: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
