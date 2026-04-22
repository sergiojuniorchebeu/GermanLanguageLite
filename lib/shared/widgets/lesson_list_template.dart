import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:projet2/core/data/exam_catalog.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/features/exams/exam_page.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Modèle de donnée — Entrée de leçon
// ─────────────────────────────────────────────────────────────────────────────
class LessonEntry {
  final String title;
  final String description;
  final String image;
  final Widget Function() pageBuilder;

  const LessonEntry({
    required this.title,
    required this.description,
    required this.image,
    required this.pageBuilder,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// LessonListTemplate — Template partagé pour toutes les pages de liste
// ─────────────────────────────────────────────────────────────────────────────
class LessonListTemplate extends StatefulWidget {
  final int chapterNumber;
  final String chapterTitleFR;
  final String chapterTitleDE;
  final Color accentColor;
  final Color accentLight;
  final List<LessonEntry> lessons;

  const LessonListTemplate({
    super.key,
    required this.chapterNumber,
    required this.chapterTitleFR,
    required this.chapterTitleDE,
    required this.accentColor,
    required this.accentLight,
    required this.lessons,
  });

  @override
  State<LessonListTemplate> createState() => _LessonListTemplateState();
}

class _LessonListTemplateState extends State<LessonListTemplate> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late Future<Map<String, dynamic>> _examStatsFuture;

  @override
  void initState() {
    super.initState();
    _examStatsFuture = _loadExamStats();
  }

  List<LessonEntry> get _filtered {
    if (_searchQuery.isEmpty) return widget.lessons;
    final q = _searchQuery.toLowerCase();
    return widget.lessons
        .where((l) => l.title.toLowerCase().contains(q))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> _loadExamStats() async {
    return {
      'bestScore':
          await ProgressService.getChapterExamBestScore(widget.chapterNumber),
      'completed':
          await ProgressService.isChapterExamCompleted(widget.chapterNumber),
    };
  }

  void _refreshExamStats() {
    setState(() {
      _examStatsFuture = _loadExamStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildCountRow()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 380),
                    child: SlideAnimation(
                      verticalOffset: 28,
                      child: FadeInAnimation(
                        child: _LessonCard(
                          entry: _filtered[index],
                          index: index,
                          accentColor: widget.accentColor,
                          accentLight: widget.accentLight,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => _filtered[index].pageBuilder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  childCount: _filtered.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      decoration: const BoxDecoration(
        color: kFlagBlack,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: FutureBuilder<Map<String, dynamic>>(
        future: _examStatsFuture,
        builder: (context, snapshot) {
          final bestScore = (snapshot.data?['bestScore'] as int?) ?? 0;
          final completed = snapshot.data?['completed'] == true;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bouton retour
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // Badge chapitre
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: kFlagGold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: kFlagGold.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Text(
                      'Chapitre ${widget.chapterNumber}',
                      style: AppText.labelS.copyWith(
                        color: kFlagGold,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Titres
              Text(
                widget.chapterTitleFR,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.chapterTitleDE,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),

              // Card mini examen
              GestureDetector(
                onTap: () {
                  final chapterExam = getChapterExamData(widget.chapterNumber);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExamPage.chapter(
                        chapterNumber: widget.chapterNumber,
                        title: 'Mini examen',
                        subtitle: widget.chapterTitleFR,
                        accentColor: chapterExam.accentColor,
                        accentLight: chapterExam.accentLight,
                        phrases: chapterExam.phrases,
                      ),
                    ),
                  ).then((_) => _refreshExamStats());
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kFlagGold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(
                          Icons.fact_check_rounded,
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
                              'Mini examen',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              completed
                                  ? 'Meilleur score : $bestScore%'
                                  : '8 questions du chapitre',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Barre de recherche ───────────────────────────────────────────────────
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextField(
        controller: _searchController,
        onChanged: (v) => setState(() => _searchQuery = v),
        style: AppText.bodyM.copyWith(color: kInk900),
        decoration: InputDecoration(
          hintText: 'Rechercher une leçon...',
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

  // ── Ligne count ──────────────────────────────────────────────────────────
  Widget _buildCountRow() {
    final count = _filtered.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Text('Leçons', style: AppText.h3.copyWith(fontSize: 16)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: widget.accentLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: AppText.caption.copyWith(
                color: widget.accentColor,
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
// Lesson Card interne
// ─────────────────────────────────────────────────────────────────────────────
class _LessonCard extends StatelessWidget {
  final LessonEntry entry;
  final int index;
  final Color accentColor;
  final Color accentLight;
  final VoidCallback onTap;

  const _LessonCard({
    required this.entry,
    required this.index,
    required this.accentColor,
    required this.accentLight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              // Bande colorée gauche
              Container(width: 3, height: 72, color: accentColor),

              // Numéro de leçon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accentLight,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: accentColor,
                    ),
                  ),
                ),
              ),

              // Texte
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.title,
                        style: AppText.labelM.copyWith(
                          color: kInk900,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (entry.description.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          entry.description,
                          style: AppText.bodyS.copyWith(
                            fontSize: 11,
                            color: kInk500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
