import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'package:projet2/User/Chapitre/1/lecon2.dart';
import 'package:projet2/User/Chapitre/1/lecon3.dart';
import 'package:projet2/User/Chapitre/1/lecon4.dart';
import 'package:projet2/User/Chapitre/1/lecon5.dart';
import 'lecon1.dart';

class LessonListPage extends StatelessWidget {
  const LessonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 1,
      chapterTitleFR: "L'admission d'un patient",
      chapterTitleDE: "Die Aufnahme eines Patienten",
      accentColor: kBlue,
      accentLight: kBlueLight,
      lessons: [
        LessonEntry(
          title: 'Se présenter : sich vorstellen',
          description: 'Apprenez les bases Pour se Presenter.',
          image: 'assets/img/conversation.png',
          pageBuilder: () => const Lesson1C1Page(),
        ),
        LessonEntry(
          title: "Les papiers d'admission le formulaire d'admission",
          description: "le formulaire d'admission fait référence aux documents nécessaires ou au processus d'inscription",
          image: 'assets/img/healthcare.png',
          pageBuilder: () => const Lesson2C1Page(),
        ),
        LessonEntry(
          title: "L'entretien d'orientation : das Orientierungsgespräch",
          description: "Comprenez les différentes approches d'orientations",
          image: 'assets/img/work-orientation.png',
          pageBuilder: () => const Lesson3C1Page(),
        ),
        LessonEntry(
          title: "L'entretien d'accueil",
          description: 'das Aufnahmegespräch',
          image: 'assets/img/acceuil.png',
          pageBuilder: () => const Lesson4C1Page(),
        ),
        LessonEntry(
          title: '"Le recueil de données"',
          description: "Die Datenerhebung",
          image: 'assets/img/user.png',
          pageBuilder: () => const Lesson5C1Page(),
        ),
      ],
    );
  }
}
