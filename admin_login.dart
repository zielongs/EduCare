/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : 
Tested by   : 
Date        : 28 December 2025
Description : 
Admin Login Screen for the EduCare App.
- Allows admin users to log in using username and password
- Provides password visibility toggle for better usability
- Navigates to Admin Menu screen upon successful login
- Uses a gradient background consistent with EduCare branding
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'admin_menu.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool _isObscured = true; // Controls password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Gradient background for branding consistency
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF53E1E1), Color(0xFF90CAF9)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),

            /* ---------------- Back Button ---------------- */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // App logo and title
            const Icon(Icons.pets, size: 80, color: Color(0xFF1A237E)),
            const Text(
              'EduCare',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),

            const SizedBox(height: 40),

            /* ---------------- Login Form ---------------- */
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        'ADMIN LOGIN',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Username input
                      _buildInputLabel("Username"),
                      _buildTextField("Enter admin username"),

                      const SizedBox(height: 20),

                      // Password input
                      _buildInputLabel("Password"),
                      _buildTextField("Enter admin password", isPassword: true),

                      const SizedBox(height: 30),

                      /* ---------------- Login Button ---------------- */
                      ElevatedButton(
                        onPressed: () {
                          // Temporary navigation without authentication logic
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminMenuScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA7DED9),
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ---------------- Input Label Widget ---------------- */
  Widget _buildInputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 5),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  /* ---------------- Text Field Widget ---------------- */
  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword ? _isObscured : false,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _isObscured = !_isObscured),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
