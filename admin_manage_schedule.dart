/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  : 
Tested by   :
Date        : 03 January 2026
Description : 
This screen is used by admin to manage tutor's schedule.
It allows admin to view current session details, change date/time, 
and select a replacement tutor.
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'admin_ai_recommendations.dart';
import 'widgets/admin_ui_components.dart';

class AdminManageScheduleScreen extends StatefulWidget {
  const AdminManageScheduleScreen({super.key});
  static const String routeName = '/admin_manage_schedule';

  @override
  State<AdminManageScheduleScreen> createState() =>
      _AdminManageScheduleScreenState();
}

class _AdminManageScheduleScreenState extends State<AdminManageScheduleScreen> {
  final List<String> subjects = ['Mathematics', 'Science', 'English'];
  final List<String> tutors = [
    'Tutor Amir',
    'Tutor Ziela',
    'Tutor Alyssa',
    'Tutor Ainaa',
  ];

  String selectedSubject = 'Mathematics';
  String currentTutor = 'Tutor Amir';
  String replacementTutor = 'Tutor Ziela';

  DateTime? selectedDate;

  int hour = 1;
  int minute = 0;
  bool isAm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  children: [
                    CircleIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Modify Session',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Current Session',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      DropdownField(
                        leadingIcon: Icons.star_border,
                        value: selectedSubject,
                        items: subjects,
                        chipText: 'Subjects',
                        onChanged: (v) => setState(() => selectedSubject = v),
                      ),

                      const SizedBox(height: 14),

                      const Text('Current Tutor',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      InfoField(
                        leadingIcon: Icons.person_outline,
                        title: currentTutor,
                        subtitle: 'Session Time: Monday, 9:00am – 11:00am',
                      ),

                      const SizedBox(height: 14),

                      const Text('Change Time/Date',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: DateField(
                              dateText: selectedDate == null
                                  ? 'Date'
                                  : _formatDate(selectedDate!),
                              onTap: _pickDate,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: TimeBox(
                              valueText: hour.toString().padLeft(1, '0'),
                              onMinus: () => setState(() {
                                if (hour > 1) hour--;
                              }),
                              onPlus: () => setState(() {
                                if (hour < 12) hour++;
                              }),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(':',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TimeBox(
                              valueText: minute.toString().padLeft(2, '0'),
                              onMinus: () => setState(() {
                                if (minute >= 5) minute -= 5;
                              }),
                              onPlus: () => setState(() {
                                if (minute <= 55) minute += 5;
                              }),
                            ),
                          ),
                          const SizedBox(width: 10),
                          AmPmToggle(
                            isAm: isAm,
                            onChanged: (v) => setState(() => isAm = v),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      const Text('Replacement Tutor',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),

                      DropdownField(
                        leadingIcon: Icons.person_outline,
                        value: replacementTutor,
                        items: tutors,
                        chipText: 'Tutors',
                        subtitle: 'Status: Available',
                        onChanged: (v) => setState(() => replacementTutor = v),
                      ),

                      const SizedBox(height: 14),

                      // AI button
                      Center(
                        child: SizedBox(
                          width: 220,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: _goToAiRecommendations,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF21C8D5),
                              foregroundColor: Colors.black,
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            child: const Text(
                              'AI Recommendations',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Save button (stays on page + popup)
                      Center(
                        child: SizedBox(
                          width: 140,
                          height: 36,
                          child: OutlinedButton(
                            onPressed: _saveChanges,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Colors.white, width: 1.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const Text('Save Changes'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom nav (placeholder safe)
              AdminBottomNav(
                currentIndex: 1,
                onTap: (index) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Bottom nav tapped: $index (connect later)')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _goToAiRecommendations() async {
    final args = AiRecommendationArgs(
      subject: selectedSubject,
      date: selectedDate,
      hour: hour,
      minute: minute,
      isAm: isAm,
    );

    final selected = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => AdminAiRecommendationsScreen(args: args),
      ),
    );

    if (selected != null && selected.trim().isNotEmpty) {
      setState(() => replacementTutor = selected);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Replacement tutor set to: $selected')),
        );
      }
    }
  }

  Future<void> _saveChanges() async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a date first.')),
      );
      return;
    }

    final timeText =
        '${hour.toString().padLeft(1, '0')}:${minute.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';

    final summary =
        'Subject: $selectedSubject\nCurrent Tutor: $currentTutor\nReplacement Tutor: $replacementTutor\nDate: ${_formatDate(selectedDate!)}\nTime: $timeText';

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        title: const Text('Saved successfully'),
        content: Text(summary),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Changes saved.')),
      );
    }
  }

  static String _formatDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yy = d.year.toString();
    return '$dd/$mm/$yy';
  }
}
