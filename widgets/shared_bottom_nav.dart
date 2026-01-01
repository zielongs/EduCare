/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   : 
Date        : 02 January 2026
Description : 
Reusable BottomNavigationBar for all admin screens.
Uses named routes to navigate between Dashboard,
Schedule, Attendance, and Tutor screens.
Prevents circular imports by not directly importing screens.
--------------------------------------------------*/
import 'package:flutter/material.dart';

/// Builds a shared bottom navigation bar for admin screens
/// [context] - BuildContext to handle navigation and SnackBars
/// [currentIndex] - The currently selected tab index
BottomNavigationBar buildSharedBottomNav(
  BuildContext context,
  int currentIndex,
) {
  return BottomNavigationBar(
    currentIndex: currentIndex, // Highlight the current tab
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: const Color(0xFF2B3FAE),
    unselectedItemColor: Colors.grey,
    elevation: 8,

    // Handle tab taps
    onTap: (index) {
      // Prevent re-navigating to the same screen
      if (index == currentIndex) return;

      // Determine route name based on index
      String routeName;

      switch (index) {
        case 0:
          // TODO: Replace with actual Dashboard route when ready
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Dashboard coming soon!'),
              duration: Duration(seconds: 1),
            ),
          );
          return; // Skip navigation
        case 1:
          routeName = '/admin-schedule'; // Admin Schedule Screen
          break;
        case 2:
          routeName = '/admin-attendance'; // Admin Attendance Screen
          break;
        case 3:
          routeName = '/tutor-availability'; // Tutor Availability Screen
          break;
        default:
          return;
      }

      // Navigate to selected screen using named route
      Navigator.pushReplacementNamed(context, routeName);
    },

    // Navigation bar items
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label: "Schedule",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.check_circle),
        label: "Attendance",
      ),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: "Tutors"),
    ],
  );
}
