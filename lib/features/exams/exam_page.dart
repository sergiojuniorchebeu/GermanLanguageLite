import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/services/sfx_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class ExamPage extends StatefulWidget {
  final int? chapterNumber;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color accentLight;
  final List<PhraseEntry> phrases;
  final bool isFinalExam;

  const ExamPage.chapter({
    super.key,
    required this.chapterNumber,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.accentLight,
    required this.phrases,
  }) : isFinalExam = false;

  const ExamPage.finalExam({
    super.key,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.accentLight,
    required this.phrases,
  })  : isFinalExam = true,
        chapterNumber = null;

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage>
    with SingleTickerProviderStateMixin {
  late final List<_ExamQuestion> _questions;
  late final AnimationController _feedbackController;
  late final Animation<double> _feedbackAnim;

  int _currentIndex = 0;
  int _correctCount = 0;
  int? _selectedOption;
  bool _isFinished = false;
  int _xpGained = 0;
  int _bestScore = 0;

  @override
  void initState() {
    super.initState();
    _questions = _ExamQuestion.generateFrom(
      widget.phrases,
      maxQuestions: widget.isFinalExam ? 16 : 8,
    );
    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _feedbackAnim = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _selectOption(int optionIndex) {
    if (_selectedOption != null) return;
    final isCorrect = optionIndex == _questions[_currentIndex].correctIndex;
    if (isCorrect) {
      unawaited(SfxService.playQuizSuccess());
    } else {
      unawaited(SfxService.playQuizFail());
    }
    setState(() {
      _selectedOption = optionIndex;
      if (isCorrect) _correctCount++;
    });
    _feedbackController.forward(from: 0);
  }

  Future<void> _next() async {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
      });
      return;
    }

    final previousLevel = await ProgressService.getLevelInfo();
    final previousBadges = await ProgressService.getBadges();
    final score = (_correctCount / _questions.length * 100).round();
    final xp = widget.isFinalExam
        ? await ProgressService.completeFinalExam(
            _correctCount, _questions.length)
        : await ProgressService.completeChapterExam(
            widget.chapterNumber!,
            _correctCount,
            _questions.length,
          );
    final bestScore = widget.isFinalExam
        ? await ProgressService.getFinalExamBestScore()
        : await ProgressService.getChapterExamBestScore(widget.chapterNumber!);
    final currentLevel = await ProgressService.getLevelInfo();
    final currentBadges = await ProgressService.getBadges();
    final newBadgeUnlocked = currentBadges.any(
      (badge) =>
          badge.unlocked &&
          !previousBadges.any(
            (previous) => previous.id == badge.id && previous.unlocked,
          ),
    );

    if (xp > 0) {
      if (currentLevel.level > previousLevel.level) {
        unawaited(SfxService.playLevelUp());
      } else if (newBadgeUnlocked) {
        unawaited(SfxService.playBadgeUnlock());
      } else {
        unawaited(SfxService.playXpGain());
      }
    } else if (score >= 80) {
      unawaited(SfxService.playGentleNotification());
    }

    if (!mounted) return;
    setState(() {
      _isFinished = true;
      _xpGained = xp;
      _bestScore = bestScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: _isFinished ? _buildResult() : _buildQuestion(),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Column(
      children: [
        _ExamHeader(
          title: widget.title,
          subtitle: widget.subtitle,
          stepLabel: '${_currentIndex + 1} / ${_questions.length}',
          accentColor: widget.accentColor,
          accentLight: widget.accentLight,
          progress: progress,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: widget.accentLight,
                    borderRadius: BorderRadius.circular(22),
                    border:
                        Border.all(color: widget.accentColor.withOpacity(0.24)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Traduire en français',
                        style:
                            AppText.labelS.copyWith(color: widget.accentColor),
                      ),
                      const SizedBox(height: 12),
                      Text(question.prompt,
                          style: AppText.h3.copyWith(fontSize: 18)),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                ...List.generate(
                  question.options.length,
                  (index) => _ExamOptionTile(
                    optionIndex: index,
                    selectedIndex: _selectedOption,
                    correctIndex: question.correctIndex,
                    label: question.options[index],
                    onTap: () => _selectOption(index),
                  ),
                ),
                if (_selectedOption != null) ...[
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _feedbackAnim,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.accentColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentIndex < _questions.length - 1
                              ? 'Question suivante'
                              : 'Voir les résultats',
                          style: AppText.labelL.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResult() {
    final percent = (_correctCount / _questions.length * 100).round();
    final label = percent >= 85
        ? 'Très bon niveau'
        : percent >= 65
            ? 'Bonne base'
            : 'Révision conseillée';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: widget.accentLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.isFinalExam
                    ? Icons.workspace_premium_rounded
                    : Icons.fact_check_rounded,
                color: widget.accentColor,
                size: 42,
              ),
            ),
            const SizedBox(height: 24),
            Text(
                widget.isFinalExam
                    ? 'Examen final terminé'
                    : 'Mini examen terminé',
                style: AppText.h2),
            const SizedBox(height: 8),
            Text(label, style: AppText.bodyM.copyWith(color: kInk500)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kBorder),
              ),
              child: Column(
                children: [
                  Text(
                    '$percent%',
                    style: AppText.h1
                        .copyWith(color: widget.accentColor, fontSize: 42),
                  ),
                  const SizedBox(height: 4),
                  Text('$_correctCount / ${_questions.length} réponses justes',
                      style: AppText.bodyS),
                  const SizedBox(height: 14),
                  Text('Meilleur score: $_bestScore%',
                      style: AppText.labelS.copyWith(color: kInk500)),
                ],
              ),
            ),
            if (_xpGained > 0) ...[
              const SizedBox(height: 18),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: kYellowLight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: kYellow),
                ),
                child: Text(
                  '+$_xpGained XP bonus',
                  style: AppText.labelL.copyWith(color: kInk900),
                ),
              ),
            ],
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text('Retour',
                    style: AppText.labelL.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExamHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String stepLabel;
  final Color accentColor;
  final Color accentLight;
  final double progress;

  const _ExamHeader({
    required this.title,
    required this.subtitle,
    required this.stepLabel,
    required this.accentColor,
    required this.accentLight,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: kBorder)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close_rounded, color: kInk500),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppText.labelM.copyWith(color: kInk800)),
                    Text(subtitle,
                        style: AppText.labelS.copyWith(color: kInk500)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accentLight,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  stepLabel,
                  style: AppText.caption.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: kInk100,
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExamOptionTile extends StatelessWidget {
  final int optionIndex;
  final int? selectedIndex;
  final int correctIndex;
  final String label;
  final VoidCallback onTap;

  const _ExamOptionTile({
    required this.optionIndex,
    required this.selectedIndex,
    required this.correctIndex,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAnswered = selectedIndex != null;
    final isSelected = selectedIndex == optionIndex;
    final isCorrect = correctIndex == optionIndex;

    var background = Colors.white;
    var border = kBorder;
    Widget? icon;
    if (isAnswered && isCorrect) {
      background = kGreenLight;
      border = kGreen;
      icon = const Icon(Icons.check_circle_rounded, color: kGreen, size: 20);
    } else if (isAnswered && isSelected) {
      background = kCoralLight;
      border = kCoral;
      icon = const Icon(Icons.cancel_rounded, color: kCoral, size: 20);
    }

    return GestureDetector(
      onTap: isAnswered ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isAnswered && isCorrect
                    ? kGreen
                    : isAnswered && isSelected
                        ? kCoral
                        : kInk100,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                String.fromCharCode(65 + optionIndex),
                style: AppText.labelS.copyWith(
                  color: isAnswered && (isCorrect || isSelected)
                      ? Colors.white
                      : kInk500,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
                child:
                    Text(label, style: AppText.bodyM.copyWith(color: kInk900))),
            if (icon != null) icon,
          ],
        ),
      ),
    );
  }
}

class _ExamQuestion {
  final String prompt;
  final List<String> options;
  final int correctIndex;

  const _ExamQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });

  static List<_ExamQuestion> generateFrom(
    List<PhraseEntry> phrases, {
    required int maxQuestions,
  }) {
    final rng = Random();
    final pool = List<PhraseEntry>.from(phrases)..shuffle(rng);
    final selected = pool.take(min(maxQuestions, pool.length)).toList();

    return selected.map((entry) {
      final distractors = phrases
          .where((phrase) => phrase.meaning != entry.meaning)
          .map((phrase) => phrase.meaning)
          .toSet()
          .toList()
        ..shuffle(rng);

      final options = <String>[entry.meaning, ...distractors.take(3)]
        ..shuffle(rng);
      return _ExamQuestion(
        prompt: entry.phrase,
        options: options,
        correctIndex: options.indexOf(entry.meaning),
      );
    }).toList();
  }
}
