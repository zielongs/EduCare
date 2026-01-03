/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : 
Tested by   : 
Date        : 28 December 2025
Description : 
Tutor Menu Screen for the EduCare App.
- Provides quick access to Tutor features
- Gradient background consistent with EduCare branding
- Each menu button navigates to the respective screen
- Logout clears the navigation stack and returns to the login/home screen
--------------------------------------------------*/

import 'package:flutter/material.dart';

class TutorMenuScreen extends StatelessWidget {
  const TutorMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Gradient background for visual consistency
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
                  // Back button
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Title
                  const Expanded(
                    child: Center(
                      child: Text(
                        'MENU',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Spacer for centering
                ],
              ),
            ),

            const SizedBox(height: 30),

            /* ---------------- Menu List ---------------- */
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView(
                  children: [
                    _buildMenuButton(context, "PROFILE"),
                    _buildMenuButton(context, "DASHBOARD"),
                    _buildMenuButton(context, "VIEW SCHEDULE"),
                    _buildMenuButton(context, "MANAGE AVAILABILITY"),
                    _buildMenuButton(context, "NOTIFICATIONS"),
                    _buildMenuButton(context, "LOGOUT"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ---------------- Menu Button Widget ---------------- */
  Widget _buildMenuButton(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFD1F2F9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_circle_right_outlined,
          color: Colors.black54,
        ),
        onTap: () {
          // --- Navigation Logic ---
          switch (title) {
            case "PROFILE":
              Navigator.pushNamed(context, '/tutor_profile');
              break;
            case "VIEW SCHEDULE":
              // Currently points to profile screen, update when schedule screen is ready
              Navigator.pushNamed(
                context,
                '/tutor_profile',
              ); // TODO: Change to /tutor_schedule
              break;
            case "DASHBOARD":
              Navigator.pushNamed(context, '/tutor_dashboard');
              break;
            case "MANAGE AVAILABILITY":
              Navigator.pushNamed(context, '/tutor_availability');
              break;
            case "NOTIFICATIONS":
              Navigator.pushNamed(context, '/tutor_notifications');
              break;
            case "LOGOUT":
              // Clears navigation stack and returns to login/home screen
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              break;
          }
        },
      ),
    );
  }
}
