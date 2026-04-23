import 'package:shared_preferences/shared_preferences.dart';
import 'package:projet2/core/services/challenge_service.dart';

class LevelInfo {
  final int level;
  final int currentXP;
  final int currentLevelStartXP;
  final int nextLevelXP;

  const LevelInfo({
    required this.level,
    required this.currentXP,
    required this.currentLevelStartXP,
    required this.nextLevelXP,
  });

  double get progress {
    final span = nextLevelXP - currentLevelStartXP;
    if (span <= 0) return 1;
    return ((currentXP - currentLevelStartXP) / span).clamp(0.0, 1.0);
  }

  int get xpToNextLevel => nextLevelXP - currentXP;
}

class UserBadge {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final bool unlocked;

  const UserBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.unlocked,
  });
}

class SessionSummary {
  final int durationSeconds;
  final int xpGained;
  final int phraseCount;
  final bool quizCompleted;
  final bool flashcardsReviewed;
  final int quizBestScore;
  final int flashcardsBestScore;

  const SessionSummary({
    required this.durationSeconds,
    required this.xpGained,
    required this.phraseCount,
    required this.quizCompleted,
    required this.flashcardsReviewed,
    required this.quizBestScore,
    required this.flashcardsBestScore,
  });
}

class ProfileStats {
  final int xp;
  final int streak;
  final LevelInfo levelInfo;
  final int totalSessions;
  final int totalMinutes;
  final int completedLessons;
  final int completedQuizzes;
  final int perfectQuizzes;
  final int bestQuizScore;
  final int flashcardsReviewed;
  final List<UserBadge> badges;

  const ProfileStats({
    required this.xp,
    required this.streak,
    required this.levelInfo,
    required this.totalSessions,
    required this.totalMinutes,
    required this.completedLessons,
    required this.completedQuizzes,
    required this.perfectQuizzes,
    required this.bestQuizScore,
    required this.flashcardsReviewed,
    required this.badges,
  });
}

/// Service centralisé pour la progression, XP et streak.
/// Toutes les méthodes sont statiques et asynchrones.
class ProgressService {
  ProgressService._();

  /// Nombre total de leçons par chapitre
  static const Map<int, int> chapterTotals = {
    1: 5,
    2: 2,
    3: 4,
    4: 3,
    5: 2,
    6: 2,
    7: 3,
    8: 4,
    9: 4,
    10: 3,
    11: 1,
  };

  static String _lessonKey(int chapter, String lessonId, String suffix) =>
      'ch_${chapter}_${lessonId.trim()}_$suffix';

  static String _sessionKey(int chapter, String lessonId, String suffix) =>
      'session_${chapter}_${lessonId.trim()}_$suffix';

  // ── Progression ─────────────────────────────────────────────────────────

  /// Marque une leçon comme visitée. Ajoute 10 XP si c'est la première visite.
  static Future<void> markLessonVisited(int chapter, String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'ch_${chapter}_visited';
    final current = List<String>.from(prefs.getStringList(key) ?? []);
    if (!current.contains(lessonId)) {
      current.add(lessonId);
      await prefs.setStringList(key, current);
      await _addXP(10);
      await updateStreak();
      await ChallengeService.recordLessonVisit();
    }
  }

  static Future<void> startLessonSession(int chapter, String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt(_sessionKey(chapter, lessonId, 'start_ms'), now);
    await prefs.setInt(
        _sessionKey(chapter, lessonId, 'xp_start'), await getXP());
  }

