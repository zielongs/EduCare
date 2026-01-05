/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  :
Tested by   : Noraziela Binti Jepsin
Date        : 03 January 2026
Description :
Admin screen for managing tutor schedules.
Allows modification of subject, date, time,
and replacement tutor, with AI-assisted suggestions.
--------------------------------------------------*/

import 'package:flutter/material.dart';

import 'admin_ai_recommendations.dart';
import 'services/ai_recommendation_controller.dart';
import 'widgets/admin_ui_components.dart';
import 'widgets/shared_bottom_nav.dart';

class AdminManageScheduleScreen extends StatefulWidget {
  const AdminManageScheduleScreen({super.key});

  static const String routeName = '/admin_manage_schedule';

  @override
  State<AdminManageScheduleScreen> createState() =>
      _AdminManageScheduleScreenState();
}

class _AdminManageScheduleScreenState
    extends State<AdminManageScheduleScreen> {
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

  static const String _routeHome = '/admin_home';
  static const String _routeSchedule = '/admin_schedule';
  static const String _routeAttendance = '/admin_attendance';
  static const String _routeTutors = '/admin_tutors';

  @override
  Widget build(BuildContext context) {
    final bool canUseAi = selectedDate != null;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 14),
              Expanded(child: _buildBody(canUseAi)),
              buildSharedBottomNav(
                currentIndex: 1,
                onTabSelected: _handleBottomNav,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _buildBody(bool canUseAi) {
    return SingleChildScrollView(
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

          const Text('Change Time / Date',
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
                  valueText: hour.toString(),
                  onMinus: () =>
                      setState(() => hour = hour > 1 ? hour - 1 : hour),
                  onPlus: () =>
                      setState(() => hour = hour < 12 ? hour + 1 : hour),
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
                  onMinus: () => setState(
                      () => minute = minute >= 5 ? minute - 5 : minute),
                  onPlus: () => setState(
                      () => minute = minute <= 55 ? minute + 5 : minute),
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

          const SizedBox(height: 18),

          Center(
            child: SizedBox(
              width: 220,
              height: 44,
              child: ElevatedButton(
                onPressed:
                    canUseAi ? _goToAiRecommendations : _warnPickDate,
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

          Center(
            child: SizedBox(
              width: 140,
              height: 36,
              child: OutlinedButton(
                onPressed: _saveChanges,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 1.2),
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
    );
  }

  void _handleBottomNav(int index) {
    final route = switch (index) {
      0 => _routeHome,
      1 => _routeSchedule,
      2 => _routeAttendance,
      3 => _routeTutors,
      _ => _routeSchedule,
    };

    Navigator.pushReplacementNamed(context, route);
  }

  void _warnPickDate() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Please choose a date first for accurate AI recommendations.'),
        behavior: SnackBarBehavior.floating,
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
      currentTutor: currentTutor,
      candidateTutors: tutors,
    );

    final selected = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => AdminAiRecommendationsScreen(args: args),
      ),
    );

    if (selected != null && selected.trim().isNotEmpty) {
      setState(() => replacementTutor = selected);
    }
  }

  Future<void> _saveChanges() async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose a date first.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final timeText =
        '${hour.toString()}:${minute.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Saved successfully'),
        content: Text(
          'Subject: $selectedSubject\n'
          'Current Tutor: $currentTutor\n'
          'Replacement Tutor: $replacementTutor\n'
          'Date: ${_formatDate(selectedDate!)}\n'
          'Time: $timeText',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

