/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
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
BottomNavigationBar buildSharedBottomNav({
  required int currentIndex,
  required ValueChanged<int> onTabSelected,
}) {
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
      onTabSelected(index); // Just trigger the callback
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