  static Future<SessionSummary> endLessonSession(
    int chapter,
    String lessonId, {
    required int phraseCount,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final startMs = prefs.getInt(_sessionKey(chapter, lessonId, 'start_ms'));
    final xpStart = prefs.getInt(_sessionKey(chapter, lessonId, 'xp_start'));
    final durationSeconds = startMs == null
        ? 0
        : ((DateTime.now().millisecondsSinceEpoch - startMs) / 1000).round();
    final currentXp = await getXP();
    final xpGained =
        xpStart == null ? 0 : (currentXp - xpStart).clamp(0, 100000);
    final safeDuration = durationSeconds < 0 ? 0 : durationSeconds;

    final totalTime = prefs.getInt('total_time_seconds') ?? 0;
    await prefs.setInt('total_time_seconds', totalTime + safeDuration);
    final sessionCount = prefs.getInt('lesson_session_count') ?? 0;
    await prefs.setInt('lesson_session_count', sessionCount + 1);
    await ChallengeService.recordStudySeconds(safeDuration);

    await prefs.remove(_sessionKey(chapter, lessonId, 'start_ms'));
    await prefs.remove(_sessionKey(chapter, lessonId, 'xp_start'));

    final stats = await getLessonStats(chapter, lessonId);
    return SessionSummary(
      durationSeconds: safeDuration,
      xpGained: xpGained,
      phraseCount: phraseCount,
      quizCompleted: stats['quizCompleted'] as bool? ?? false,
      flashcardsReviewed: stats['flashcardsReviewed'] as bool? ?? false,
      quizBestScore: stats['quizBestScore'] as int? ?? 0,
      flashcardsBestScore: stats['flashcardsBestScore'] as int? ?? 0,
    );
  }

  /// Retourne la progression (0.0–1.0) d'un chapitre.
  static Future<double> getChapterProgress(int chapter) async {
    final prefs = await SharedPreferences.getInstance();
    final total = chapterTotals[chapter] ?? 1;
    final visited = (prefs.getStringList('ch_${chapter}_visited') ?? []).length;
    return (visited / total).clamp(0.0, 1.0);
  }

  /// Retourne la progression de tous les chapitres (1–11) en une seule requête.
  static Future<Map<int, double>> getAllChapterProgresses() async {
    final prefs = await SharedPreferences.getInstance();
    final result = <int, double>{};
    for (final chapter in chapterTotals.keys) {
      final total = chapterTotals[chapter]!;
      final visited =
          (prefs.getStringList('ch_${chapter}_visited') ?? []).length;
      result[chapter] = (visited / total).clamp(0.0, 1.0);
    }
    return result;
  }

  /// Marque un chapitre comme complètement terminé (toutes leçons visitées).
  static Future<void> completeChapter(int chapter) async {
    final prefs = await SharedPreferences.getInstance();
    final total = chapterTotals[chapter] ?? 1;
    final allIndices = List.generate(total, (i) => '$i');
    final current = prefs.getStringList('ch_${chapter}_visited') ?? [];
    if (current.length < total) {
      await prefs.setStringList('ch_${chapter}_visited', allIndices);
    }
  }

  // ── Quiz ────────────────────────────────────────────────────────────────

  /// Appeler à la fin du quiz. Si score ≥ 50%, ajoute du XP une seule fois pour cette leçon.
  static Future<int> completeQuiz(
    int chapter,
    String lessonId,
    int correct,
    int total,
  ) async {
    if (total <= 0) return 0;
    final prefs = await SharedPreferences.getInstance();
    final ratio = correct / total;
    int xpGained = 0;
    final score = (ratio * 100).round();
    final scoreKey = _lessonKey(chapter, lessonId, 'quiz_best_score');
    final bestScore = prefs.getInt(scoreKey) ?? 0;
    if (score > bestScore) {
      await prefs.setInt(scoreKey, score);
    }
    if (ratio >= 0.5) {
      final completedKey = _lessonKey(chapter, lessonId, 'quiz_completed');
      final alreadyCompleted = prefs.getBool(completedKey) ?? false;
      if (!alreadyCompleted) {
        xpGained = score; // 50–100 XP selon le score
        await _addXP(xpGained);
        await prefs.setBool(completedKey, true);
      }
      await updateStreak();
      await ChallengeService.recordQuizSuccess();
    }
    return xpGained;
  }

  static Future<int> completeChapterExam(
    int chapter,
    int correct,
    int total,
  ) async {
    if (total <= 0) return 0;
    final prefs = await SharedPreferences.getInstance();
    final score = ((correct / total) * 100).round();
    final bestScoreKey = 'chapter_exam_${chapter}_best_score';
    final bestScore = prefs.getInt(bestScoreKey) ?? 0;
    if (score > bestScore) {
      await prefs.setInt(bestScoreKey, score);
    }

    var xpGained = 0;
    if (score >= 60) {
      final completedKey = 'chapter_exam_${chapter}_completed';
      final alreadyCompleted = prefs.getBool(completedKey) ?? false;
      if (!alreadyCompleted) {
        xpGained = 35;
        await _addXP(xpGained);
        await prefs.setBool(completedKey, true);
      }
      await updateStreak();
    }
    return xpGained;
  }

  static Future<int> completeFinalExam(int correct, int total) async {
    if (total <= 0) return 0;
    final prefs = await SharedPreferences.getInstance();
    final score = ((correct / total) * 100).round();
    final bestScore = prefs.getInt('final_exam_best_score') ?? 0;
    if (score > bestScore) {
      await prefs.setInt('final_exam_best_score', score);
    }

    var xpGained = 0;
    if (score >= 70) {
      final alreadyCompleted = prefs.getBool('final_exam_completed') ?? false;
      if (!alreadyCompleted) {
        xpGained = 80;
        await _addXP(xpGained);
        await prefs.setBool('final_exam_completed', true);
      }
      await updateStreak();
    }
    return xpGained;
  }

  static Future<int> getChapterExamBestScore(int chapter) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('chapter_exam_${chapter}_best_score') ?? 0;
  }

