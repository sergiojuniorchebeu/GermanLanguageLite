import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'leçon1.dart';
import 'leçon2.dart';

class LessonList7Page extends StatelessWidget {
  const LessonList7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 7,
      chapterTitleFR: "Labo – prélèvement",
      chapterTitleDE: "Labor – Entnahme",
      accentColor: kBlue,
      accentLight: kBlueLight,
      lessons: [
        LessonEntry(
          title: "La prise de sang",
          description: "Die Blutabnahme",
          image: 'assets/img/blood-tube.png',
          pageBuilder: () => const Lesson1C7Page(),
        ),
        LessonEntry(
          title: "La glycémie capillaire",
          description: "Die kapillare Blutzuckermessung",
          image: 'assets/img/blood-vessel.png',
          pageBuilder: () => const Lesson2C7Page(),
        ),
        LessonEntry(
          title: "Les valeurs sanguines",
          description: "Die Blutwerte",
          image: 'assets/img/blood-sample.png',
          pageBuilder: () => const Lesson2C7Page(),
        ),
      ],
    );
  }
}
