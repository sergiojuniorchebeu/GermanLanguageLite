import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'lecon1.dart';
import 'lecon2.dart';

class LessonList5Page extends StatelessWidget {
  const LessonList5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 5,
      chapterTitleFR: "La physiopathologie",
      chapterTitleDE: "Die Pathophysiologie",
      lessons: [
        ChapterLessonListEntry(
          title: "L'observation",
          description:
              "Développez le vocabulaire d'observation clinique et de surveillance.",
          image: 'assets/img/research.png',
          lessonId: "L'observation",
          requiredXp: 780,
          buttonColor: kCoral,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "L'écoute des plaintes",
          description:
              "Apprenez à recueillir et reformuler les plaintes du patient.",
          image: 'assets/img/doctor-visit.png',
          lessonId: "L'écoute des plaintes",
          requiredXp: 850,
          buttonColor: kPeach,
          pageBuilder: _lesson2Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C5Page();
Widget _lesson2Builder() => const Lesson2C5Page();