  static Future<bool> isChapterExamCompleted(int chapter) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('chapter_exam_${chapter}_completed') ?? false;
  }

  static Future<int> getFinalExamBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('final_exam_best_score') ?? 0;
  }

  static Future<bool> isFinalExamCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('final_exam_completed') ?? false;
  }

  static Future<int> saveFlashcardSession(
    int chapter,
    String lessonId,
    int known,
    int total,
  ) async {
    if (total <= 0) return 0;
    final prefs = await SharedPreferences.getInstance();
    final score = ((known / total) * 100).round();
    final scoreKey = _lessonKey(chapter, lessonId, 'flashcards_best_score');
    final bestScore = prefs.getInt(scoreKey) ?? 0;
    if (score > bestScore) {
      await prefs.setInt(scoreKey, score);
    }

    final reviewedKey = _lessonKey(chapter, lessonId, 'flashcards_reviewed');
    final alreadyReviewed = prefs.getBool(reviewedKey) ?? false;
    if (alreadyReviewed) {
      await updateStreak();
      return 0;
    }

    await prefs.setBool(reviewedKey, true);
    final xpGained = score >= 70 ? 20 : 10;
    await _addXP(xpGained);
    await updateStreak();
    return xpGained;
  }

  static Future<Map<String, dynamic>> getLessonStats(
    int chapter,
    String lessonId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'quizCompleted':
          prefs.getBool(_lessonKey(chapter, lessonId, 'quiz_completed')) ??
              false,
      'quizBestScore':
          prefs.getInt(_lessonKey(chapter, lessonId, 'quiz_best_score')) ?? 0,
      'flashcardsReviewed':
          prefs.getBool(_lessonKey(chapter, lessonId, 'flashcards_reviewed')) ??
              false,
      'flashcardsBestScore': prefs.getInt(
            _lessonKey(chapter, lessonId, 'flashcards_best_score'),
          ) ??
          0,
    };
  }

  // ── XP ──────────────────────────────────────────────────────────────────

  static Future<int> getXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('total_xp') ?? 0;
  }

  static Future<void> _addXP(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt('total_xp') ?? 0;
    await prefs.setInt('total_xp', current + amount);
  }

  // ── Streak ──────────────────────────────────────────────────────────────

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('streak') ?? 0;
  }

  static Future<void> updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString('last_active_date');
    final today = DateTime.now().toIso8601String().substring(0, 10);

    if (lastDate == null || lastDate.isEmpty) {
      await prefs.setInt('streak', 1);
    } else if (lastDate != today) {
      final last = DateTime.tryParse(lastDate);
      if (last != null) {
        final diff = DateTime.now().difference(last).inDays;
        if (diff == 1) {
          final current = prefs.getInt('streak') ?? 0;
          await prefs.setInt('streak', current + 1);
        } else {
          await prefs.setInt('streak', 1);
        }
      }
    }
    await prefs.setString('last_active_date', today);
  }

  static LevelInfo getLevelInfoFromXP(int xp) {
    var level = 1;
    var levelStart = 0;
    var threshold = 120;

    while (xp >= threshold) {
      level++;
      levelStart = threshold;
      threshold += 120 + (level - 1) * 30;
    }

    return LevelInfo(
      level: level,
      currentXP: xp,
      currentLevelStartXP: levelStart,
      nextLevelXP: threshold,
    );
  }

  static Future<LevelInfo> getLevelInfo() async {
    return getLevelInfoFromXP(await getXP());
  }

  static Future<List<UserBadge>> getBadges() async {
    final prefs = await SharedPreferences.getInstance();
    final progresses = await getAllChapterProgresses();
    final streak = await getStreak();
    final xp = await getXP();

    final visitedLessons = progresses.entries.fold<int>(
      0,
      (sum, entry) =>
          sum + (prefs.getStringList('ch_${entry.key}_visited') ?? []).length,
    );
    final quizCompleted = prefs
        .getKeys()
        .where((key) => key.endsWith('_quiz_completed'))
        .where((key) => prefs.getBool(key) == true)
        .length;
    final perfectQuizzes = prefs
        .getKeys()
        .where((key) => key.endsWith('_quiz_best_score'))
        .map((key) => prefs.getInt(key) ?? 0)
        .where((score) => score == 100)
        .length;
    final reviewedFlashcards = prefs
        .getKeys()
        .where((key) => key.endsWith('_flashcards_reviewed'))
        .where((key) => prefs.getBool(key) == true)
        .length;
    final completedChapters =
        progresses.values.where((progress) => progress >= 1.0).length;
    final totalMinutes =
        ((prefs.getInt('total_time_seconds') ?? 0) / 60).floor();

    return [
      UserBadge(
        id: 'first_lesson',
        title: 'Premier pas',
        description: 'Visiter une première leçon',
        emoji: '🌱',
        unlocked: visitedLessons >= 1,
      ),
      UserBadge(
        id: 'first_quiz',
        title: 'Quiz validé',
        description: 'Réussir un quiz de leçon',
        emoji: '🧠',
        unlocked: quizCompleted >= 1,
      ),
      UserBadge(
        id: 'perfect_score',
        title: 'Score parfait',
        description: 'Obtenir 100% à un quiz',
        emoji: '🎯',
        unlocked: perfectQuizzes >= 1,
      ),
      UserBadge(
        id: 'chapter_master',
        title: 'Chapitre bouclé',
        description: 'Compléter un chapitre',
        emoji: '🏁',
        unlocked: completedChapters >= 1,
      ),
      UserBadge(
        id: 'streak_7',
        title: 'Régulier',
        description: 'Maintenir 7 jours de streak',
        emoji: '🔥',
        unlocked: streak >= 7,
      ),
      UserBadge(
        id: 'focused_reviewer',
        title: 'Réviseur',
        description: 'Réviser 5 leçons en flashcards',
        emoji: '🎴',
        unlocked: reviewedFlashcards >= 5,
      ),
      UserBadge(
        id: 'xp_500',
        title: 'Montée en puissance',
        description: 'Atteindre 500 XP',
        emoji: '⚡',
        unlocked: xp >= 500,
      ),
      UserBadge(
        id: 'time_60',
        title: 'Une heure de pratique',
        description: 'Cumuler 60 minutes d’étude',
        emoji: '⏱️',
        unlocked: totalMinutes >= 60,
      ),
      UserBadge(
        id: 'chapter_exam',
        title: 'Mini examen',
        description: 'Réussir un mini examen de chapitre',
        emoji: '📘',
        unlocked: prefs.getKeys().any(
              (key) =>
                  key.startsWith('chapter_exam_') &&
                  key.endsWith('_completed') &&
                  prefs.getBool(key) == true,
            ),
      ),
      UserBadge(
        id: 'final_exam',
        title: 'Examen final',
        description: 'Réussir l’examen final',
        emoji: '🏆',
        unlocked: prefs.getBool('final_exam_completed') ?? false,
      ),
    ];
  }

  static Future<ProfileStats> getProfileStats() async {
    final prefs = await SharedPreferences.getInstance();
    final xp = await getXP();
    final streak = await getStreak();
    final levelInfo = getLevelInfoFromXP(xp);
    final badges = await getBadges();
    final progresses = await getAllChapterProgresses();

    final completedLessons = progresses.entries.fold<int>(
      0,
      (sum, entry) =>
          sum + (prefs.getStringList('ch_${entry.key}_visited') ?? []).length,
    );
    final quizScores = prefs
        .getKeys()
        .where((key) => key.endsWith('_quiz_best_score'))
        .map((key) => prefs.getInt(key) ?? 0)
        .toList();
    final completedQuizzes = prefs
        .getKeys()
        .where((key) => key.endsWith('_quiz_completed'))
        .where((key) => prefs.getBool(key) == true)
        .length;
    final perfectQuizzes = quizScores.where((score) => score == 100).length;
    final flashcardsReviewed = prefs
        .getKeys()
        .where((key) => key.endsWith('_flashcards_reviewed'))
        .where((key) => prefs.getBool(key) == true)
        .length;

    return ProfileStats(
      xp: xp,
      streak: streak,
      levelInfo: levelInfo,
      totalSessions: prefs.getInt('lesson_session_count') ?? 0,
      totalMinutes: ((prefs.getInt('total_time_seconds') ?? 0) / 60).floor(),
      completedLessons: completedLessons,
      completedQuizzes: completedQuizzes,
      perfectQuizzes: perfectQuizzes,
      bestQuizScore:
          quizScores.isEmpty ? 0 : quizScores.reduce((a, b) => a > b ? a : b),
      flashcardsReviewed: flashcardsReviewed,
      badges: badges,
    );
  }

  // ── Cas cliniques ───────────────────────────────────────────────────────

  static String _clinicalCaseBestScoreKey(String caseId) =>
      'clinical_case_${caseId}_best_score';

  static String _clinicalCaseCompletedKey(String caseId) =>
      'clinical_case_${caseId}_completed';

  static Future<int> getClinicalCaseBestScore(String caseId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_clinicalCaseBestScoreKey(caseId)) ?? 0;
  }

  static Future<Map<String, int>> getClinicalCaseBestScores() async {
    final prefs = await SharedPreferences.getInstance();
    final scores = <String, int>{};
    for (final key in prefs.getKeys()) {
      if (key.startsWith('clinical_case_') && key.endsWith('_best_score')) {
        final caseId = key
            .replaceFirst('clinical_case_', '')
            .replaceFirst('_best_score', '');
        scores[caseId] = prefs.getInt(key) ?? 0;
      }
    }
    return scores;
  }

  static Future<int> completeClinicalCase(
    String caseId,
    int score, {
    required int passingScore,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final bestKey = _clinicalCaseBestScoreKey(caseId);
    final completedKey = _clinicalCaseCompletedKey(caseId);
    final currentBest = prefs.getInt(bestKey) ?? 0;

    if (score > currentBest) {
      await prefs.setInt(bestKey, score);
    }

    var xpGained = 0;
    if (score >= passingScore) {
      final alreadyCompleted = prefs.getBool(completedKey) ?? false;
      if (!alreadyCompleted) {
        xpGained = 25;
        await _addXP(xpGained);
        await prefs.setBool(completedKey, true);
      }
      await updateStreak();
    }

    return xpGained;
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  static Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().toList();
    for (final key in keys) {
      if (key.startsWith('ch_')) {
        await prefs.remove(key);
      }
      if (key.startsWith('chapter_exam_') || key.startsWith('final_exam_')) {
        await prefs.remove(key);
      }
      if (key.startsWith('weekly_') || key.startsWith('session_')) {
        await prefs.remove(key);
      }
      if (key.startsWith('clinical_case_')) {
        await prefs.remove(key);
      }
    }
    await prefs.setInt('total_xp', 0);
    await prefs.setInt('streak', 0);
    await prefs.remove('last_active_date');
  }
}
