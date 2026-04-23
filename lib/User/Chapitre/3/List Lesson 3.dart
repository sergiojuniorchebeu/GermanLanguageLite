import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'Lecon2.dart';
import 'Lecon4.dart';
import 'lecon1.dart';
import 'lecon3.dart';

class LessonListPage3 extends StatelessWidget {
  const LessonListPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 3,
      chapterTitleFR: "Manger – boire – éliminer",
      chapterTitleDE: "Essen – trinken – ausscheiden",
      lessons: [
        ChapterLessonListEntry(
          title: "Les différents régimes",
          description: 'Découvrez les régimes et consignes alimentaires.',
          image: 'assets/img/diet.png',
          lessonId: "Les différents régimes",
          requiredXp: 360,
          buttonColor: kPurple,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "Les troubles digestifs",
          description:
              "Comprenez les symptômes digestifs et les plaintes fréquentes.",
          image: 'assets/img/gastrointestinal-tract.png',
          lessonId: "Les troubles digestifs",
          requiredXp: 410,
          buttonColor: kGreen,
          pageBuilder: _lesson2Builder,
        ),
        ChapterLessonListEntry(
          title: "La nutrition artificielle",
          description:
              "Apprenez le vocabulaire lié à l'alimentation artificielle.",
          image: 'assets/img/home-delivery.png',
          lessonId: "La nutrition artificielle",
          requiredXp: 470,
          buttonColor: kBlue,
          pageBuilder: _lesson3Builder,
        ),
        ChapterLessonListEntry(
          title: "Les éliminations",
          description:
              "Travaillez les besoins d'élimination et le vocabulaire associé.",
          image: 'assets/img/pee.png',
          lessonId: "Les éliminations",
          requiredXp: 540,
          buttonColor: kPeach,
          pageBuilder: _lesson4Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C3Page();
Widget _lesson2Builder() => const Lesson2C3Page();
Widget _lesson3Builder() => const Lesson3C3Page();
Widget _lesson4Builder() => const Lesson4C4Page();
