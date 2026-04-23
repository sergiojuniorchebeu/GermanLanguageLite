import 'package:flutter/material.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/theme/colors.dart';

class ChapterLessonListEntry {
  final String title;
  final String description;
  final String image;
  final String lessonId;
  final int requiredXp;
  final Color buttonColor;
  final Widget Function() pageBuilder;

  const ChapterLessonListEntry({
    required this.title,
    required this.description,
    required this.image,
    required this.lessonId,
    required this.requiredXp,
    required this.buttonColor,
    required this.pageBuilder,
  });
}

class ChapterLessonListPage extends StatefulWidget {
  final int chapterNumber;
  final String chapterTitleFR;
  final String chapterTitleDE;
  final List<ChapterLessonListEntry> lessons;

  const ChapterLessonListPage({
    super.key,
    required this.chapterNumber,
    required this.chapterTitleFR,
    required this.chapterTitleDE,
    required this.lessons,
  });

  @override
  State<ChapterLessonListPage> createState() => _ChapterLessonListPageState();
}

class _ChapterLessonListPageState extends State<ChapterLessonListPage> {
  Map<String, Map<String, dynamic>> _lessonStats = const {};
  int _xp = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final xp = await ProgressService.getXP();
    final stats = <String, Map<String, dynamic>>{};

    for (final lesson in widget.lessons) {
      stats[lesson.lessonId] = await ProgressService.getLessonStats(
        widget.chapterNumber,
        lesson.lessonId,
      );
    }

