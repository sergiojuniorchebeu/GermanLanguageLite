import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'leçon1.dart';
import 'leçon2.dart';

class LessonList6Page extends StatelessWidget {
  const LessonList6Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 6,
      chapterTitleFR: "Les examens complémentaires",
      chapterTitleDE: "Die Untersuchungen",
      lessons: [
        ChapterLessonListEntry(
          title: "Les examens généraux",
          description:
              "Travaillez le vocabulaire des examens courants et des consignes associées.",
          image: 'assets/img/examination.png',
          lessonId: "Les examens généraux",
          requiredXp: 1020,
          buttonColor: kYellow,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "La coronarographie",
          description:
              "Apprenez la préparation, le déroulement et la surveillance liés à la coronarographie.",
          image: 'assets/img/machine.png',
          lessonId: "La coronarographie",
          requiredXp: 1100,
          buttonColor: kBlue,
          pageBuilder: _lesson2Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C6Page();
Widget _lesson2Builder() => const Lesson2C6Page();
