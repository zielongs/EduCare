/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : 
Tested by   :
Date        : 02 January 2026
Description : 
Provides mock tutor data for testing and development.
- Each tutor record contains: name, subjects, availability status, list of students, and availability schedule.
- Availability schedule is a list of maps with date, time, mode (Online/Physical), and subject.
- Used in screens to display tutor info, availability, and scheduling.
--------------------------------------------------*/

import '../models/tutor.dart';

/// Mock list of tutors for testing/demo purposes
final List<Tutor> mockTutors = [
  Tutor(
    name: "Amir",
    subjects: ["Mathematics", "Malay"],
    isAvailable: true,
    students: ["James", "Felyana"],
    availability: [
      {
        "date": DateTime(2025, 11, 24),
        "time": "10AM - 12PM",
        "mode": "Online",
        "subject": "Mathematics",
      },
      {
        "date": DateTime(2025, 11, 24),
        "time": "2PM - 4PM",
        "mode": "Physical",
        "subject": "Malay",
      },
      {
        "date": DateTime(2025, 11, 25),
        "time": "2PM - 4PM",
        "mode": "Physical",
        "subject": "Malay",
      },
    ],
  ),
  Tutor(
    name: "Norlie",
    subjects: ["Science"],
    isAvailable: true,
    students: ["Aiman"],
    availability: [
      {
        "date": DateTime(2025, 11, 24),
        "time": "10AM - 12PM",
        "mode": "Online",
        "subject": "Science",
      },
      {
        "date": DateTime(2025, 11, 25),
        "time": "4PM - 6PM",
        "mode": "Physical",
        "subject": "Science",
      },
    ],
  ),
  Tutor(
    name: "Ziela",
    subjects: ["English"],
    isAvailable: true,
    students: ["Aisyah", "Daniel", "Hafiz"],
    availability: [
      {
        "date": DateTime(2025, 11, 24),
        "time": "10AM - 12PM",
        "mode": "Online",
        "subject": "English",
      },
      {
        "date": DateTime(2025, 11, 25),
        "time": "4PM - 6PM",
        "mode": "Physical",
        "subject": "English",
      },
    ],
  ),
  Tutor(
    name: "Aainaa",
    subjects: ["Chemistry"],
    isAvailable: false,
    students: ["None"],
    availability: [],
  ),
];
