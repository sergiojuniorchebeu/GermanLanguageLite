import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'leçon1.dart';
import 'leçon2.dart';
import 'leçon3.dart';

class LessonList10Page extends StatelessWidget {
  const LessonList10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 10,
      chapterTitleFR: "La conduite à tenir en urgence",
      chapterTitleDE: "Das Verhalten im Notfall",
      lessons: [
        ChapterLessonListEntry(
          title: "Les différents étiologies de situations d'urgence",
          description:
              "Découvrez les causes fréquentes des situations d'urgence et le vocabulaire clé.",
          image: 'assets/img/emergency.png',
          lessonId: "Les différents étiologies de situations d'urgence",
          requiredXp: 2180,
          buttonColor: kCoral,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "La conduite à tenir chez l'adulte",
          description:
              "Travaillez les premières mesures et les consignes à donner chez l'adulte.",
          image: 'assets/img/doctor-consultation.png',
          lessonId: "La conduite à tenir chez l'adulte",
          requiredXp: 2270,
          buttonColor: kBlue,
          pageBuilder: _lesson2Builder,
        ),
        ChapterLessonListEntry(
          title: "La prise en charge complémentaire",
          description:
              "Apprenez les mesures complémentaires et la coordination des soins en urgence.",
          image: 'assets/img/medical-checkup.png',
          lessonId: "La prise en charge complémentaire",
          requiredXp: 2370,
          buttonColor: kGreen,
          pageBuilder: _lesson3Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C10Page();
Widget _lesson2Builder() => const Lesson2C10Page();
Widget _lesson3Builder() => const Lesson3C10Page();
