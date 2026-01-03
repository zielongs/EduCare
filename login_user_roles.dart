/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 03 January 2026
Description : 
This screen is used to select user roles for login. 
It allows users to choose between Student, Administrator, 
and Tutor roles for accessing their respective login screens.
--------------------------------------------------*/
import 'package:flutter/material.dart';

class LoginUserRolesScreen extends StatelessWidget {
  const LoginUserRolesScreen({super.key});

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
          child: Stack(
            children: [
              // Back button
              Positioned(
                left: 16,
                top: 10,
                child: _CircleIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
              ),

              // Content
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'Are you...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 18),

                        _RoleCard(
                          label: 'STUDENT',
                          onTap: () => _tryPushNamed(
                            context,
                            routeName: '/student',
                            fallbackMessage:
                                'Student screen not linked yet (route: /student).',
                          ),
                        ),
                        const SizedBox(height: 14),

                        _RoleCard(
                          label: 'ADMINISTRATOR',
                          onTap: () => _tryPushNamed(
                            context,
                            routeName: '/admin',
                            fallbackMessage:
                                'Admin screen not linked yet (route: /admin).',
                          ),
                        ),
                        const SizedBox(height: 14),

                        _RoleCard(
                          label: 'TUTOR',
                          onTap: () => _tryPushNamed(
                            context,
                            routeName: '/tutor',
                            fallbackMessage:
                                'Tutor screen not linked yet (route: /tutor).',
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
      ),
    );
  }

  static Future<void> _tryPushNamed(
    BuildContext context, {
    required String routeName,
    required String fallbackMessage,
  }) async {
    try {
      await Navigator.pushNamed(context, routeName);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(fallbackMessage)),
        );
      }
    }
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.25),
            border: Border.all(color: Colors.white.withOpacity(0.45)),
          ),
          child: Icon(icon, color: Colors.black87),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _RoleCard({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFBFEFF3).withOpacity(0.85),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 6),
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.85),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: Colors.black87,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

