import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'leçon1.dart';
import 'leçon2.dart';
import 'leçon3.dart';

class LessonList10Page extends StatelessWidget {
  const LessonList10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 10,
      chapterTitleFR: "La conduite à tenir en urgence",
      chapterTitleDE: "Das Verhalten im Notfall",
      accentColor: kCoral,
      accentLight: kCoralLight,
      lessons: [
        LessonEntry(
          title: "Les différents étiologies de situations d'urgence",
          description: "Die verschiedenen Ätiologien von Notfallsituationen",
          image: 'assets/img/emergency.png',
          pageBuilder: () => const Lesson1C10Page(),
        ),
        LessonEntry(
          title: "La conduite à tenir chez l'adulte",
          description: "Das Verhalten bei Erwachsenen",
          image: 'assets/img/doctor-consultation.png',
          pageBuilder: () => const Lesson2C10Page(),
        ),
        LessonEntry(
          title: "La prise en charge complémentaire",
          description: "Die zusätzlichen Maßnahmen",
          image: 'assets/img/medical-checkup.png',
          pageBuilder: () => const Lesson3C10Page(),
        ),
      ],
    );
  }
}
