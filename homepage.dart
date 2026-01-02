import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Homepage loaded successfully',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
