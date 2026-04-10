import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'Leçon1.dart';

class LessonList11Page extends StatelessWidget {
  const LessonList11Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 11,
      chapterTitleFR: "La sortie & le transfert",
      chapterTitleDE: "Die Entlassung & Verlegung",
      accentColor: kPeach,
      accentLight: kPeachLight,
      lessons: [
        LessonEntry(
          title: "Le transfert et la sortie",
          description: "Die Verlegung und die Entlassung",
          image: 'assets/img/ambulance.png',
          pageBuilder: () => const Lesson1C11Page(),
        ),
      ],
    );
  }
}
