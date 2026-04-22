import 'package:flutter/material.dart';
import 'package:projet2/User/Views/ChaptersPage.dart';
import 'package:projet2/User/Widget/Widget.dart';
import 'package:projet2/User/Widget/chapter_catalog.dart';
import 'package:projet2/core/data/exam_catalog.dart';
import 'package:projet2/core/services/challenge_service.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/features/quiz/quiz_page.dart';

class ChallengeNavigation {
  ChallengeNavigation._();

  static Future<void> openChallenge(
    BuildContext context,
    WeeklyChallenge challenge,
  ) async {
    switch (challenge.id) {
      case 'weekly_lessons':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChaptersPage()),
        );
        return;
      case 'weekly_quizzes':
      case 'weekly_minutes':
      default:
        final chapter = await _resolveCurrentChapter();
        if (!context.mounted) return;
        final examData = getChapterExamData(chapter.number);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuizPage(
              chapterNumber: chapter.number,
              lessonTitle: examData.titleFR,
              accentColor: examData.accentColor,
              accentLight: examData.accentLight,
              phrases: examData.phrases,
            ),
          ),
        );
    }
  }

  static Future<ChapterData> _resolveCurrentChapter() async {
    final chapters = buildStudentChapters();
    final progresses = await ProgressService.getAllChapterProgresses();

    ChapterData? best;
    double bestProgress = 0;

    for (final chapter in chapters) {
      if (chapter.isComingSoon || chapter.page == null) continue;
      final progress = progresses[chapter.number] ?? 0;
      if (progress > 0 && progress < 1 && progress > bestProgress) {
        bestProgress = progress;
        best = chapter;
      }
    }

    if (best != null) return best;

    for (final chapter in chapters) {
      if (!chapter.isComingSoon && chapter.page != null) {
        return chapter;
      }
    }

    return chapters.first;
  }
}
