/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  :
Tested by   :
Date        : 04 January 2026
Description :
  - Controller for AI-based tutor recommendations using Gemini API.
  - Handles prompt construction, response parsing, error handling, and caching.
  - Ensures unique tutor selections and provides fallback recommendations.
--------------------------------------------------*/

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'gemini_service.dart';

class AiRecommendationArgs {
  final String subject;
  final DateTime? date;
  final int hour;
  final int minute;
  final bool isAm;
  final String currentTutor;
  final List<String> candidateTutors;

  const AiRecommendationArgs({
    required this.subject,
    required this.date,
    required this.hour,
    required this.minute,
    required this.isAm,
    required this.currentTutor,
    required this.candidateTutors,
  });

  String get timeText =>
      '${hour.toString().padLeft(1, '0')}:${minute.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';

  String get dateText {
    if (date == null) return 'No date selected';
    return '${date!.day.toString().padLeft(2, '0')}/'
        '${date!.month.toString().padLeft(2, '0')}/'
        '${date!.year}';
  }
}

class AiTutorPick {
  final String name;
  final List<String> reasons;

  const AiTutorPick({required this.name, required this.reasons});
}

class AiRecommendationResult {
  final AiTutorPick preferred;
  final List<AiTutorPick> alternatives;
  final List<AiTutorPick> availables;

  const AiRecommendationResult({
    required this.preferred,
    required this.alternatives,
    required this.availables,
  });
}

class AiRecommendationController extends ChangeNotifier {
  final GeminiService _gemini;

  AiRecommendationController({GeminiService? gemini})
      : _gemini = gemini ?? GeminiService();

  bool loading = false;
  AiRecommendationResult? result;

  // soft message for SnackBar, not an "error wall"
  String? lastNotice;

  // in-memory cache for demo stability
  static final Map<String, AiRecommendationResult> _cache = {};

