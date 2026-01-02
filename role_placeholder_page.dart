import 'package:flutter/material.dart';

class RolePlaceholderPage extends StatelessWidget {
  final String role;
  const RolePlaceholderPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(role.toLowerCase())),
      body: Center(
        child: Text(
          '$role selected',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
