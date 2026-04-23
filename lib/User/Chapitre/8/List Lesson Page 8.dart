import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'Leçon1.dart';
import 'leçon2.dart';
import 'leçon3.dart';
import 'leçon4.dart';

class LessonList8Page extends StatelessWidget {
  const LessonList8Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 8,
      chapterTitleFR: "L'anesthésie & l'opération",
      chapterTitleDE: "Die Anästhesie & die Operation",
      lessons: [
        ChapterLessonListEntry(
          title: "L'anesthésie",
          description:
              "Découvrez le vocabulaire de l'anesthésie et les échanges préalables à l'intervention.",
          image: 'assets/img/vaccine.png',
          lessonId: "L'anesthésie",
          requiredXp: 1560,
          buttonColor: kGreen,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "La préparation pré opératoire",
          description:
              "Travaillez les consignes de préparation avant l'opération.",
          image: 'assets/img/surgery-room.png',
          lessonId: "La préparation pré opératoire",
          requiredXp: 1640,
          buttonColor: kBlue,
          pageBuilder: _lesson2Builder,
        ),
        ChapterLessonListEntry(
          title: "La surveillance post opératoire",
          description:
              "Apprenez les formulations de surveillance après l'intervention.",
          image: 'assets/img/heart-rate-monitor.png',
          lessonId: "La surveillance post opératoire",
          requiredXp: 1730,
          buttonColor: kCoral,
          pageBuilder: _lesson3Builder,
        ),
        ChapterLessonListEntry(
          title: "La plaie",
          description:
              "Maîtrisez le vocabulaire des plaies, pansements et contrôles associés.",
          image: 'assets/img/bleeding.png',
          lessonId: "La plaie",
          requiredXp: 1830,
          buttonColor: kPeach,
          pageBuilder: _lesson4Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C8Page();
Widget _lesson2Builder() => const Lesson2C8Page();
Widget _lesson3Builder() => const Lesson3C8Page();
Widget _lesson4Builder() => const Lesson4C8Page();
