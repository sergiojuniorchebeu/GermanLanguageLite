import 'package:shared_preferences/shared_preferences.dart';

class WeeklyChallenge {
  final String id;
  final String title;
  final String description;
  final int progress;
  final int target;

  const WeeklyChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
  });

  bool get isCompleted => progress >= target;

  double get ratio {
    if (target <= 0) return 1.0;
    return (progress / target).clamp(0.0, 1.0);
  }
}

class ChallengeService {
  ChallengeService._();

  static const List<_ChallengeTemplate> _templates = [
    _ChallengeTemplate(
      id: 'weekly_quizzes',
      title: 'Quiz de la semaine',
      description: 'Réussir 3 quiz de leçon',
      target: 3,
    ),
    _ChallengeTemplate(
      id: 'weekly_lessons',
      title: 'Leçons actives',
      description: 'Visiter 4 leçons différentes',
      target: 4,
    ),
    _ChallengeTemplate(
      id: 'weekly_minutes',
      title: 'Temps de pratique',
      description: 'Cumuler 45 minutes d’étude',
      target: 45,
    ),
  ];

  static String _currentWeekId() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return '${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}';
  }

  static String _key(String challengeId) =>
      'weekly_${_currentWeekId()}_$challengeId';

  static Future<void> recordLessonVisit() async {
    await _increment('weekly_lessons', 1);
  }

  static Future<void> recordQuizSuccess() async {
    await _increment('weekly_quizzes', 1);
  }

  static Future<void> recordStudySeconds(int seconds) async {
    if (seconds <= 0) return;
    final minutes = (seconds / 60).ceil();
    await _increment('weekly_minutes', minutes);
  }

  static Future<List<WeeklyChallenge>> getWeeklyChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    return _templates
        .map(
          (template) => WeeklyChallenge(
            id: template.id,
            title: template.title,
            description: template.description,
            progress: prefs.getInt(_key(template.id)) ?? 0,
            target: template.target,
          ),
        )
        .toList();
  }

  static Future<Map<String, dynamic>> getWeeklySummary() async {
    final challenges = await getWeeklyChallenges();
    final completed =
        challenges.where((challenge) => challenge.isCompleted).length;
    return {
      'weekId': _currentWeekId(),
      'completed': completed,
      'total': challenges.length,
      'next': challenges.firstWhere(
        (challenge) => !challenge.isCompleted,
        orElse: () => challenges.first,
      ),
    };
  }

  static Future<void> resetCurrentWeek() async {
    final prefs = await SharedPreferences.getInstance();
    for (final template in _templates) {
      await prefs.remove(_key(template.id));
    }
  }

  static Future<void> _increment(String challengeId, int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _key(challengeId);
    final current = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, current + amount);
  }
}

class _ChallengeTemplate {
  final String id;
  final String title;
  final String description;
  final int target;

  const _ChallengeTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.target,
  });
}
