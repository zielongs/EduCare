/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   : 
Date        : 02 January 2026
Description : 
A reusable card widget to filter tutors by availability
and subject. Provides Apply and Reset buttons to update
the filters.
--------------------------------------------------*/
import 'package:flutter/material.dart';

/// Reusable filter card for tutors
class FilterCard extends StatelessWidget {
  // ================= FILTER STATE =================
  final bool showAvailable; // Show available tutors
  final bool showNotAvailable; // Show unavailable tutors
  final String selectedSubject; // Currently selected subject filter
  final List<String> subjects; // List of subjects for dropdown

  // ================= CALLBACKS =================
  final VoidCallback onApply; // Triggered when Apply button pressed
  final VoidCallback onReset; // Triggered when Reset button pressed

  final ValueChanged<bool?> onAvailableChanged; // Availability checkbox changed
  final ValueChanged<bool?>
  onNotAvailableChanged; // Not-available checkbox changed
  final ValueChanged<String?> onSubjectChanged; // Subject dropdown changed

  const FilterCard({
    super.key,
    required this.showAvailable,
    required this.showNotAvailable,
    required this.selectedSubject,
    required this.subjects,
    required this.onAvailableChanged,
    required this.onNotAvailableChanged,
    required this.onSubjectChanged,
    required this.onApply,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 166, 239, 161),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Filters",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Availability checkboxes
            Row(
              children: [
                Checkbox(
                  value: showAvailable,
                  activeColor: Colors.teal,
                  onChanged: onAvailableChanged,
                ),
                const Text("Available"),

                const SizedBox(width: 12),

                Checkbox(
                  value: showNotAvailable,
                  activeColor: Colors.teal,
                  onChanged: onNotAvailableChanged,
                ),
                const Text("Not Available"),
              ],
            ),

            const SizedBox(height: 12),

            // Subject dropdown
            DropdownButtonFormField<String>(
              initialValue: selectedSubject,
              decoration: const InputDecoration(
                labelText: "Subject",
                border: OutlineInputBorder(),
              ),
              items: subjects.map((subject) {
                return DropdownMenuItem(value: subject, child: Text(subject));
              }).toList(),
              onChanged: onSubjectChanged,
            ),

            const SizedBox(height: 16),

            // Apply & Reset buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // button color
                    foregroundColor: Colors.white, // text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Apply"),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onReset,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red, // text color
                    side: const BorderSide(color: Colors.red), // border color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
