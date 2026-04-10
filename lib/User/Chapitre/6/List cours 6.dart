import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'leçon1.dart';
import 'leçon2.dart';

class LessonList6Page extends StatelessWidget {
  const LessonList6Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 6,
      chapterTitleFR: "Les examens complémentaires",
      chapterTitleDE: "Die Untersuchungen",
      accentColor: kYellow,
      accentLight: kYellowLight,
      lessons: [
        LessonEntry(
          title: "Les examens généraux",
          description: "Die allgemeinen Untersuchungen",
          image: 'assets/img/examination.png',
          pageBuilder: () => const Lesson1C6Page(),
        ),
        LessonEntry(
          title: "La coronarographie",
          description: "Die Koronarangiographie",
          image: 'assets/img/machine.png',
          pageBuilder: () => const Lesson2C6Page(),
        ),
      ],
    );
  }
}
