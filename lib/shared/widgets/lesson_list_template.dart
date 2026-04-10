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

  // ── Header avec bannière colorée ─────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.accentColor,
            widget.accentColor.withOpacity(0.75),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
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
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Chapitre ${widget.chapterNumber}',
                  style: AppText.labelS.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.chapterTitleFR,
                style: AppText.h2.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.chapterTitleDE,
                style: AppText.bodyM.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 18),
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
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.fact_check_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lancer le mini examen',
                              style:
                                  AppText.labelL.copyWith(color: Colors.white),
                            ),
                            Text(
                              completed
                                  ? 'Meilleur score: $bestScore%'
                                  : '8 questions dérivées des leçons du chapitre',
                              style: AppText.bodyS.copyWith(
                                color: Colors.white.withOpacity(0.84),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
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
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: kBorder),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Numéro de leçon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accentLight,
                borderRadius: BorderRadius.circular(13),
              ),
              alignment: Alignment.center,
              child: Text(
                '${index + 1}',
                style: AppText.h3.copyWith(
                  fontSize: 18,
                  color: accentColor,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Texte
            Expanded(
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
                    const SizedBox(height: 4),
                    Text(
                      entry.description,
                      style: AppText.bodyS.copyWith(fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
