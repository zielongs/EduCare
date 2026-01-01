/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   : 
Date        : 02 January 2026
Description : 
Reusable search bar widget with TextField for tutor
search functionality. Accepts a controller and a
callback for onChanged events.
--------------------------------------------------*/
import 'package:flutter/material.dart';

/// Search bar widget with rounded corners and search icon
class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller; // Text editing controller
  final ValueChanged<String> onChanged; // Callback for text changes

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Connect controller
      onChanged: onChanged, // Trigger callback when text changes
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 219, 214, 214), // Background color
        prefixIcon: const Icon(Icons.search), // Search icon
        hintText: "Search tutor", // Placeholder text
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24), // Rounded corners
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
