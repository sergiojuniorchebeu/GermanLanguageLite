import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet2/core/data/practice_catalog.dart';
import 'package:projet2/core/services/sfx_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';

class ClinicalCasesPage extends StatefulWidget {
  const ClinicalCasesPage({super.key});

  @override
  State<ClinicalCasesPage> createState() => _ClinicalCasesPageState();
}

class _ClinicalCasesPageState extends State<ClinicalCasesPage> {
  final Set<String> _revealedCases = <String>{};
  final Set<String> _correctCases = <String>{};

  void _answerCase(ClinicalCase clinicalCase, int index) {
    if (_revealedCases.contains(clinicalCase.id)) return;
    if (index == clinicalCase.correctIndex) {
      unawaited(SfxService.playQuizSuccess());
      _correctCases.add(clinicalCase.id);
    } else {
      unawaited(SfxService.playQuizFail());
    }
    setState(() {
      _revealedCases.add(clinicalCase.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      appBar: AppBar(
        title: const Text('Cas cliniques'),
        backgroundColor: Colors.white,
        foregroundColor: kInk900,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kBorder),
            ),
            child: Text(
              '${_correctCases.length} / ${clinicalCases.length} cas validés dans cette session',
              style: AppText.bodyM.copyWith(color: kInk700),
            ),
          ),
          const SizedBox(height: 16),
          ...clinicalCases.map(
            (clinicalCase) => _ClinicalCaseCard(
              clinicalCase: clinicalCase,
              isRevealed: _revealedCases.contains(clinicalCase.id),
              onAnswer: (index) => _answerCase(clinicalCase, index),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicalCaseCard extends StatelessWidget {
  final ClinicalCase clinicalCase;
  final bool isRevealed;
  final ValueChanged<int> onAnswer;

  const _ClinicalCaseCard({
    required this.clinicalCase,
    required this.isRevealed,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: clinicalCase.accentLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.local_hospital_rounded,
                    color: clinicalCase.accentColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(clinicalCase.title, style: AppText.labelL),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(clinicalCase.situation,
              style: AppText.bodyM.copyWith(color: kInk700, height: 1.5)),
          const SizedBox(height: 10),
          Text(clinicalCase.prompt,
              style: AppText.labelM.copyWith(color: kInk900)),
          const SizedBox(height: 14),
          ...List.generate(
            clinicalCase.options.length,
            (index) => _CaseOptionTile(
              label: clinicalCase.options[index],
              isRevealed: isRevealed,
              isCorrect: index == clinicalCase.correctIndex,
              onTap: () => onAnswer(index),
            ),
          ),
          if (isRevealed) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: clinicalCase.accentLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                clinicalCase.explanation,
                style: AppText.bodyS.copyWith(color: kInk800, height: 1.5),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CaseOptionTile extends StatelessWidget {
  final String label;
  final bool isRevealed;
  final bool isCorrect;
  final VoidCallback onTap;

  const _CaseOptionTile({
    required this.label,
    required this.isRevealed,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = !isRevealed
        ? Colors.white
        : isCorrect
            ? kGreenLight
            : kInk100;
    final border = !isRevealed
        ? kBorder
        : isCorrect
            ? kGreen
            : kBorder;

    return GestureDetector(
      onTap: isRevealed ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 1.3),
        ),
        child: Row(
          children: [
            Expanded(
                child:
                    Text(label, style: AppText.bodyM.copyWith(color: kInk900))),
            if (isRevealed && isCorrect)
              const Icon(Icons.check_circle_rounded, color: kGreen, size: 20),
          ],
        ),
      ),
    );
  }
}
