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
  late final List<ChapterData> _chapters = buildStudentChapters();
  Map<int, double> _chapterProgresses = const {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
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
                        final chapter = _chapters[index];
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
                      childCount: _chapters.length,
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
}
