import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/services/sfx_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

// ─────────────────────────────────────────────────────────────────────────────
// LOGIQUE 100% INCHANGÉE — seul le design a été modifié
// ─────────────────────────────────────────────────────────────────────────────

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
        : await ProgressService.getChapterExamBestScore(
        widget.chapterNumber!);
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

  // ── Question ──────────────────────────────────────────────────────────────

  Widget _buildQuestion() {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Barre de progression minimaliste ──────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: kInk100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        widget.accentColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.accentLight,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${_questions.length}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: widget.accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Label instruction ─────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kInk100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Traduire en français',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: kInk600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: kInk500,
                ),
              ),
            ],
          ),
        ),

        // ── Question en grande typographie ────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Text(
            question.prompt,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: kInk900,
              height: 1.15,
            ),
          ),
        ),

        // ── Séparateur soft ───────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Divider(height: 1, color: kBorder),
        ),

        // ── Options ───────────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  question.options.length,
                      (index) => _OptionTile(
                    letter: String.fromCharCode(65 + index),
                    label: question.options[index],
                    optionIndex: index,
                    selectedIndex: _selectedOption,
                    correctIndex: question.correctIndex,
                    accentColor: widget.accentColor,
                    accentLight: widget.accentLight,
                    onTap: () => _selectOption(index),
                  ),
                ),

                // ── Bouton suivant (apparaît après sélection) ─────────
                if (_selectedOption != null)
                  FadeTransition(
                    opacity: _feedbackAnim,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: _next,
                        child: Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: kFlagBlack,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentIndex < _questions.length - 1
                                    ? 'Question suivante'
                                    : 'Voir les résultats',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _currentIndex < _questions.length - 1
                                    ? Icons.arrow_forward_rounded
                                    : Icons.bar_chart_rounded,
                                color: kFlagGold,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Résultat ──────────────────────────────────────────────────────────────

  Widget _buildResult() {
    final percent = (_correctCount / _questions.length * 100).round();
    final label = percent >= 85
        ? 'Très bon niveau'
        : percent >= 65
        ? 'Bonne base'
        : 'Révision conseillée';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
      child: Column(
        children: [
          // ── Score hero sombre ─────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              color: kFlagBlack,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Text(
                  '$percent%',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 56,
                    fontWeight: FontWeight.w700,
                    color: kFlagGold,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$_correctCount / ${_questions.length} réponses justes',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: kFlagGold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                        color: kFlagGold.withValues(alpha: 0.30)),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kFlagGold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── 3 métriques ───────────────────────────────────────────
          Row(
            children: [
              _MetricChip(
                label: 'Score',
                value: '$percent%',
                bg: widget.accentLight,
                fg: widget.accentColor,
              ),
              const SizedBox(width: 10),
              _MetricChip(
                label: 'Meilleur',
                value: '$_bestScore%',
                bg: kInk100,
                fg: kInk700,
              ),
              const SizedBox(width: 10),
              _MetricChip(
                label: 'XP gagné',
                value: _xpGained > 0 ? '+$_xpGained' : '—',
                bg: _xpGained > 0 ? kPeachLight : kInk100,
                fg: _xpGained > 0 ? const Color(0xFF7A4A00) : kInk500,
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Card détail ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kBorder),
              boxShadow: const [
                BoxShadow(
                    color: kShadow, blurRadius: 12, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  widget.isFinalExam
                      ? Icons.workspace_premium_rounded
                      : Icons.fact_check_rounded,
                  color: widget.accentColor,
                  size: 32,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.isFinalExam
                      ? 'Examen final terminé'
                      : 'Mini examen terminé',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kInk900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: kInk500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Bouton retour ─────────────────────────────────────────
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: kFlagBlack,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Retour',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// OPTION TILE — Option A : lettre pill + label + feedback coloré
// ─────────────────────────────────────────────────────────────────────────────

class _OptionTile extends StatelessWidget {
  final String letter;
  final String label;
  final int optionIndex;
  final int? selectedIndex;
  final int correctIndex;
  final Color accentColor;
  final Color accentLight;
  final VoidCallback onTap;

  const _OptionTile({
    required this.letter,
    required this.label,
    required this.optionIndex,
    required this.selectedIndex,
    required this.correctIndex,
    required this.accentColor,
    required this.accentLight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAnswered = selectedIndex != null;
    final isSelected = selectedIndex == optionIndex;
    final isCorrect = correctIndex == optionIndex;

    // États visuels
    Color bg = Colors.white;
    Color border = kBorder;
    Color letterBg = kInk100;
    Color letterFg = kInk500;
    Widget? trailingIcon;

    if (isAnswered && isCorrect) {
      bg = kGreenSuccessLight;
      border = kGreenSuccess;
      letterBg = kGreenSuccess;
      letterFg = Colors.white;
      trailingIcon = const Icon(Icons.check_circle_rounded,
          color: kGreenSuccess, size: 20);
    } else if (isAnswered && isSelected && !isCorrect) {
      bg = kCoralLight;
      border = kCoral;
      letterBg = kCoral;
      letterFg = Colors.white;
      trailingIcon =
      const Icon(Icons.cancel_rounded, color: kCoral, size: 20);
    }

    return GestureDetector(
      onTap: isAnswered ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1.3),
        ),
        child: Row(
          children: [
            // Lettre pill
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: letterBg,
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: letterFg,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: isAnswered && isCorrect
                      ? kGreenSuccess
                      : isAnswered && isSelected
                      ? kCoral
                      : kInk900,
                  fontWeight: isAnswered && (isCorrect || isSelected)
                      ? FontWeight.w600
                      : FontWeight.w400,
                  height: 1.3,
                ),
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              trailingIcon,
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// METRIC CHIP — résultat
// ─────────────────────────────────────────────────────────────────────────────

class _MetricChip extends StatelessWidget {
  final String label;
  final String value;
  final Color bg;
  final Color fg;

  const _MetricChip({
    required this.label,
    required this.value,
    required this.bg,
    required this.fg,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: kInk500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LOGIQUE INCHANGÉE — génération des questions
// ─────────────────────────────────────────────────────────────────────────────

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