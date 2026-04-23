import 'package:flutter/material.dart';
import 'package:projet2/core/services/audio_service.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/features/flashcards/flashcard_page.dart';
import 'package:projet2/features/quiz/quiz_page.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Modèle de donnée — Paire phrase / traduction
// ─────────────────────────────────────────────────────────────────────────────
class PhraseEntry {
  final String phrase;   // Allemand
  final String meaning;  // Français

  const PhraseEntry({required this.phrase, required this.meaning});
}

// ─────────────────────────────────────────────────────────────────────────────
// LessonTemplate — Template partagé pour toutes les pages de leçon
// ─────────────────────────────────────────────────────────────────────────────
class LessonTemplate extends StatefulWidget {
  final int chapterNumber;
  final Color accentColor;
  final Color accentLight;
  final String title;
  final String? content;
  final List<PhraseEntry> examples;

  const LessonTemplate({
    super.key,
    required this.chapterNumber,
    required this.accentColor,
    required this.accentLight,
    required this.title,
    this.content,
    required this.examples,
  });

  @override
  State<LessonTemplate> createState() => _LessonTemplateState();
}

class _LessonTemplateState extends State<LessonTemplate> {
  late Future<Map<String, dynamic>> _lessonStatsFuture;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _lessonStatsFuture = _loadLessonStats();
    ProgressService.startLessonSession(widget.chapterNumber, widget.title);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProgressService.markLessonVisited(widget.chapterNumber, widget.title);
    });
  }

  @override
  void dispose() {
    AudioService.stop();
    super.dispose();
  }

  Future<Map<String, dynamic>> _loadLessonStats() {
    return ProgressService.getLessonStats(widget.chapterNumber, widget.title);
  }

  void _refreshLessonStats() {
    setState(() {
      _lessonStatsFuture = _loadLessonStats();
    });
  }

  Future<void> _handleExit() async {
    if (_isExiting || !mounted) return;
    _isExiting = true;
    final summary = await ProgressService.endLessonSession(
      widget.chapterNumber,
      widget.title,
      phraseCount: widget.examples.length,
    );
    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _SessionSummarySheet(
        summary: summary,
        accentColor: widget.accentColor,
        accentLight: widget.accentLight,
      ),
    );

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleExit();
      },
      child: Scaffold(
        backgroundColor: kScaffold,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverToBoxAdapter(child: _buildActions(context)),
              if (widget.content != null && widget.content!.isNotEmpty)
                SliverToBoxAdapter(child: _buildContent()),
              SliverToBoxAdapter(child: _buildPhrasesTitle()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _PhraseCard(
                      entry: widget.examples[i],
                      accentColor: widget.accentColor,
                      accentLight: widget.accentLight,
                      index: i,
                    ),
                    childCount: widget.examples.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 60)),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _handleExit,
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: kBorder),
              boxShadow: const [
                BoxShadow(color: kShadow, blurRadius: 12, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _HeaderTag(
                      label: 'Ch. ${widget.chapterNumber}',
                      textColor: widget.accentColor,
                      bgColor: widget.accentLight,
                      borderColor: widget.accentColor.withValues(alpha: 0.2),
                    ),
                    const SizedBox(width: 8),
                    _HeaderTag(
                      label: 'Allemand médical',
                      textColor: kInk600,
                      bgColor: kInk100,
                      borderColor: kBorder,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: kInk900,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.examples.length} expressions à travailler dans cette leçon.',
                  style: AppText.bodyS.copyWith(color: kInk500, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _lessonStatsFuture,
      builder: (context, snapshot) {
        final stats = snapshot.data ?? const <String, dynamic>{};
        final quizCompleted = stats['quizCompleted'] == true;
        final quizBestScore = (stats['quizBestScore'] as int?) ?? 0;
        final flashcardsReviewed = stats['flashcardsReviewed'] == true;
        final flashcardsBestScore =
            (stats['flashcardsBestScore'] as int?) ?? 0;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: _ActionChip(
                  icon: Icons.quiz_outlined,
                  label: 'Quiz',
                  status: quizCompleted ? 'Réussi · $quizBestScore%' : null,
                  backgroundColor: Colors.white,
                  foregroundColor: widget.accentColor,
                  borderColor: widget.accentColor.withValues(alpha: 0.18),
                  onTap: widget.examples.length < 2
                      ? null
                      : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizPage(
                                chapterNumber: widget.chapterNumber,
                                lessonTitle: widget.title,
                                accentColor: widget.accentColor,
                                accentLight: widget.accentLight,
                                phrases: widget.examples,
                              ),
                            ),
                          ).then((_) => _refreshLessonStats()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionChip(
                  icon: Icons.style_outlined,
                  label: 'Flashcards',
                  status: flashcardsReviewed
                      ? 'Révisé · $flashcardsBestScore%'
                      : null,
                  backgroundColor: widget.accentLight.withValues(alpha: 0.45),
                  foregroundColor: kInk800,
                  borderColor: kBorder,
                  onTap: widget.examples.isEmpty
                      ? null
                      : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FlashcardPage(
                                chapterNumber: widget.chapterNumber,
                                chapterTitle: widget.title,
                                accentColor: widget.accentColor,
                                accentLight: widget.accentLight,
                                phrases: widget.examples,
                              ),
                            ),
                          ).then((_) => _refreshLessonStats()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Section contenu ──────────────────────────────────────────────────────
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kBorder),
          boxShadow: const [
            BoxShadow(color: kShadow, blurRadius: 10, offset: Offset(0, 3)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: widget.accentLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.lightbulb_outline_rounded,
                    color: widget.accentColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'À retenir',
                  style: AppText.labelL.copyWith(color: kInk900),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              widget.content!,
              style: AppText.bodyM.copyWith(
                color: kInk700,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Titre de section exemples ─────────────────────────────────────────────
  Widget _buildPhrasesTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: widget.accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text('Expressions clés', style: AppText.h3.copyWith(fontSize: 16)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: widget.accentLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${widget.examples.length}',
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
// Phrase Card — une expression DE + traduction FR
// ─────────────────────────────────────────────────────────────────────────────
class _PhraseCard extends StatelessWidget {
  final PhraseEntry entry;
  final Color accentColor;
  final Color accentLight;
  final int index;

  const _PhraseCard({
    required this.entry,
    required this.accentColor,
    required this.accentLight,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
        boxShadow: const [
          BoxShadow(
            color: kShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Bloc allemand ────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: BoxDecoration(
              color: accentLight,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🇩🇪', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    entry.phrase,
                    style: AppText.labelL.copyWith(
                      color: kInk900,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ValueListenableBuilder<String?>(
                  valueListenable: AudioService.speakingText,
                  builder: (context, speakingText, _) {
                    final isSpeaking = speakingText == entry.phrase;
                    return GestureDetector(
                      onTap: () => AudioService.speakGerman(entry.phrase),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: isSpeaking ? accentColor : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: accentColor),
                        ),
                        child: Icon(
                          isSpeaking
                              ? Icons.volume_up_rounded
                              : Icons.volume_mute_rounded,
                          size: 18,
                          color: isSpeaking ? Colors.white : accentColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // ── Séparateur ────────────────────────────────────────────────
          const Divider(height: 1, color: kBorder),

          // ── Bloc français ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🇫🇷', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    entry.meaning,
                    style: AppText.bodyM.copyWith(
                      color: kInk600,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
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

// ─────────────────────────────────────────────────────────────────────────────
// Helper tag pour le header
// ─────────────────────────────────────────────────────────────────────────────
class _HeaderTag extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;

  const _HeaderTag({
    required this.label,
    required this.textColor,
    required this.bgColor,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: AppText.labelS.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? status;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final VoidCallback? onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    this.status,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor = Colors.transparent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.45 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor),
            boxShadow: const [
              BoxShadow(color: kShadow, blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: foregroundColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: foregroundColor),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: AppText.labelM.copyWith(color: foregroundColor),
              ),
              if (status != null) ...[
                const SizedBox(height: 4),
                Text(
                  status!,
                  style: AppText.caption.copyWith(color: foregroundColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionSummarySheet extends StatelessWidget {
  final SessionSummary summary;
  final Color accentColor;
  final Color accentLight;

  const _SessionSummarySheet({
    required this.summary,
    required this.accentColor,
    required this.accentLight,
  });

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes == 0) return '${remainingSeconds}s';
    return '${minutes}min ${remainingSeconds}s';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: kBorder,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accentLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Icon(
                  summary.xpGained > 0
                      ? Icons.insights_rounded
                      : Icons.menu_book_rounded,
                  size: 24,
                  color: accentColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Résumé de session', style: AppText.h3),
                    const SizedBox(height: 2),
                    Text(
                      summary.xpGained > 0
                          ? 'Votre progression a été sauvegardée.'
                          : 'Session enregistrée.',
                      style: AppText.bodyS,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _SummaryStat(
                  label: 'Temps',
                  value: _formatDuration(summary.durationSeconds),
                  accentColor: accentColor,
                  accentLight: accentLight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryStat(
                  label: 'XP gagnés',
                  value: '+${summary.xpGained}',
                  accentColor: accentColor,
                  accentLight: accentLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SummaryStat(
                  label: 'Phrases',
                  value: '${summary.phraseCount}',
                  accentColor: accentColor,
                  accentLight: accentLight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryStat(
                  label: 'Quiz',
                  value: summary.quizCompleted
                      ? '${summary.quizBestScore}%'
                      : 'À faire',
                  accentColor: accentColor,
                  accentLight: accentLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _SummaryBanner(
            label: summary.flashcardsReviewed
                ? 'Flashcards révisées · ${summary.flashcardsBestScore}%'
                : 'Flashcards non révisées',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Continuer',
                style: AppText.labelL.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;
  final Color accentLight;

  const _SummaryStat({
    required this.label,
    required this.value,
    required this.accentColor,
    required this.accentLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accentLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.caption.copyWith(color: accentColor)),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppText.h3.copyWith(color: kInk900, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _SummaryBanner extends StatelessWidget {
  final String label;

  const _SummaryBanner({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
      ),
      child: Text(
        label,
        style: AppText.bodyM.copyWith(color: kInk700),
      ),
    );
  }
}
