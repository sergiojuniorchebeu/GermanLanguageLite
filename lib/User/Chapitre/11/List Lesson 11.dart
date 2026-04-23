import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'Leçon1.dart';

class LessonList11Page extends StatelessWidget {
  const LessonList11Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 11,
      chapterTitleFR: "La sortie & le transfert",
      chapterTitleDE: "Die Entlassung & Verlegung",
      lessons: [
        ChapterLessonListEntry(
          title: "Le transfert et la sortie",
          description:
              "Travaillez les phrases utiles pour organiser un transfert ou une sortie.",
          image: 'assets/img/ambulance.png',
          lessonId: "Le transfert et la sortie",
          requiredXp: 2520,
          buttonColor: kPeach,
          pageBuilder: _lesson1Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C11Page();
