import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'Lecon2.dart';
import 'lecon1.dart';

class LessonListPage2 extends StatelessWidget {
  const LessonListPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 2,
      chapterTitleFR: "La mesure des paramètres",
      chapterTitleDE: "Die Messung der Parameter",
      lessons: [
        ChapterLessonListEntry(
          title: "Les constantes",
          description:
              'Travaillez les constantes, les paramètres vitaux et le vocabulaire associé.',
          image: 'assets/img/medical-history.png',
          lessonId: "Les constantes",
          requiredXp: 180,
          buttonColor: kGreen,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "L'évaluation de la douleur",
          description: 'Apprenez à évaluer la douleur en allemand.',
          image: 'assets/img/muscle-pain.png',
          lessonId: "L'évaluation de la douleur",
          requiredXp: 230,
          buttonColor: kCoral,
          pageBuilder: _lesson2Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C2Page();
Widget _lesson2Builder() => const Lesson2C2Page();
