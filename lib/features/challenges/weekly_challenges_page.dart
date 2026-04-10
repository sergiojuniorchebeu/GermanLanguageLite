import 'package:flutter/material.dart';
import 'package:projet2/core/services/challenge_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';

class WeeklyChallengesPage extends StatefulWidget {
  const WeeklyChallengesPage({super.key});

  @override
  State<WeeklyChallengesPage> createState() => _WeeklyChallengesPageState();
}

class _WeeklyChallengesPageState extends State<WeeklyChallengesPage> {
  late Future<List<WeeklyChallenge>> _future;

  @override
  void initState() {
    super.initState();
    _future = ChallengeService.getWeeklyChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      appBar: AppBar(
        title: const Text('Défis hebdomadaires'),
        backgroundColor: Colors.white,
        foregroundColor: kInk900,
        elevation: 0,
      ),
      body: FutureBuilder<List<WeeklyChallenge>>(
        future: _future,
        builder: (context, snapshot) {
          final challenges = snapshot.data ?? const <WeeklyChallenge>[];
          final completed = challenges.where((item) => item.isCompleted).length;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cette semaine', style: AppText.h3),
                    const SizedBox(height: 6),
                    Text(
                      '$completed / ${challenges.length} défis complétés',
                      style: AppText.bodyM.copyWith(color: kInk500),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: challenges.isEmpty
                            ? 0
                            : completed / challenges.length,
                        minHeight: 10,
                        backgroundColor: kInk100,
                        valueColor: const AlwaysStoppedAnimation<Color>(kBlue),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ...challenges
                  .map((challenge) => _ChallengeCard(challenge: challenge)),
            ],
          );
        },
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final WeeklyChallenge challenge;

  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final color = challenge.isCompleted ? kGreen : kBlue;
    final light = challenge.isCompleted ? kGreenLight : kBlueLight;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: light,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  challenge.isCompleted
                      ? Icons.check_rounded
                      : Icons.flag_rounded,
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(challenge.title, style: AppText.labelL),
                    Text(
                      challenge.description,
                      style: AppText.bodyS.copyWith(color: kInk500),
                    ),
                  ],
                ),
              ),
              Text(
                '${challenge.progress}/${challenge.target}',
                style: AppText.labelM.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: challenge.ratio,
              minHeight: 8,
              backgroundColor: kInk100,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
