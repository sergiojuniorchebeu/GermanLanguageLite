import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'leçon1.dart';
import 'leçon2.dart';
import 'leçon3.dart';
import 'leçon4.dart';

class LessonList9Page extends StatelessWidget {
  const LessonList9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 9,
      chapterTitleFR: "Les soins thérapeutiques",
      chapterTitleDE: "Die Behandlungspflege",
      lessons: [
        ChapterLessonListEntry(
          title: "La perfusion",
          description:
              "Apprenez le vocabulaire des perfusions et des manipulations associées.",
          image: 'assets/img/saline.png',
          lessonId: "La perfusion",
          requiredXp: 1860,
          buttonColor: kPurple,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "La sonde urinaire",
          description:
              "Travaillez les échanges autour de la sonde urinaire et de sa surveillance.",
          image: 'assets/img/medical.png',
          lessonId: "La sonde urinaire",
          requiredXp: 1940,
          buttonColor: kBlue,
          pageBuilder: _lesson2Builder,
        ),
        ChapterLessonListEntry(
          title: "Les voies d'administration des médicaments",
          description:
              "Identifiez les différentes voies d'administration des médicaments.",
          image: 'assets/img/schedule.png',
          lessonId: "Les voies d'administration des médicaments",
          requiredXp: 2030,
          buttonColor: kGreen,
          pageBuilder: _lesson3Builder,
        ),
        ChapterLessonListEntry(
          title: "La préparation et la distribution des médicaments",
          description:
              "Apprenez les formulations liées à la préparation et à la distribution des médicaments.",
          image: 'assets/img/calendar.png',
          lessonId: "La préparation et la distribution des médicaments",
          requiredXp: 2130,
          buttonColor: kCoral,
          pageBuilder: _lesson4Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C9Page();
Widget _lesson2Builder() => const Lesson2C9Page();
Widget _lesson3Builder() => const Lesson3C9Page();
Widget _lesson4Builder() => const Lesson4C9Page();
