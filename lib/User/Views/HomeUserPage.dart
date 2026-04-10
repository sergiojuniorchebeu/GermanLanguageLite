import 'package:flutter/material.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/User/Widget/Widget.dart';
import 'package:projet2/User/Widget/Drawer.dart';

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
  int _level = 1;
  Map<int, double> _chapterProgresses = const {};

  // ── Données de tous les chapitres ────────────────────────────────────────
  late final List<ChapterData> _allChapters = [
    const ChapterData(
      number: 1,
      titleFR: "L'admission d'un patient",
      titleDE: "Die Aufnahme eines Patienten",
      accentColor: kBlue,
      accentLight: kBlueLight,
      icon: Icons.assignment_ind_outlined,
      page: LessonListPage(),
    ),
    const ChapterData(
      number: 2,
      titleFR: "La mesure des paramètres",
      titleDE: "Die Messung der Parameter",
      accentColor: kGreen,
      accentLight: kGreenLight,
      icon: Icons.monitor_heart_outlined,
      page: LessonListPage2(),
    ),
    const ChapterData(
      number: 3,
      titleFR: "Manger – boire – éliminer",
      titleDE: "Essen – trinken – ausscheiden",
      accentColor: kPurple,
      accentLight: kPurpleLight,
      icon: Icons.restaurant_outlined,
      page: LessonListPage3(),
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
    final progresses = await ProgressService.getAllChapterProgresses();
    final levelInfo = ProgressService.getLevelInfoFromXP(xp);
    if (!mounted) return;
    setState(() {
      _userName = prefs.getString('name') ?? 'Apprenant';
      _level = levelInfo.level;
      _chapterProgresses = progresses;
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
            SliverToBoxAdapter(child: _buildPromoCard()),
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
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Allemand médical',
                  style: AppText.labelS.copyWith(
                    color: kBlue,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userName,
                  style: AppText.h2,
                ),
                const SizedBox(height: 6),
                Text(
                  'Révision ciblée, examens et pratique clinique.',
                  style: AppText.bodyS.copyWith(color: kInk500),
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

  Widget _buildPromoCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kBlue, kPurple],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: kBlue.withOpacity(0.14),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Niveau $_level',
                      style: AppText.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Pratique ton allemand médical',
                    style: AppText.h3.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Retrouve les chapitres et les exercices depuis le menu.',
                    style: AppText.bodyS.copyWith(
                      color: Colors.white.withOpacity(0.82),
                      height: 1.35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AspectRatio(
                aspectRatio: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      'assets/img/online-course.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
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
