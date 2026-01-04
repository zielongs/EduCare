/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 02 January 2026
Description : 
A reusable card widget to display basic tutor info:
- Name
- Subjects
- Availability status
Tapping the card navigates to TutorDetailScreen
with full tutor details.
--------------------------------------------------*/

import 'package:flutter/material.dart';
import '../models/tutor.dart';
import '../admin_tutor_detail_screen.dart';

/// Card widget showing tutor info
class TutorCard extends StatelessWidget {
  final Tutor tutor; // Tutor object to display

  const TutorCard({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // Navigate to TutorDetailScreen on tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TutorDetailScreen(tutor: tutor)),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(tutor.name), // Tutor name
          subtitle: Text("Subjects: ${tutor.subjects.join(', ')}"), // Subjects
          trailing: Text(
            tutor.isAvailable ? "Available" : "Not Available", // Availability
            style: TextStyle(
              color: tutor.isAvailable ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}


