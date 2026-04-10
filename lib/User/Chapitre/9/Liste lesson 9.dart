import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'leçon1.dart';
import 'leçon2.dart';
import 'leçon3.dart';
import 'leçon4.dart';

class LessonList9Page extends StatelessWidget {
  const LessonList9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 9,
      chapterTitleFR: "Les soins thérapeutiques",
      chapterTitleDE: "Die Behandlungspflege",
      accentColor: kPurple,
      accentLight: kPurpleLight,
      lessons: [
        LessonEntry(
          title: "La perfusion",
          description: "Die Infusion",
          image: 'assets/img/saline.png',
          pageBuilder: () => const Lesson1C9Page(),
        ),
        LessonEntry(
          title: "La sonde urinaire",
          description: "Der Blasenkatheter",
          image: 'assets/img/medical.png',
          pageBuilder: () => const Lesson2C9Page(),
        ),
        LessonEntry(
          title: "Les voies d'administration des médicaments",
          description: "Die Verabreichungswege von Medikamenten",
          image: 'assets/img/schedule.png',
          pageBuilder: () => const Lesson3C9Page(),
        ),
        LessonEntry(
          title: "La préparation et la distribution des médicaments",
          description: "Die Zubereitung und Verteilung von Medikamenten",
          image: 'assets/img/calendar.png',
          pageBuilder: () => const Lesson4C9Page(),
        ),
      ],
    );
  }
}
