import 'package:flutter/material.dart';
import 'role_placeholder_page.dart';

class RoleSelectPage extends StatelessWidget {
  const RoleSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    const topColor = Color(0xFF67E7E7);
    const midColor = Color(0xFF69A8E6);
    const bottomColor = Color(0xFF1B2E9B);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topColor, midColor, bottomColor],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // back button
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.22),
                        width: 1,
                      ),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),

                const SizedBox(height: 46),
                const Center(
                  child: Text(
                    'Are you...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                RoleTile(
                  label: 'STUDENT',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RolePlaceholderPage(role: 'Student'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),

                RoleTile(
                  label: 'ADMINISTRATOR',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RolePlaceholderPage(role: 'Administrator'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),

                RoleTile(
                  label: 'TUTOR',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RolePlaceholderPage(role: 'Tutor'),
                      ),
                    );
                  },
                ),

                const Spacer(),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const RoleTile({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFCFEFF0).withOpacity(0.95),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, size: 18, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
