import 'package:flutter/material.dart';
import 'package:projet2/core/data/practice_catalog.dart';
import 'package:projet2/core/services/audio_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class ConversationDrillsPage extends StatelessWidget {
  const ConversationDrillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: conversationSituations.length,
      child: Scaffold(
        backgroundColor: kScaffold,
        appBar: AppBar(
          title: const Text('Fiches de conversation'),
          backgroundColor: Colors.white,
          foregroundColor: kInk900,
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            labelColor: kInk900,
            unselectedLabelColor: kInk500,
            indicatorColor: kBlue,
            tabs: conversationSituations
                .map((situation) => Tab(text: situation.title))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: conversationSituations
              .map((situation) => _SituationView(situation: situation))
              .toList(),
        ),
      ),
    );
  }
}

class _SituationView extends StatelessWidget {
  final ConversationSituation situation;

  const _SituationView({required this.situation});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(situation.title, style: AppText.h3),
              const SizedBox(height: 6),
              Text(
                situation.subtitle,
                style: AppText.bodyM.copyWith(color: kInk500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          situation.phrases.length,
          (index) => _ConversationPhraseCard(
            entry: situation.phrases[index],
            accentColor: situation.accentColor,
            accentLight: situation.accentLight,
          ),
        ),
      ],
    );
  }
}

class _ConversationPhraseCard extends StatelessWidget {
  final PhraseEntry entry;
  final Color accentColor;
  final Color accentLight;

  const _ConversationPhraseCard({
    required this.entry,
    required this.accentColor,
    required this.accentLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: accentLight,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    entry.phrase,
                    style: AppText.labelL.copyWith(color: kInk900, height: 1.4),
                  ),
                ),
                const SizedBox(width: 12),
                ValueListenableBuilder<String?>(
                  valueListenable: AudioService.speakingText,
                  builder: (context, speakingText, child) {
                    final isSpeaking = speakingText == entry.phrase;
                    return GestureDetector(
                      onTap: () => AudioService.speakGerman(entry.phrase),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isSpeaking ? accentColor : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isSpeaking
                              ? Icons.stop_rounded
                              : Icons.volume_up_rounded,
                          color: isSpeaking ? Colors.white : accentColor,
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                entry.meaning,
                style: AppText.bodyM.copyWith(color: kInk700, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
