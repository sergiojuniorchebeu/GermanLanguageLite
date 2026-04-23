import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'Leçon3.dart';
import 'leçon1.dart';
import 'leçon2.dart';

class LessonList7Page extends StatelessWidget {
  const LessonList7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 7,
      chapterTitleFR: "Labo – prélèvement",
      chapterTitleDE: "Labor – Entnahme",
      lessons: [
        ChapterLessonListEntry(
          title: "La prise de sang",
          description:
              "Travaillez les étapes et le vocabulaire de la prise de sang.",
          image: 'assets/img/blood-tube.png',
          lessonId: "La prise de sang",
          requiredXp: 1280,
          buttonColor: kBlue,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "La glycémie capillaire",
          description:
              "Apprenez le matériel et les formulations liées à la glycémie capillaire.",
          image: 'assets/img/blood-vessel.png',
          lessonId: "La glycémie capillaire",
          requiredXp: 1360,
          buttonColor: kGreen,
          pageBuilder: _lesson2Builder,
        ),
        ChapterLessonListEntry(
          title: "Les valeurs sanguines",
          description:
              "Identifiez les principales valeurs sanguines et leur interprétation de base.",
          image: 'assets/img/blood-sample.png',
          lessonId: "Les valeurs sanguines",
          requiredXp: 1450,
          buttonColor: kCoral,
          pageBuilder: _lesson3Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C7Page();
Widget _lesson2Builder() => const Lesson2C7Page();
Widget _lesson3Builder() => const Lesson3C7Page();
