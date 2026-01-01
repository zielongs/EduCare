/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   : 
Date        : 02 January 2026
Description : 
Defines the Tutor model used throughout the app.
- Stores tutor name, subjects, availability, assigned students, and status
- Availability is a list of maps containing date, time, subject, and mode
--------------------------------------------------*/

/// Model class representing a Tutor
class Tutor {
  final String name; // Tutor's full name
  final List<String> subjects; // Subjects tutor can teach
  final bool isAvailable; // Current availability status
  final List<String> students; // List of assigned student names
  final List<Map<String, dynamic>>
  availability; // List of availability slots (date, time, subject, mode)

  Tutor({
    required this.name,
    required this.subjects,
    required this.isAvailable,
    required this.students,
    required this.availability,
  });
}
