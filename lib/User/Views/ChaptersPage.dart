import 'package:flutter/material.dart';
import 'package:projet2/User/Widget/Widget.dart';
import 'package:projet2/User/Widget/chapter_catalog.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';

class ChaptersPage extends StatefulWidget {
  const ChaptersPage({super.key});

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  final _searchController = TextEditingController();

  late final List<ChapterData> _chapters = buildStudentChapters();
  Map<int, double> _chapterProgresses = const {};
  String _searchQuery = '';

  List<ChapterData> get _filteredChapters {
    if (_searchQuery.isEmpty) return _chapters;
    final query = _searchQuery.toLowerCase();
    return _chapters
        .where(
          (chapter) =>
              chapter.titleFR.toLowerCase().contains(query) ||
              chapter.titleDE.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProgress() async {
    final progresses = await ProgressService.getAllChapterProgresses();
    if (!mounted) return;
    setState(() => _chapterProgresses = progresses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
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
                        Text(
                          'Chapitres',
                          style: AppText.h1.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tous les modules sont regroupes ici pour reprendre rapidement ton parcours.',
                          style: AppText.bodyM.copyWith(color: kInk500),
                        ),
                        const SizedBox(height: 24),
                        _buildSearchBar(),
                        const SizedBox(height: 24),
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
                                  ).then((_) => _loadProgress()),
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
              ],
            );
          },
        ),
      ),
    );
  }

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
                  child:
                      const Icon(Icons.tune_rounded, color: kInk800, size: 17),
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
                    child: const Icon(
                      Icons.close_rounded,
                      color: kInk800,
                      size: 17,
                    ),
                  ),
                ),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
        ),
      ),
    );
  }
}