    if (!mounted) return;
    setState(() {
      _xp = xp;
      _lessonStats = stats;
      _isLoading = false;
    });
  }

  bool _isUnlocked(ChapterLessonListEntry lesson) => _xp >= lesson.requiredXp;

  int get _visitedLessonsCount => widget.lessons.where((lesson) {
        final stats =
            _lessonStats[lesson.lessonId] ?? const <String, dynamic>{};
        final quizBest = (stats['quizBestScore'] as int?) ?? 0;
        final flashBest = (stats['flashcardsBestScore'] as int?) ?? 0;
        final quizCompleted = stats['quizCompleted'] == true;
        final flashReviewed = stats['flashcardsReviewed'] == true;
        return quizCompleted || flashReviewed || quizBest > 0 || flashBest > 0;
      }).length;

  int? get _nextRequiredXp {
    for (final lesson in widget.lessons) {
      if (!_isUnlocked(lesson)) return lesson.requiredXp;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: kFlagGold))
            : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: _LessonHero(
                      chapterNumber: widget.chapterNumber,
                      chapterTitleFR: widget.chapterTitleFR,
                      chapterTitleDE: widget.chapterTitleDE,
                      currentXp: _xp,
                      visitedLessons: _visitedLessonsCount,
                      totalLessons: widget.lessons.length,
                      nextRequiredXp: _nextRequiredXp,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final lesson = widget.lessons[index];
                          final stats = _lessonStats[lesson.lessonId] ??
                              const <String, dynamic>{};
                          final unlocked = _isUnlocked(lesson);

                          return _LessonCard(
                            lesson: lesson,
                            stats: stats,
                            isUnlocked: unlocked,
                            onTap: unlocked
                                ? () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => lesson.pageBuilder(),
                                      ),
                                    );
                                    _loadData();
                                  }
                                : null,
                          );
                        },
                        childCount: widget.lessons.length,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _LessonHero extends StatelessWidget {
  final int chapterNumber;
  final String chapterTitleFR;
  final String chapterTitleDE;
  final int currentXp;
  final int visitedLessons;
  final int totalLessons;
  final int? nextRequiredXp;

  const _LessonHero({
    required this.chapterNumber,
    required this.chapterTitleFR,
    required this.chapterTitleDE,
    required this.currentXp,
    required this.visitedLessons,
    required this.totalLessons,
    required this.nextRequiredXp,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalLessons == 0 ? 0.0 : visitedLessons / totalLessons;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kBorder),
                boxShadow: const [
                  BoxShadow(color: kShadow, blurRadius: 10, offset: Offset(0, 3)),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: kInk900,
                size: 18,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Chapitre $chapterNumber',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: kInk500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            chapterTitleFR,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kInk900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            chapterTitleDE,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: kInk500,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: kBorder),
              boxShadow: const [
                BoxShadow(color: kShadow, blurRadius: 10, offset: Offset(0, 3)),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 52,
                  height: 52,
                  child: CustomPaint(
                    painter: _RingPainter(
                      progress: progress,
                      ringColor: kFlagGold,
                      trackColor: kInk100,
                      strokeWidth: 5,
                    ),
                    child: Center(
                      child: Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: kInk900,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progression globale · $currentXp XP',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kInk900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        nextRequiredXp == null
                            ? 'Tous les cours du chapitre sont déverrouillés.'
                            : 'Encore ${nextRequiredXp! - currentXp} XP pour débloquer le prochain cours.',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: kInk500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: kInk100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$visitedLessons/$totalLessons',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: kInk700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final ChapterLessonListEntry lesson;
  final Map<String, dynamic> stats;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const _LessonCard({
    required this.lesson,
    required this.stats,
    required this.isUnlocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final quizCompleted = stats['quizCompleted'] == true;
    final flashcardsReviewed = stats['flashcardsReviewed'] == true;
    final quizBestScore = (stats['quizBestScore'] as int?) ?? 0;
    final flashcardsBestScore = (stats['flashcardsBestScore'] as int?) ?? 0;
    final bestScore =
        quizBestScore > flashcardsBestScore ? quizBestScore : flashcardsBestScore;
    final started =
        quizCompleted || flashcardsReviewed || quizBestScore > 0 || flashcardsBestScore > 0;
    final completed = quizCompleted && flashcardsReviewed;
    final buttonColor = _buttonColor(completed, started);
    final buttonIconColor = completed ? Colors.white : kFlagGold;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: isUnlocked ? 1.0 : 0.52,
        duration: const Duration(milliseconds: 200),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: completed ? lesson.buttonColor.withValues(alpha: 0.35) : kBorder,
              width: completed ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: completed ? lesson.buttonColor.withValues(alpha: 0.12) : kShadow,
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LessonStatusBadge(
                            isUnlocked: isUnlocked,
                            started: started,
                            completed: completed,
                            bestScore: bestScore,
                            requiredXp: lesson.requiredXp,
                            accentColor: lesson.buttonColor,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            lesson.title,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: kInk900,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isUnlocked
                                ? 'Débloqué à ${lesson.requiredXp} XP'
                                : 'Verrouillé jusqu’à ${lesson.requiredXp} XP',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: isUnlocked ? kInk500 : kCoral,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            lesson.description,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: kInk700,
                              height: 1.55,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      height: 110,
                      child: isUnlocked
                          ? _LessonImage(asset: lesson.image, accentColor: lesson.buttonColor)
                          : Container(
                              margin: const EdgeInsets.only(right: 18),
                              decoration: BoxDecoration(
                                color: kInk100,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.lock_rounded,
                                color: kInk500,
                                size: 28,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              if (isUnlocked)
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          completed ? Icons.replay_rounded : Icons.play_arrow_rounded,
                          color: buttonIconColor,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          completed ? 'Revoir' : started ? 'Continuer' : 'Commencer',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
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

  Color _buttonColor(bool completed, bool started) {
    if (completed) return lesson.buttonColor;
    if (started) {
      return Color.lerp(lesson.buttonColor, kFlagBlack, 0.18) ??
          lesson.buttonColor;
    }
    return Color.lerp(lesson.buttonColor, Colors.white, 0.08) ??
        lesson.buttonColor;
  }
}

class _LessonStatusBadge extends StatelessWidget {
  final bool isUnlocked;
  final bool started;
  final bool completed;
  final int bestScore;
  final int requiredXp;
  final Color accentColor;

  const _LessonStatusBadge({
    required this.isUnlocked,
    required this.started,
    required this.completed,
    required this.bestScore,
    required this.requiredXp,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isUnlocked) return _pill('$requiredXp XP', kInk500, kInk100);
    if (completed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded, color: accentColor, size: 12),
            const SizedBox(width: 4),
            Text(
              bestScore > 0 ? '$bestScore% · Terminé' : 'Terminé',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: accentColor,
              ),
            ),
          ],
        ),
      );
    }
    if (started) {
      return _pill(
        bestScore > 0 ? '$bestScore% · En cours' : 'En cours',
        const Color(0xFF7A4A00),
        kPeachLight,
      );
    }
    return _pill('Nouveau', kInk700, kInk100);
  }

  Widget _pill(String label, Color fg, Color bg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: fg,
          ),
        ),
      );
}

class _LessonImage extends StatelessWidget {
  final String asset;
  final Color accentColor;

  const _LessonImage({required this.asset, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.menu_book_rounded,
            color: accentColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color ringColor;
  final Color trackColor;
  final double strokeWidth;

  const _RingPainter({
    required this.progress,
    required this.ringColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -1.5708;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      6.2832,
      false,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        6.2832 * progress,
        false,
        Paint()
          ..color = ringColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.ringColor != ringColor;
}
