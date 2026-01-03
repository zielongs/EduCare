/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  :
Tested by   :
Date        : 02 January 2026
Description :
This screen allows the admin to view the tutor
schedule. Admin can select a date to see available
sessions, clear date filters, and see all scheduled
tutors and sessions for that day.
--------------------------------------------------*/
import 'package:flutter/material.dart';
import 'data/mock_tutors.dart';
import 'widgets/shared_bottom_nav.dart';
import 'admin_manage_schedule.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({super.key});

  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> {
  late DateTime selectedDate;

  // ================= INIT =================
  @override
  void initState() {
    super.initState();

    // Auto-pick first available session date from mock data
    for (final tutor in mockTutors) {
      if (tutor.availability.isNotEmpty) {
        selectedDate = tutor.availability.first["date"] as DateTime;
        return;
      }
    }

    // Fallback to current date if no availability
    selectedDate = DateTime.now();
  }

  // ================= HELPERS =================

  /// Check if two dates are the same (ignore time)
  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Convert month number to month name
  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  /// Convert weekday number to short weekday name
  String _weekdayName(int day) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[day - 1];
  }

  // ================= DATE PICKER =================

  /// Show date picker to select date
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }

  /// Reset selected date to first available session
  void _clearDateFilter() {
    setState(() {
      for (final tutor in mockTutors) {
        if (tutor.availability.isNotEmpty) {
          selectedDate = tutor.availability.first["date"] as DateTime;
          return;
        }
      }
      selectedDate = DateTime.now();
    });
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildSharedBottomNav(context, 1),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6FE3E1), Color(0xFF2B3FAE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildDateHeader(),
              const SizedBox(height: 16),
              Expanded(child: _buildScheduleList()),
              _buildModifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "ADMIN SCHEDULE",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ================= DATE HEADER =================

  Widget _buildDateHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: _pickDate,
              child: Row(
                children: [
                  Text(
                    selectedDate.day.toString(),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _monthName(selectedDate.month),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        _weekdayName(selectedDate.weekday),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: _clearDateFilter,
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: _pickDate,
          ),
        ],
      ),
    );
  }

  // ================= SCHEDULE LIST =================

  Widget _buildScheduleList() {
    final tutors = mockTutors.where((tutor) {
      return tutor.availability.any((slot) {
        final d = slot["date"] as DateTime;
        return isSameDate(d, selectedDate);
      });
    }).toList();

    if (tutors.isEmpty) {
      return const Center(
        child: Text(
          "No schedules for this date",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tutors.length,
      itemBuilder: (context, index) {
        final tutor = tutors[index];

        final sessionsToday = tutor.availability.where((slot) {
          final d = slot["date"] as DateTime;
          return isSameDate(d, selectedDate);
        }).toList();

        return TutorScheduleTile(
          tutorName: tutor.name,
          subjects: tutor.subjects,
          sessions: sessionsToday,
        );
      },
    );
  }

  // ================= MODIFY BUTTON =================

  Widget _buildModifyButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminManageScheduleScreen(),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text("Modify Session"),
        ),
      ),
    );
  }
}

// ================= COMPONENTS =================

class SessionCard extends StatelessWidget {
  final String subject;
  final String time;
  final String mode;

  const SessionCard(this.subject, this.time, this.mode, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF00C6B8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontSize: 12)),
            Text(mode, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class TutorScheduleTile extends StatelessWidget {
  final String tutorName;
  final List<Map<String, dynamic>> sessions;
  final List<String> subjects;

  const TutorScheduleTile({
    super.key,
    required this.tutorName,
    required this.sessions,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF2B3FAE)),
                ),
                const SizedBox(height: 6),
                Text(
                  tutorName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: sessions.map((slot) {
                return SessionCard(
                  slot["subject"],
                  slot["time"],
                  slot["mode"],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
