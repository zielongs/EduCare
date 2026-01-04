/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : Siti Norlie Yana
Tested by   : Siti Norlie Yana
Date        : 28 December 2025
Description : 
Admin Menu Screen for the EduCare App.
- Provides quick access to Admin features
- Gradient background consistent with EduCare branding
- Each menu button navigates to the respective screen
- Logout clears the navigation stack and returns to the login/home screen
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'admin_home_screen.dart'; // import your new AdminHomeScreen

class AdminMenuScreen extends StatelessWidget {
  const AdminMenuScreen({super.key});

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

            // ===== HEADER =====
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
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // To balance the arrow
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ===== MENU LIST =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                children: [
                  _menuItem(context, "DASHBOARD"),
                  _menuItem(context, "SCHEDULE"),
                  _menuItem(context, "VIEW ATTENDANCE"),
                  _menuItem(context, "TUTOR AVAILABILITY"),
                  _menuItem(context, "REPLACEMENT REQUEST"),
                  _menuItem(context, "NOTIFICATIONS"),
                  _menuItem(context, "LOGOUT"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFD1F2F9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: const Icon(
          Icons.arrow_circle_right_outlined,
          color: Colors.black54,
        ),
        onTap: () {
          // ------------------ NAVIGATION LOGIC ------------------
          switch (title) {
            case "DASHBOARD":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminHomeScreen(initialIndex: 0),
                ),
              );
              break;

            case "SCHEDULE":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminHomeScreen(initialIndex: 1),
                ),
              );
              break;

            case "VIEW ATTENDANCE":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminHomeScreen(initialIndex: 2),
                ),
              );
              break;

            case "TUTOR AVAILABILITY":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminHomeScreen(initialIndex: 3),
                ),
              );
              break;

            case "REPLACEMENT REQUEST":
              // Replace with your replacement request screen route
              Navigator.pushNamed(context, '/admin_replacement');
              break;

            case "NOTIFICATIONS":
              // Replace with your notifications screen route
              Navigator.pushNamed(context, '/admin_notifications');
              break;

            case "LOGOUT":
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              break;
          }
        },
      ),
    );
  }
}

