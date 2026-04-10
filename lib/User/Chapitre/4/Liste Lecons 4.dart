import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'lecon1.dart';
import 'lecon2.dart';
import 'lecon3.dart';

class LessonList4Page extends StatelessWidget {
  const LessonList4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 4,
      chapterTitleFR: "Les soins d'hygiène",
      chapterTitleDE: "Die Grundpflege",
      accentColor: kPeach,
      accentLight: kPeachLight,
      lessons: [
        LessonEntry(
          title: 'Les soins corporels',
          description: "Les soins corporels signifie Die Körperpflege en allemand.",
          image: 'assets/img/heart.png',
          pageBuilder: () => const Lesson1C4Page(),
        ),
        LessonEntry(
          title: "Le Materiel",
          description: "",
          image: 'assets/img/scrub.png',
          pageBuilder: () => const Lesson2C4Page(),
        ),
        LessonEntry(
          title: "Solliciter le patient",
          description: "Den Patienten fördern",
          image: 'assets/img/advice.png',
          pageBuilder: () => const Lesson3C4Page(),
        ),
      ],
    );
  }
}