  Future<void> fetch(AiRecommendationArgs args) async {
    loading = true;
    lastNotice = null;
    notifyListeners();

    // Always have a fallback so UI stays as recommendations
    result ??= _fallback(args);

    // If no date, we don't call AI (keeps it clean & “realistic”)
    if (args.date == null) {
      loading = false;
      lastNotice = 'Please select a date for accurate recommendations.';
      notifyListeners();
      return;
    }

    final key = _cacheKey(args);
    final cached = _cache[key];
    if (cached != null) {
      result = cached;
      loading = false;
      notifyListeners();
      return;
    }

    try {
      final prompt = _buildPrompt(args);
      final raw = await _gemini.generateText(prompt);

      final parsed = _tryParse(raw, args);
      if (parsed != null) {
        final fixed = _ensureUnique(parsed, args);
        result = fixed;
        _cache[key] = fixed;
      } else {
        // keep fallback; just notify softly
        lastNotice = 'AI response received but could not be formatted. Showing fallback.';
      }
    } catch (e) {
      lastNotice = _friendlyError(e.toString());
      // keep fallback in result
      result = _ensureUnique(result ?? _fallback(args), args);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  String _cacheKey(AiRecommendationArgs a) =>
      '${a.subject}|${a.dateText}|${a.timeText}|${a.currentTutor}|${a.candidateTutors.join(",")}';

  String _friendlyError(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('429') || lower.contains('resource_exhausted')) {
      return 'AI is busy right now. Showing fallback recommendations.';
    }
    if (lower.contains('timeout') || lower.contains('timed out')) {
      return 'Connection is slow. Showing fallback recommendations.';
    }
    return 'AI is unavailable right now. Showing fallback recommendations.';
  }

  String _buildPrompt(AiRecommendationArgs args) {
    // IMPORTANT: Force Gemini to choose ONLY from allowed names
    final allowed = args.candidateTutors.join(', ');

    return '''
You are EduCare's scheduling assistant.

Goal:
Recommend a replacement tutor for an admin to assign.

Context:
- Subject: ${args.subject}
- Date: ${args.dateText}
- Time: ${args.timeText}
- Current tutor (avoid): ${args.currentTutor}
- Allowed tutor names (MUST use exactly these): $allowed

Return ONLY valid JSON (no markdown, no extra text) in this schema:
{
  "preferred": { "name": "Tutor Name", "reasons": ["reason 1", "reason 2", "reason 3"] },
  "alternatives": [
    { "name": "Tutor Name", "reasons": ["reason 1", "reason 2"] },
    { "name": "Tutor Name", "reasons": ["reason 1", "reason 2"] }
  ],
  "availables": [
    { "name": "Tutor Name", "reasons": ["reason 1", "reason 2", "reason 3"] },
    { "name": "Tutor Name", "reasons": ["reason 1", "reason 2", "reason 3"] }
  ]
}

Rules:
- Do NOT repeat tutor names across preferred/alternatives/availables.
- Preferred must not be the current tutor.
- Reasons must be short, professional, admin-friendly.
''';
  }

  AiRecommendationResult? _tryParse(String raw, AiRecommendationArgs args) {
    try {
      final start = raw.indexOf('{');
      final end = raw.lastIndexOf('}');
      if (start == -1 || end == -1) return null;

      final cleaned = raw.substring(start, end + 1);
      final decoded = jsonDecode(cleaned);
      if (decoded is! Map<String, dynamic>) return null;

      AiTutorPick pickFrom(Map<String, dynamic> m, {int minReasons = 2}) {
        final name = (m['name'] ?? '').toString().trim();
        final reasonsRaw = m['reasons'];
        final reasons = (reasonsRaw is List)
            ? reasonsRaw.map((e) => e.toString()).where((s) => s.trim().isNotEmpty).toList()
            : <String>[];

        // keep it neat and consistent
        final safeReasons = reasons.take(3).toList();
        while (safeReasons.length < minReasons) {
          safeReasons.add('Available at the selected time');
        }

        return AiTutorPick(name: name, reasons: safeReasons);
      }

      final prefMap = decoded['preferred'];
      final altsList = decoded['alternatives'];
      final avList = decoded['availables'];

      if (prefMap is! Map<String, dynamic>) return null;

      final preferred = pickFrom(prefMap, minReasons: 3);

      final alternatives = (altsList is List)
          ? altsList.whereType<Map>().map((e) => pickFrom(Map<String, dynamic>.from(e), minReasons: 2)).toList()
          : <AiTutorPick>[];

      final availables = (avList is List)
          ? avList.whereType<Map>().map((e) => pickFrom(Map<String, dynamic>.from(e), minReasons: 3)).toList()
          : <AiTutorPick>[];

      // sanitize names to allowed list early
      final allowed = args.candidateTutors.toSet();
      AiTutorPick sanitizePick(AiTutorPick p) {
        final name = allowed.contains(p.name) ? p.name : _firstNonCurrent(args);
        return AiTutorPick(name: name, reasons: p.reasons);
      }

      return AiRecommendationResult(
        preferred: sanitizePick(preferred),
        alternatives: alternatives.map(sanitizePick).toList(),
        availables: availables.map(sanitizePick).toList(),
      );
    } catch (_) {
      return null;
    }
  }

  String _firstNonCurrent(AiRecommendationArgs args) {
    for (final t in args.candidateTutors) {
      if (t != args.currentTutor) return t;
    }
    return args.candidateTutors.isNotEmpty ? args.candidateTutors.first : 'Tutor';
  }

  // ✅ Fix duplicates no matter what Gemini returns
  AiRecommendationResult _ensureUnique(AiRecommendationResult input, AiRecommendationArgs args) {
    final allowed = args.candidateTutors.toList();
    final used = <String>{};

    String pickUnique(String desired, {bool avoidCurrentForPreferred = false}) {
      // if desired is ok and not used, accept it
      final okDesired = allowed.contains(desired) && !used.contains(desired);
      final notCurrent = !avoidCurrentForPreferred || desired != args.currentTutor;

      if (okDesired && notCurrent) {
        used.add(desired);
        return desired;
      }

      // otherwise pick the first available that isn't used (and optionally not current)
      for (final t in allowed) {
        if (used.contains(t)) continue;
        if (avoidCurrentForPreferred && t == args.currentTutor) continue;
        used.add(t);
        return t;
      }

      // if list is too small, allow repeats (last resort)
      used.add(desired);
      return desired;
    }

    final prefName = pickUnique(input.preferred.name, avoidCurrentForPreferred: true);
    final preferred = AiTutorPick(name: prefName, reasons: input.preferred.reasons);

    final alternatives = <AiTutorPick>[];
    for (final a in input.alternatives.take(2)) {
      alternatives.add(AiTutorPick(
        name: pickUnique(a.name),
        reasons: a.reasons.take(2).toList(),
      ));
    }

    final availables = <AiTutorPick>[];
    for (final a in input.availables.take(2)) {
      availables.add(AiTutorPick(
        name: pickUnique(a.name),
        reasons: a.reasons.take(3).toList(),
      ));
    }

    // ensure we always have 2/2 even if AI returns fewer
    while (alternatives.length < 2) {
      alternatives.add(AiTutorPick(
        name: pickUnique(_firstNonCurrent(args)),
        reasons: const ['Available', 'Good backup option'],
      ));
    }
    while (availables.length < 2) {
      availables.add(AiTutorPick(
        name: pickUnique(_firstNonCurrent(args)),
        reasons: const ['Available today', 'Acceptable subject fit', 'Backup option'],
      ));
    }

    return AiRecommendationResult(
      preferred: preferred,
      alternatives: alternatives,
      availables: availables,
    );
  }

  AiRecommendationResult _fallback(AiRecommendationArgs args) {
    final allowed = args.candidateTutors.where((t) => t != args.currentTutor).toList();
    final base = allowed.isNotEmpty ? allowed : args.candidateTutors;

    String pick(int i) => base.isNotEmpty ? base[i % base.length] : 'Tutor';

    final preferred = AiTutorPick(
      name: pick(0),
      reasons: [
        'Available at ${args.timeText}',
        'Matches subject (${args.subject})',
        'Balanced workload',
      ],
    );

    final alternatives = [
      AiTutorPick(name: pick(1), reasons: ['Available', 'Good subject match']),
      AiTutorPick(name: pick(2), reasons: ['Available', 'Suitable backup option']),
    ];

    final availables = [
      AiTutorPick(name: pick(3), reasons: ['Available today', 'Workload: medium', 'OK subject fit']),
      AiTutorPick(name: pick(4), reasons: ['Available today', 'Workload: high', 'Backup option']),
    ];

    return _ensureUnique(
      AiRecommendationResult(
        preferred: preferred,
        alternatives: alternatives,
        availables: availables,
      ),
      args,
    );
  }
}
