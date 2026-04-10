import 'package:flutter/material.dart';
import 'package:projet2/core/data/exam_catalog.dart';
import 'package:projet2/core/services/challenge_service.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/User/Widget/Widget.dart';
import 'package:projet2/User/Widget/Drawer.dart';
import 'package:projet2/features/clinical_cases/clinical_cases_page.dart';
import 'package:projet2/features/challenges/weekly_challenges_page.dart';
import 'package:projet2/features/conversation/conversation_drills_page.dart';
import 'package:projet2/features/exams/exam_page.dart';
import 'package:projet2/features/expressions/professional_expressions_page.dart';

import '../Chapitre/1/liste lecon chapitre1.dart';
import '../Chapitre/2/List Lesson Chaiptre 2.dart';
import '../Chapitre/3/List Lesson 3.dart';
import '../Chapitre/4/Liste Lecons 4.dart';
import '../Chapitre/5/Liste des Lessons 5.dart';
import '../Chapitre/6/List cours 6.dart';
import '../Chapitre/7/Liste Lesson 7.dart';
import '../Chapitre/8/List Lesson Page 8.dart';
import '../Chapitre/9/Liste lesson 9.dart';
import '../Chapitre/10/Lesson List 10.dart';
import '../Chapitre/11/List Lesson 11.dart';

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
  int _streak = 0;
  int _xp = 0;
  int _level = 1;
  Map<int, double> _chapterProgresses = const {};
  int _completedWeeklyChallenges = 0;
  int _totalWeeklyChallenges = 3;
  String _nextWeeklyChallenge = 'Réussir 3 quiz';
  int _finalExamBestScore = 0;

  // ── Données de tous les chapitres ────────────────────────────────────────
  late final List<ChapterData> _allChapters = [
    ChapterData(
      number: 1,
      titleFR: "L'admission d'un patient",
      titleDE: "Die Aufnahme eines Patienten",
      accentColor: kBlue,
      accentLight: kBlueLight,
      icon: Icons.assignment_ind_outlined,
      page: const LessonListPage(),
    ),
    ChapterData(
      number: 2,
      titleFR: "La mesure des paramètres",
      titleDE: "Die Messung der Parameter",
      accentColor: kGreen,
      accentLight: kGreenLight,
      icon: Icons.monitor_heart_outlined,
      page: const LessonListPage2(),
    ),
    ChapterData(
      number: 3,
      titleFR: "Manger – boire – éliminer",
      titleDE: "Essen – trinken – ausscheiden",
      accentColor: kPurple,
      accentLight: kPurpleLight,
      icon: Icons.restaurant_outlined,
      page: const LessonListPage3(),
    ),
    ChapterData(
      number: 4,
      titleFR: "Les soins d'hygiène",
      titleDE: "Die Grundpflege",
      accentColor: kPeach,
      accentLight: kPeachLight,
      icon: Icons.clean_hands_outlined,
      page: const LessonList4Page(),
    ),
    ChapterData(
      number: 5,
      titleFR: "La physiopathologie",
      titleDE: "Die Pathophysiologie",
      accentColor: kCoral,
      accentLight: kCoralLight,
      icon: Icons.biotech_outlined,
      page: const LessonList5Page(),
    ),
    ChapterData(
      number: 6,
      titleFR: "Les examens complémentaires",
      titleDE: "Die Untersuchungen",
      accentColor: kYellow,
      accentLight: kYellowLight,
      icon: Icons.science_outlined,
      page: const LessonList6Page(),
    ),
    ChapterData(
      number: 7,
      titleFR: "Labo – prélèvement",
      titleDE: "Labor – Entnahme",
      accentColor: kBlue,
      accentLight: kBlueLight,
      icon: Icons.colorize_outlined,
      page: const LessonList7Page(),
    ),
    ChapterData(
      number: 8,
      titleFR: "L'anesthésie & l'opération",
      titleDE: "Die Anästhesie & die Operation",
      accentColor: kGreen,
      accentLight: kGreenLight,
      icon: Icons.local_hospital_outlined,
      page: const LessonList8Page(),
    ),
    ChapterData(
      number: 9,
      titleFR: "Les soins thérapeutiques",
      titleDE: "Die Behandlungspflege",
      accentColor: kPurple,
      accentLight: kPurpleLight,
      icon: Icons.medication_outlined,
      page: const LessonList9Page(),
    ),
    ChapterData(
      number: 10,
      titleFR: "La conduite à tenir en urgence",
      titleDE: "Das Verhalten im Notfall",
      accentColor: kCoral,
      accentLight: kCoralLight,
      icon: Icons.emergency_outlined,
      page: const LessonList10Page(),
    ),
    ChapterData(
      number: 11,
      titleFR: "La sortie & le transfert",
      titleDE: "Die Entlassung & Verlegung",
      accentColor: kPeach,
      accentLight: kPeachLight,
      icon: Icons.transfer_within_a_station_outlined,
      page: const LessonList11Page(),
    ),
    ChapterData(
      number: 12,
      titleFR: "L'anatomie",
      titleDE: "Die Anatomie",
      accentColor: kInk500,
      accentLight: kInk100,
      icon: Icons.accessibility_new_outlined,
      isComingSoon: true,
    ),
    ChapterData(
      number: 13,
      titleFR: "Les abréviations",
      titleDE: "Die Abkürzungen",
      accentColor: kInk500,
      accentLight: kInk100,
      icon: Icons.abc_outlined,
      isComingSoon: true,
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

  // ── Salutation dynamique ─────────────────────────────────────────────────
  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Guten Morgen';
    if (h < 18) return 'Guten Tag';
    return 'Guten Abend';
  }

  String get _greetingEmoji {
    final h = DateTime.now().hour;
    if (h < 12) return '☀️';
    if (h < 18) return '🌤️';
    return '🌙';
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
    final challengeSummary = await ChallengeService.getWeeklySummary();
    final finalExamBestScore = await ProgressService.getFinalExamBestScore();
    final nextChallenge = challengeSummary['next'];
    if (!mounted) return;
    setState(() {
      _userName = prefs.getString('name') ?? 'Apprenant';
      _streak = streak;
      _xp = xp;
      _level = levelInfo.level;
      _chapterProgresses = progresses;
      _completedWeeklyChallenges = challengeSummary['completed'] as int? ?? 0;
      _totalWeeklyChallenges = challengeSummary['total'] as int? ?? 3;
      _nextWeeklyChallenge = nextChallenge is WeeklyChallenge
          ? nextChallenge.description
          : 'Réussir 3 quiz';
      _finalExamBestScore = finalExamBestScore;
    });
  }

  // ── Build principal ──────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kScaffold,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildStatsStrip()),
            SliverToBoxAdapter(child: _buildMvp2Shortcuts()),
            SliverToBoxAdapter(child: _buildMvp3Shortcuts()),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildSectionTitle()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                                    builder: (_) => chapter.page!),
                              ).then((_) => _loadUserData()),
                    );
                  },
                  childCount: _filteredChapters.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 192,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _greetingEmoji,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _greeting,
                      style: AppText.bodyM.copyWith(color: kInk500),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  _userName,
                  style: AppText.h2,
                ),
                const SizedBox(height: 8),
                // Pill "German Language"
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: kBlueLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🇩🇪', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 5),
                      Text(
                        'German Language v2',
                        style: AppText.labelS.copyWith(
                          color: kBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Bouton menu
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: kBorder),
                ),
                child: const Icon(
                  Icons.menu_rounded,
                  color: kInk800,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats strip ──────────────────────────────────────────────────────────
  Widget _buildStatsStrip() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _StatItem(
              icon: Icons.local_fire_department_rounded,
              value: '$_streak',
              label: 'Streak',
              color: kPeach,
            ),
            Container(width: 1, height: 38, color: kBorder),
            _StatItem(
              icon: Icons.bolt_rounded,
              value: '$_xp',
              label: 'XP',
              color: kYellow,
            ),
            Container(width: 1, height: 38, color: kBorder),
            _StatItem(
              icon: Icons.workspace_premium_rounded,
              value: '$_level',
              label: 'Niveau',
              color: kBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMvp2Shortcuts() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WeeklyChallengesPage()),
            ).then((_) => _loadUserData()),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: kBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: kBlueLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.flag_rounded, color: kBlue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Défis hebdomadaires', style: AppText.labelL),
                        Text(
                          '$_completedWeeklyChallenges / $_totalWeeklyChallenges complétés · $_nextWeeklyChallenge',
                          style: AppText.bodyS.copyWith(color: kInk500),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: kInk500),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ExamPage.finalExam(
                  title: 'Examen final',
                  subtitle: 'Révision globale des chapitres 1 à 11',
                  accentColor: kPurple,
                  accentLight: kPurpleLight,
                  phrases: buildFinalExamPool(),
                ),
              ),
            ).then((_) => _loadUserData()),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: kBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: kPurpleLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.workspace_premium_rounded,
                        color: kPurple),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Examen final', style: AppText.labelL),
                        Text(
                          _finalExamBestScore > 0
                              ? 'Meilleur score: $_finalExamBestScore%'
                              : '16 questions mixtes basées sur les leçons existantes',
                          style: AppText.bodyS.copyWith(color: kInk500),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: kInk500),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMvp3Shortcuts() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: SizedBox(
        height: 138,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _ShortcutCard(
              title: 'Fiches de conversation',
              subtitle: 'Admission, douleur, urgence, sortie',
              icon: Icons.chat_bubble_outline_rounded,
              accentColor: kBlue,
              accentLight: kBlueLight,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ConversationDrillsPage()),
              ),
            ),
            const SizedBox(width: 12),
            _ShortcutCard(
              title: 'Expressions pro',
              subtitle: 'Patient, médecin, transmission',
              icon: Icons.record_voice_over_rounded,
              accentColor: kPurple,
              accentLight: kPurpleLight,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfessionalExpressionsPage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            _ShortcutCard(
              title: 'Cas cliniques',
              subtitle: 'Mises en situation courtes',
              icon: Icons.local_hospital_outlined,
              accentColor: kCoral,
              accentLight: kCoralLight,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ClinicalCasesPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Barre de recherche ───────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: TextField(
        controller: _searchController,
        onChanged: (v) => setState(() => _searchQuery = v),
        style: AppText.bodyM.copyWith(color: kInk900),
        decoration: InputDecoration(
          hintText: 'Rechercher un chapitre...',
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 14, right: 8),
            child: Icon(Icons.search_rounded, color: kInk500, size: 20),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.close_rounded, color: kInk500, size: 18),
                  ),
                )
              : null,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
        ),
      ),
    );
  }

  // ── Titre de section ─────────────────────────────────────────────────────
  Widget _buildSectionTitle() {
    final count = _filteredChapters.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
      child: Row(
        children: [
          Text('Chapitres', style: AppText.h3),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: kBlueLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: AppText.caption.copyWith(
                color: kBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat item widget (interne)
// ─────────────────────────────────────────────────────────────────────────────
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 3),
        Text(
          value,
          style: AppText.h3.copyWith(fontSize: 17, color: kInk900),
        ),
        const SizedBox(height: 1),
        Text(label, style: AppText.labelS),
      ],
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final Color accentLight;
  final VoidCallback onTap;

  const _ShortcutCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.accentLight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accentLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accentColor, size: 20),
            ),
            const SizedBox(height: 10),
            Text(title,
                style: AppText.labelL,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 3),
            Expanded(
              child: Text(
                subtitle,
                style: AppText.bodyS.copyWith(
                  color: kInk500,
                  fontSize: 11,
                  height: 1.25,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
