import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/chapter_lesson_list_page.dart';
import 'package:projet2/User/Chapitre/1/lecon2.dart';
import 'package:projet2/User/Chapitre/1/lecon3.dart';
import 'package:projet2/User/Chapitre/1/lecon4.dart';
import 'package:projet2/User/Chapitre/1/lecon5.dart';
import 'lecon1.dart';

class LessonListPage extends StatelessWidget {
  const LessonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChapterLessonListPage(
      chapterNumber: 1,
      chapterTitleFR: "L'admission d'un patient",
      chapterTitleDE: 'Die Aufnahme eines Patienten',
      lessons: [
        ChapterLessonListEntry(
          title: 'Se présenter : sich vorstellen',
          description: 'Apprenez les bases pour se présenter à un patient.',
          image: 'assets/img/conversation.png',
          lessonId: 'Se présenter',
          requiredXp: 0,
          buttonColor: kBlue,
          pageBuilder: _lesson1Builder,
        ),
        ChapterLessonListEntry(
          title: "Les papiers d'admission",
          description:
              "Comprenez le formulaire d'admission et les documents à demander.",
          image: 'assets/img/healthcare.png',
          lessonId: "Les papiers d'admission / le formulaire d'admission",
          requiredXp: 40,
          buttonColor: kGreen,
          pageBuilder: _lesson2Builder,
        ),
        ChapterLessonListEntry(
          title: "L'entretien d'orientation",
          description:
              "Apprenez à orienter le patient dans le service et dans l'hôpital.",
          image: 'assets/img/work-orientation.png',
          lessonId: "L'entretien d'orientation",
          requiredXp: 90,
          buttonColor: kCoral,
          pageBuilder: _lesson3Builder,
        ),
        ChapterLessonListEntry(
          title: "L'entretien d'accueil",
          description:
              'Travaillez la conversation d’accueil et les premières consignes.',
          image: 'assets/img/acceuil.png',
          lessonId: "L'entretien d'accueil",
          requiredXp: 150,
          buttonColor: kYellow,
          pageBuilder: _lesson4Builder,
        ),
        ChapterLessonListEntry(
          title: 'Le recueil de données',
          description:
              'Maîtrisez les questions de base pour collecter les informations utiles.',
          image: 'assets/img/user.png',
          lessonId: 'Le recueil de données',
          requiredXp: 220,
          buttonColor: kPeach,
          pageBuilder: _lesson5Builder,
        ),
      ],
    );
  }
}

Widget _lesson1Builder() => const Lesson1C1Page();
Widget _lesson2Builder() => const Lesson2C1Page();
Widget _lesson3Builder() => const Lesson3C1Page();
Widget _lesson4Builder() => const Lesson4C1Page();
Widget _lesson5Builder() => const Lesson5C1Page();
