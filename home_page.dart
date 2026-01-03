/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 03 January 2026
Description : 
This screen is the home page of the EduCare app. 
It features the app logo, name, subtitle, tagline, 
and buttons for login and registration.
--------------------------------------------------*/
import 'package:flutter/material.dart';
import 'login_user_roles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Gradient colors (same as other screens)
  static const Color _top = Color(0xFF63DDE5);
  static const Color _mid = Color(0xFF5AA1D6);
  static const Color _bottom = Color(0xFF1C2B8C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_top, _mid, _bottom],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // ✅ LOGO FROM ASSETS
                  Image.asset(
                    'assets/images/educare_logo.png',
                    height: 160,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 16),

                  // App name
                  const Text(
                    'EduCare',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0B2B56),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Subtitle
                  const Text(
                    'SMART MANAGEMENT SYSTEM',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Color(0xFF0B2B56),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tagline
                  const Text(
                    '"Smarter Scheduling for Better Learning"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // LOGIN button
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginUserRolesScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB7EFEA),
                        foregroundColor: Colors.black,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // REGISTER button
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Register screen not connected yet.',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB7EFEA),
                        foregroundColor: Colors.black,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Terms text
                  const Text(
                    'By continuing, you agree to our\nTerms & Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

