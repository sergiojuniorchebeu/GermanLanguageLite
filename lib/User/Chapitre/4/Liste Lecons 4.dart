import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'lecon1.dart';
import 'lecon2.dart';
import 'lecon3.dart';

class LessonList4Page extends StatelessWidget {
  const LessonList4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 4,
      chapterTitleFR: "Les soins d'hygiène",
      chapterTitleDE: "Die Grundpflege",
      lessons: [
        ChapterLessonListEntry(
          title: 'Les soins corporels',
          description:
              "Apprenez le vocabulaire des soins corporels et de l'hygiène quotidienne.",
          image: 'assets/img/heart.png',
          lessonId: "Les soins corporels (m.)",
          requiredXp: 560,
          buttonColor: kPeach,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "Le matériel",
          description:
              "Identifiez le matériel utilisé pour les soins d'hygiène.",
          image: 'assets/img/scrub.png',
          lessonId: "Le matériel",
          requiredXp: 620,
          buttonColor: kBlue,
          pageBuilder: _lesson2Builder,
        ),
        ChapterLessonListEntry(
          title: "Solliciter le patient",
          description:
              "Travaillez les formulations pour encourager la participation du patient.",
          image: 'assets/img/advice.png',
          lessonId: "Solliciter le patient",
          requiredXp: 690,
          buttonColor: kGreen,
          pageBuilder: _lesson3Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C4Page();
Widget _lesson2Builder() => const Lesson2C4Page();
Widget _lesson3Builder() => const Lesson3C4Page();
