import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'lecon1.dart';
import 'lecon2.dart';

class LessonList5Page extends StatelessWidget {
  const LessonList5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 5,
      chapterTitleFR: "La physiopathologie",
      chapterTitleDE: "Die Pathophysiologie",
      accentColor: kCoral,
      accentLight: kCoralLight,
      lessons: [
        LessonEntry(
          title: "L'observation",
          description: "Die Beobachtung",
          image: 'assets/img/research.png',
          pageBuilder: () => const Lesson1C5Page(),
        ),
        LessonEntry(
          title: "L'écoute des plaintes",
          description: "Das Zuhören der Beschwerden",
          image: 'assets/img/doctor-visit.png',
          pageBuilder: () => const Lesson2C5Page(),
        ),
      ],
    );
  }
}
