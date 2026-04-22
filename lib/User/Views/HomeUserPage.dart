import 'package:flutter/material.dart';
import 'package:projet2/User/Widget/Drawer.dart';
import 'package:projet2/User/Widget/Widget.dart';
import 'package:projet2/User/Widget/chapter_catalog.dart';
import 'package:projet2/core/services/challenge_service.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/features/challenges/challenge_navigation.dart';
import 'package:projet2/features/challenges/weekly_challenges_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _userName = 'Apprenant';
  LevelInfo _levelInfo = ProgressService.getLevelInfoFromXP(0);
  int _streak = 0;
  String _lastActiveDate = '';
  Map<int, double> _chapterProgresses = const {};
  List<WeeklyChallenge> _weeklyChallenges = const [];

  late final List<ChapterData> _allChapters = buildStudentChapters();

  ChapterData? get _currentChapter {
    ChapterData? best;
    double bestProgress = 0;
    for (final c in _allChapters) {
      if (c.isComingSoon) continue;
      final p = _chapterProgresses[c.number] ?? 0;
      if (p > 0 && p < 1 && p > bestProgress) {
        bestProgress = p;
        best = c;
      }
    }
    if (best != null) return best;
    for (final c in _allChapters) {
      if (!c.isComingSoon && (_chapterProgresses[c.number] ?? 0) == 0) {
        return c;
      }
    }
    return null;
  }

  List<bool> _getWeekActiveDays() {
    final today = DateTime.now();
    final result = List.filled(7, false);
    if (_lastActiveDate.isEmpty || _streak == 0) return result;
    final isActiveToday =
        _lastActiveDate == today.toIso8601String().substring(0, 10);
    final startOffset = isActiveToday ? 0 : 1;
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    for (int i = startOffset; i < startOffset + _streak && i < 14; i++) {
      final activeDay = today.subtract(Duration(days: i));
      if (!activeDay.isBefore(startOfWeek)) {
        result[activeDay.weekday - 1] = true;
      }
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final xp = await ProgressService.getXP();
    final streak = await ProgressService.getStreak();
    final progresses = await ProgressService.getAllChapterProgresses();
    final weeklyChallenges = await ChallengeService.getWeeklyChallenges();
    final levelInfo = ProgressService.getLevelInfoFromXP(xp);
    if (!mounted) return;
    setState(() {
      _userName = prefs.getString('name') ?? 'Apprenant';
      _levelInfo = levelInfo;
      _streak = streak;
      _lastActiveDate = prefs.getString('last_active_date') ?? '';
      _chapterProgresses = progresses;
      _weeklyChallenges = weeklyChallenges;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kScaffold,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      isWide ? 28 : 20,
                      20,
                      isWide ? 28 : 20,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 20),
                        _buildXPBar(),
                        const SizedBox(height: 24),
                        _buildStreakSection(),
                        const SizedBox(height: 20),
                        _buildContinueCard(),
                        const SizedBox(height: 24),
                        _buildSectionTitle(),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      isWide ? 28 : 20,
                      0,
                      isWide ? 28 : 20,
                      24,
                    ),
                    child: _buildWeeklyChallengesSection(isWide),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    final initials = _userName.isNotEmpty ? _userName[0].toUpperCase() : 'A';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: kFlagBlack,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              initials,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: kFlagGold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bonjour, $_userName',
                style: AppText.h1.copyWith(fontSize: 21),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _Pill(
                      label: 'Niv. ${_levelInfo.level}',
                      bg: kInk100,
                      fg: kInk700),
                  if (_streak > 0) ...[
                    const SizedBox(width: 6),
                    _Pill(
                      label: '🔥 $_streak jours',
                      bg: const Color(0xFFFFF4D2),
                      fg: const Color(0xFF7A4A00),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kBorder),
              boxShadow: const [
                BoxShadow(color: kShadow, blurRadius: 16, offset: Offset(0, 6)),
              ],
            ),
            child:
                const Icon(Icons.grid_view_rounded, color: kInk900, size: 20),
          ),
        ),
      ],
    );
  }

  // ── Barre XP ──────────────────────────────────────────────────────────────

  Widget _buildXPBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder),
        boxShadow: const [
          BoxShadow(color: kShadow, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.star_rounded, color: kFlagGold, size: 15),
              const SizedBox(width: 5),
              Text(
                '${_levelInfo.currentXP} XP',
                style: AppText.labelM.copyWith(
                  color: kInk900,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${_levelInfo.xpToNextLevel} XP → Niv. ${_levelInfo.level + 1}',
                style: AppText.bodyS.copyWith(color: kInk500, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: _levelInfo.progress,
              minHeight: 7,
              backgroundColor: kInk100,
              valueColor: const AlwaysStoppedAnimation<Color>(kFlagGold),
            ),
          ),
        ],
      ),
    );
  }

  // ── Tracker jours ─────────────────────────────────────────────────────────

  Widget _buildStreakSection() {
    final todayIdx = DateTime.now().weekday - 1;
    final activeDays = _getWeekActiveDays();
    const labels = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('Ta serie', style: AppText.h2.copyWith(fontSize: 17)),
            const SizedBox(width: 10),
            Text(
              _streak > 0
                  ? '$_streak jours consecutifs'
                  : 'Commence aujourd\'hui',
              style: AppText.bodyS.copyWith(color: kInk500, fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (i) {
            final isActive = activeDays[i];
            final isToday = i == todayIdx;

            Color bg;
            Color fg;
            Border? border;
            const double radius = 12;

            if (isActive) {
              bg = kCoral;
              fg = Colors.white;
            } else if (isToday) {
              bg = Colors.transparent;
              fg = kFlagRed;
              border = Border.all(color: kFlagRed, width: 1.5);
            } else {
              bg = kSurface;
              fg = kInk500;
              border = Border.all(color: kBorder);
            }

            return Container(
              width: 38,
              height: 42,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(radius),
                border: border,
              ),
              child: Center(
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: fg,
                    fontSize: 13,
                    fontWeight:
                        isActive || isToday ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ── Card "Continuer" ──────────────────────────────────────────────────────

  Widget _buildContinueCard() {
    final chapter = _currentChapter;
    if (chapter == null) return const SizedBox.shrink();

    final progress = _chapterProgresses[chapter.number] ?? 0;
    final isStarted = progress > 0;

    return GestureDetector(
      onTap: chapter.page == null
          ? null
          : () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => chapter.page!),
              ).then((_) => _loadUserData()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;
          final imageWidth = cardWidth * 0.36;
          final contentPadRight = imageWidth + 8;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // ── Corps de la card ──────────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(18, 20, contentPadRight, 20),
                decoration: BoxDecoration(
                  color: kFlagBlack,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.22),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Chip statut
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        isStarted ? 'EN COURS' : 'À COMMENCER',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Titre FR
                    Text(
                      chapter.titleFR,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Titre DE
                    Text(
                      chapter.titleDE,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white.withValues(alpha: 0.50),
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.12),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(kFlagGold),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // % + flèche
                    Row(
                      children: [
                        Text(
                          '${(progress * 100).round()}% complété',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white.withValues(alpha: 0.45),
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Image promo ───────────────────────────────────────
              Positioned(
                right: 0,
                top: -32,
                bottom: 0,
                width: imageWidth,
                child: Image.asset(
                  'assets/img/promo_card.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CETTE SEMAINE',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: kInk500,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 5),
              Text('Défis hebdo', style: AppText.h2),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: const BoxDecoration(
            color: kInk100,
            borderRadius: BorderRadius.all(Radius.circular(9)),
          ),
          child: Text(
            '$_weeklyCompleted/${_weeklyChallenges.length}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: kInk700,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  int get _weeklyCompleted =>
      _weeklyChallenges.where((challenge) => challenge.isCompleted).length;

  Widget _buildWeeklyChallengesSection(bool isWide) {
    if (_weeklyChallenges.isEmpty) {
      return _buildWeeklySummaryCard();
    }

    final preview = _weeklyChallenges.take(3).toList();
    final cardWidth = isWide ? 320.0 : double.infinity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: preview
              .map(
                (challenge) => SizedBox(
                  width: cardWidth,
                  child: _WeeklyChallengeHomeCard(challenge: challenge),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildWeeklySummaryCard() {
    final total = _weeklyChallenges.length;
    final completed = _weeklyCompleted;
    final progress = total == 0 ? 0.0 : completed / total;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WeeklyChallengesPage()),
      ).then((_) => _loadUserData()),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kFlagBlack,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── En-tête ──────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: const Icon(
                    Icons.flag_rounded,
                    color: kFlagGold,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Progression hebdomadaire',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$completed / $total défis complétés',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white.withValues(alpha: 0.50),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.north_east_rounded,
                  color: kFlagGold,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Barre de progression ──────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.white.withValues(alpha: 0.12),
                valueColor: const AlwaysStoppedAnimation<Color>(kFlagGold),
              ),
            ),
            const SizedBox(height: 10),

            // ── Pourcentage ───────────────────────────────────────
            Text(
              '${(progress * 100).round()}% accompli cette semaine',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;

  const _Pill({required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: fg,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _WeeklyChallengeHomeCard extends StatelessWidget {
  final WeeklyChallenge challenge;

  const _WeeklyChallengeHomeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final bool isDone = challenge.isCompleted;

    final Color ringColor = isDone ? kGreenSuccess : kFlagGold;
    final Color badgeBg = isDone ? kGreenSuccessLight : kPeachLight;
    final Color badgeFg = isDone ? kGreenSuccess : const Color(0xFF7A4A00);
    final String statusLabel = isDone ? 'Terminé' : 'En cours';

    return GestureDetector(
      onTap: () => ChallengeNavigation.openChallenge(context, challenge),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDone ? kGreenSuccess.withValues(alpha: 0.35) : kBorder,
          ),
          boxShadow: const [
            BoxShadow(color: kShadow, blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            // ── Anneau ───────────────────────────────────────────
            SizedBox(
              width: 52,
              height: 52,
              child: CustomPaint(
                painter: _RingPainter(
                  progress: challenge.ratio,
                  ringColor: ringColor,
                  trackColor: kInk100,
                  strokeWidth: 5,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // ── Titre + description ───────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.labelL,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    challenge.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bodyS.copyWith(color: kInk500),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // ── Badges droite ─────────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Progression chiffrée
                Text(
                  '${challenge.progress}/${challenge.target}',
                  style: AppText.labelM.copyWith(color: ringColor),
                ),
                const SizedBox(height: 6),
                // Badge statut
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: badgeFg,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Painter anneau ────────────────────────────────────────────────────────────
class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.ringColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color ringColor;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -1.5708; // départ en haut

    // Track
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

    // Fill
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
