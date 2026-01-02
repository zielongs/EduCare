/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  : 
Tested by   :
Date        : 03 January 2026
Description : 
This screen is used by admin to view AI tutor recommendations
based on selected subject and time. Admin can choose a tutor
from the recommendations to assign for a session.
--------------------------------------------------*/
import 'package:flutter/material.dart';
import 'widgets/admin_ui_components.dart';

class AiRecommendationArgs {
  final String subject;
  final DateTime? date;
  final int hour;
  final int minute;
  final bool isAm;

  const AiRecommendationArgs({
    required this.subject,
    required this.date,
    required this.hour,
    required this.minute,
    required this.isAm,
  });

  String get timeText =>
      '${hour.toString().padLeft(1, '0')}:${minute.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';
}

class AdminAiRecommendationsScreen extends StatelessWidget {
  const AdminAiRecommendationsScreen({super.key, required this.args});

  static const String routeName = '/admin_ai_recommendations';
  final AiRecommendationArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
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
                          'AI RECOMMENDATIONS',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Preferred Match',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),

                      TutorCard(
                        tutorName: 'Tutor: Alyssa',
                        lines: [
                          'Why recommended:',
                          '- Available at selected time (${args.timeText})',
                          '- Matches subject (${args.subject})',
                          '- Low workload this week',
                        ],
                        onAssign: () => Navigator.pop(context, 'Tutor Alyssa'),
                      ),

                      const SizedBox(height: 14),

                      const Text('Alternatives',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),

                      TutorCard(
                        tutorName: 'Tutor: Amir',
                        lines: const [
                          'Details:',
                          '- Available',
                          '- Medium workload',
                        ],
                        onAssign: () => Navigator.pop(context, 'Tutor Amir'),
                      ),

                      const SizedBox(height: 14),

                      const Text('Availables',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),

                      TutorCard(
                        tutorName: 'Tutor: Ainaa',
                        lines: const [
                          'Availability: 12–5 PM',
                          'Subject Match: Partial',
                          'Workload: High',
                        ],
                        onAssign: () => Navigator.pop(context, 'Tutor Ainaa'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TutorCard extends StatelessWidget {
  final String tutorName;
  final List<String> lines;
  final VoidCallback onAssign;

  const TutorCard({
    super.key,
    required this.tutorName,
    required this.lines,
    required this.onAssign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: AdminTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 10, offset: Offset(0, 6), color: Colors.black26),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tutorName, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          for (final l in lines)
            Text(
              l,
              style: TextStyle(
                fontSize: 12,
                color: l.startsWith('-') ? Colors.black87 : Colors.black,
              ),
            ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 130,
              height: 34,
              child: ElevatedButton(
                onPressed: onAssign,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9EDCD7),
                  foregroundColor: Colors.black87,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Assign Tutor',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
