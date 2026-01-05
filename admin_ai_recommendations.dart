/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  : 
Tested by   : Noraziela Binti Jepsin
Date        : 04 January 2026
Description :
Admin AI Recommendations screen.
Uses controller + GeminiService
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'widgets/admin_ui_components.dart';
import 'services/ai_recommendation_controller.dart';

class AdminAiRecommendationsScreen extends StatefulWidget {
  const AdminAiRecommendationsScreen({super.key, required this.args});

  static const String routeName = '/admin_ai_recommendations';
  final AiRecommendationArgs args;

  @override
  State<AdminAiRecommendationsScreen> createState() =>
      _AdminAiRecommendationsScreenState();
}

class _AdminAiRecommendationsScreenState
    extends State<AdminAiRecommendationsScreen> {
  late final AiRecommendationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AiRecommendationController();

    // fetch immediately
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.fetch(widget.args);
      _showNoticeIfAny();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showNoticeIfAny() {
    final msg = _controller.lastNotice;
    if (msg == null || msg.trim().isEmpty) return;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _refresh() async {
    await _controller.fetch(widget.args);
    _showNoticeIfAny();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final res = _controller.result;

              return Column(
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
                          _ContextChip(
                            subject: widget.args.subject,
                            dateText: widget.args.dateText,
                            timeText: widget.args.timeText,
                            loading: _controller.loading,
                            onRefresh: _controller.loading ? null : _refresh,
                          ),
                          const SizedBox(height: 12),

                          if (res == null)
                            _LoadingCard()
                          else
                            _AiContent(result: res),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ContextChip extends StatelessWidget {
  final String subject;
  final String dateText;
  final String timeText;
  final bool loading;
  final VoidCallback? onRefresh;

  const _ContextChip({
    required this.subject,
    required this.dateText,
    required this.timeText,
    required this.loading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.70),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, size: 18, color: Colors.black87),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'subject: $subject  •  date: $dateText  •  time: $timeText',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          if (loading)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2.2),
            )
          else
            InkWell(
              onTap: onRefresh,
              borderRadius: BorderRadius.circular(10),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.refresh, size: 18, color: Colors.black87),
              ),
            ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
      decoration: BoxDecoration(
        color: AdminTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 6),
            color: Colors.black26,
          ),
        ],
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2.4),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'AI is analyzing tutor availability...',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiContent extends StatelessWidget {
  final AiRecommendationResult result;
  const _AiContent({required this.result});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Preferred Match',
            style: TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        TutorCard(
          tutorName: result.preferred.name,
          lines: [
            'Why recommended:',
            for (final r in result.preferred.reasons) '- $r',
          ],
          onAssign: () => Navigator.pop(context, result.preferred.name),
        ),
        const SizedBox(height: 14),

        const Text('Alternatives',
            style: TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        ...result.alternatives.map(
          (t) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: TutorCard(
              tutorName: t.name,
              lines: [
                'Details:',
                for (final r in t.reasons) '- $r',
              ],
              onAssign: () => Navigator.pop(context, t.name),
            ),
          ),
        ),

        const Text('Availables',
            style: TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        ...result.availables.map(
          (t) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: TutorCard(
              tutorName: t.name,
              lines: [
                'Availability:',
                for (final r in t.reasons) '- $r',
              ],
              onAssign: () => Navigator.pop(context, t.name),
            ),
          ),
        ),
      ],
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
          Text('Tutor: $tutorName',
              style: const TextStyle(fontWeight: FontWeight.w900)),
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

