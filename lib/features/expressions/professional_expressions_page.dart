import 'package:flutter/material.dart';
import 'package:projet2/core/data/practice_catalog.dart';
import 'package:projet2/core/services/audio_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';

class ProfessionalExpressionsPage extends StatelessWidget {
  const ProfessionalExpressionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      appBar: AppBar(
        title: const Text('Expressions professionnelles'),
        backgroundColor: Colors.white,
        foregroundColor: kInk900,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: professionalExpressionGroups
            .map((group) => _ExpressionSection(group: group))
            .toList(),
      ),
    );
  }
}

class _ExpressionSection extends StatelessWidget {
  final ProfessionalExpressionGroup group;

  const _ExpressionSection({required this.group});

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
                  color: group.accentLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.record_voice_over_rounded,
                    color: group.accentColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.title, style: AppText.labelL),
                    Text(
                      group.subtitle,
                      style: AppText.bodyS.copyWith(color: kInk500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...group.phrases.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => AudioService.speakGerman(entry.phrase),
                    child: Container(
                      width: 34,
                      height: 34,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: group.accentLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.volume_up_rounded,
                          color: group.accentColor, size: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.phrase,
                            style: AppText.labelM.copyWith(color: kInk900)),
                        const SizedBox(height: 2),
                        Text(entry.meaning,
                            style: AppText.bodyS.copyWith(color: kInk500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
