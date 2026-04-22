import 'package:flutter/material.dart';
import 'package:projet2/User/Widget/Drawer.dart';
import 'package:projet2/User/Widget/Widget.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Chapitre/1/liste lecon chapitre1.dart';
import '../Chapitre/10/Lesson List 10.dart';
import '../Chapitre/11/List Lesson 11.dart';
import '../Chapitre/2/List Lesson Chaiptre 2.dart';
import '../Chapitre/3/List Lesson 3.dart';
import '../Chapitre/4/Liste Lecons 4.dart';
import '../Chapitre/5/Liste des Lessons 5.dart';
import '../Chapitre/6/List cours 6.dart';
import '../Chapitre/7/Liste Lesson 7.dart';
import '../Chapitre/8/List Lesson Page 8.dart';
import '../Chapitre/9/Liste lesson 9.dart';

import 'package:flutter/material.dart';
import 'package:projet2/User/Widget/Drawer.dart';
import 'package:projet2/User/Widget/Widget.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Chapitre/1/liste lecon chapitre1.dart';
import '../Chapitre/10/Lesson List 10.dart';
import '../Chapitre/11/List Lesson 11.dart';
import '../Chapitre/2/List Lesson Chaiptre 2.dart';
import '../Chapitre/3/List Lesson 3.dart';
import '../Chapitre/4/Liste Lecons 4.dart';
import '../Chapitre/5/Liste des Lessons 5.dart';
import '../Chapitre/6/List cours 6.dart';
import '../Chapitre/7/Liste Lesson 7.dart';
import '../Chapitre/8/List Lesson Page 8.dart';
import '../Chapitre/9/Liste lesson 9.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  String _userName = 'Apprenant';
  String _searchQuery = '';
  LevelInfo _levelInfo = ProgressService.getLevelInfoFromXP(0);
  int _streak = 0;
  String _lastActiveDate = '';
  Map<int, double> _chapterProgresses = const {};

  late final List<ChapterData> _allChapters = [
    const ChapterData(
      number: 1,
      titleFR: "L'admission d'un patient",
      titleDE: 'Die Aufnahme eines Patienten',
      accentColor: kBlue,
      accentLight: kBlueLight,
      icon: Icons.assignment_ind_outlined,
      page: LessonListPage(),
      //imagePath: 'assets/img/scrub.png',
    ),
    const ChapterData(
      number: 2,
      titleFR: 'La mesure des parametres',
      titleDE: 'Die Messung der Parameter',
      accentColor: kGreen,
      accentLight: kGreenLight,
      icon: Icons.monitor_heart_outlined,
      page: LessonListPage2(),
      //imagePath: 'assets/img/ch2.png',
    ),
    const ChapterData(
      number: 3,
      titleFR: 'Manger - boire - eliminer',
      titleDE: 'Essen - trinken - ausscheiden',
      accentColor: kPurple,
      accentLight: kPurpleLight,
      icon: Icons.restaurant_outlined,
      page: LessonListPage3(),
      //imagePath: 'assets/img/ch3.png',
    ),
    const ChapterData(
      number: 4,
      titleFR: "Les soins d'hygiene",
      titleDE: 'Die Grundpflege',
      accentColor: kPeach,
      accentLight: kPeachLight,
      icon: Icons.clean_hands_outlined,
      page: LessonList4Page(),
      //imagePath: 'assets/img/ch4.png',
    ),
    const ChapterData(
      number: 5,
      titleFR: 'La physiopathologie',
      titleDE: 'Die Pathophysiologie',
      accentColor: kCoral,
      accentLight: kCoralLight,
      icon: Icons.biotech_outlined,
      page: LessonList5Page(),
      //imagePath: 'assets/img/ch5.png',
    ),
    const ChapterData(
      number: 6,
      titleFR: 'Les examens complementaires',
      titleDE: 'Die Untersuchungen',
      accentColor: kYellow,
      accentLight: kYellowLight,
      icon: Icons.science_outlined,
      page: LessonList6Page(),
      //imagePath: 'assets/img/ch6.png',
    ),
    const ChapterData(
      number: 7,
      titleFR: 'Labo - prelevement',
      titleDE: 'Labor - Entnahme',
      accentColor: kBlue,
      accentLight: kBlueLight,
      icon: Icons.colorize_outlined,
      page: LessonList7Page(),
      //imagePath: 'assets/img/ch7.png',
    ),
    const ChapterData(
      number: 8,
      titleFR: "L'anesthesie & l'operation",
      titleDE: 'Die Anasthesie & die Operation',
      accentColor: kGreen,
      accentLight: kGreenLight,
      icon: Icons.local_hospital_outlined,
      page: LessonList8Page(),
      //imagePath: 'assets/img/ch8.png',
    ),
    const ChapterData(
      number: 9,
      titleFR: 'Les soins therapeutiques',
      titleDE: 'Die Behandlungspflege',
      accentColor: kPurple,
      accentLight: kPurpleLight,
      icon: Icons.medication_outlined,
      page: LessonList9Page(),
      //imagePath: 'assets/img/ch9.png',
    ),
    const ChapterData(
      number: 10,
      titleFR: 'La conduite a tenir en urgence',
      titleDE: 'Das Verhalten im Notfall',
      accentColor: kCoral,
      accentLight: kCoralLight,
      icon: Icons.emergency_outlined,
      page: LessonList10Page(),
      //imagePath: 'assets/img/ch10.png',
    ),
    const ChapterData(
      number: 11,
      titleFR: 'La sortie & le transfert',
      titleDE: 'Die Entlassung & Verlegung',
      accentColor: kPeach,
      accentLight: kPeachLight,
      icon: Icons.transfer_within_a_station_outlined,
      page: LessonList11Page(),
      //imagePath: 'assets/img/ch11.png',
    ),
    const ChapterData(
      number: 12,
      titleFR: "L'anatomie",
      titleDE: 'Die Anatomie',
      accentColor: kInk500,
      accentLight: kInk100,
      icon: Icons.accessibility_new_outlined,
      isComingSoon: true,
      //imagePath: 'assets/img/ch12.png',
    ),
    const ChapterData(
      number: 13,
      titleFR: 'Les abreviations',
      titleDE: 'Die Abkurzungen',
      accentColor: kInk500,
      accentLight: kInk100,
      icon: Icons.abc_outlined,
      isComingSoon: true,
      //imagePath: 'assets/img/ch13.png',
    ),
  ];

  List<ChapterData> get _filteredChapters {
    if (_searchQuery.isEmpty) return _allChapters;
    final q = _searchQuery.toLowerCase();
    return _allChapters
        .where(
          (c) =>
      c.titleFR.toLowerCase().contains(q) ||
          c.titleDE.toLowerCase().contains(q),
    )
        .toList();
  }

  int get _completedCount =>
      _chapterProgresses.values.where((v) => v >= 1).length;

  int get _startedCount =>
      _chapterProgresses.values.where((v) => v > 0).length;

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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final xp = await ProgressService.getXP();
    final streak = await ProgressService.getStreak();
    final progresses = await ProgressService.getAllChapterProgresses();
    final levelInfo = ProgressService.getLevelInfoFromXP(xp);
    if (!mounted) return;
    setState(() {
      _userName = prefs.getString('name') ?? 'Apprenant';
      _levelInfo = levelInfo;
      _streak = streak;
      _lastActiveDate = prefs.getString('last_active_date') ?? '';
      _chapterProgresses = progresses;
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
            final crossAxisCount = isWide ? 3 : 2;
            final cardExtent = isWide ? 226.0 : 214.0;

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
                        const SizedBox(height: 20),
                        _buildSearchBar(),
                        const SizedBox(height: 24),
                        _buildSectionTitle(),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    isWide ? 28 : 20,
                    0,
                    isWide ? 28 : 20,
                    24,
                  ),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final chapter = _filteredChapters[index];
                        return ChapterCard(
                          chapter: chapter,
                          progress: _chapterProgresses[chapter.number] ?? 0,
                          onTap: chapter.page == null
                              ? null
                              : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => chapter.page!,
                            ),
                          ).then((_) => _loadUserData()),
                        );
                      },
                      childCount: _filteredChapters.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      mainAxisExtent: cardExtent,
                    ),
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
                BoxShadow(
                    color: kShadow, blurRadius: 16, offset: Offset(0, 6)),
              ],
            ),
            child: const Icon(Icons.grid_view_rounded,
                color: kInk900, size: 20),
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
              bg = kFlagGold;
              fg = kFlagBlack;
            } else if (isToday) {
              bg = Colors.transparent;
              fg = kFlagGold;
              border = Border.all(color: kFlagGold, width: 1.5);
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
                    fontWeight: isActive || isToday
                        ? FontWeight.w700
                        : FontWeight.w400,
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
                        backgroundColor:
                        Colors.white.withValues(alpha: 0.12),
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

  // ── Barre de recherche ────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder),
        boxShadow: const [
          BoxShadow(color: kShadow, blurRadius: 16, offset: Offset(0, 6)),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        style: AppText.bodyM.copyWith(color: kInk900),
        decoration: InputDecoration(
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Rechercher un chapitre...',
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 14, right: 8),
            child: Icon(Icons.search_rounded, color: kInk500, size: 20),
          ),
          prefixIconConstraints:
          const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: _searchQuery.isEmpty
              ? Container(
            margin: const EdgeInsets.only(right: 6),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: kSurfaceMuted,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune_rounded,
                color: kInk800, size: 17),
          )
              : GestureDetector(
            onTap: () {
              _searchController.clear();
              setState(() => _searchQuery = '');
            },
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: kSurfaceMuted,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.close_rounded,
                  color: kInk800, size: 17),
            ),
          ),
          suffixIconConstraints:
          const BoxConstraints(minWidth: 0, minHeight: 0),
        ),
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
                'PARCOURS',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: kInk500,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 5),
              Text('Chapitres essentiels', style: AppText.h2),
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
            '${_filteredChapters.length}',
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.accent,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 17),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: kInk900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppText.bodyS.copyWith(color: kInk600, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
