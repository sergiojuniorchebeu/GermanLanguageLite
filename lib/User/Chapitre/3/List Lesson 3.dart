import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'Lecon2.dart';
import 'Lecon4.dart';
import 'lecon1.dart';
import 'lecon3.dart';

class LessonListPage3 extends StatelessWidget {
  const LessonListPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 3,
      chapterTitleFR: "Manger – boire – éliminer",
      chapterTitleDE: "Essen – trinken – ausscheiden",
      accentColor: kPurple,
      accentLight: kPurpleLight,
      lessons: [
        LessonEntry(
          title: "Les différents régimes",
          description: '',
          image: 'assets/img/diet.png',
          pageBuilder: () => const Lesson1C3Page(),
        ),
        LessonEntry(
          title: "Les troubles digestifs",
          description: "Les troubles digestifs signifie Die Verdauungsprobleme en allemand.",
          image: 'assets/img/gastrointestinal-tract.png',
          pageBuilder: () => const Lesson2C3Page(),
        ),
        LessonEntry(
          title: "La nutrition artificielle",
          description: "Comprenez les différentes approches d'orientations",
          image: 'assets/img/home-delivery.png',
          pageBuilder: () => const Lesson3C3Page(),
        ),
        LessonEntry(
          title: "Les éliminations",
          description: "Les éliminations signifie Die Ausscheidungen en allemand.",
          image: 'assets/img/pee.png',
          pageBuilder: () => const Lesson4C4Page(),
        ),
      ],
    );
  }
}
