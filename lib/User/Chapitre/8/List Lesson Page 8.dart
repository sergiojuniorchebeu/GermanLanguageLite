import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'Leçon1.dart';
import 'leçon2.dart';
import 'leçon3.dart';
import 'leçon4.dart';

class LessonList8Page extends StatelessWidget {
  const LessonList8Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 8,
      chapterTitleFR: "L'anesthésie & l'opération",
      chapterTitleDE: "Die Anästhesie & die Operation",
      accentColor: kGreen,
      accentLight: kGreenLight,
      lessons: [
        LessonEntry(
          title: "L'anesthésie",
          description: "Die Anästhesie",
          image: 'assets/img/vaccine.png',
          pageBuilder: () => const Lesson1C8Page(),
        ),
        LessonEntry(
          title: "La préparation pré opératoire",
          description: "Die präoperative Vorbereitung",
          image: 'assets/img/surgery-room.png',
          pageBuilder: () => const Lesson2C8Page(),
        ),
        LessonEntry(
          title: "La surveillance post opératoire",
          description: "Die postoperative Überwachung",
          image: 'assets/img/heart-rate-monitor.png',
          pageBuilder: () => const Lesson3C8Page(),
        ),
        LessonEntry(
          title: "La plaie",
          description: "Die Wunde",
          image: 'assets/img/bleeding.png',
          pageBuilder: () => const Lesson4C8Page(),
        ),
      ],
    );
  }
}
