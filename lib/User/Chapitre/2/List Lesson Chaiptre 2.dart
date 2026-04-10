import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_list_template.dart';
import 'Lecon2.dart';
import 'lecon1.dart';

class LessonListPage2 extends StatelessWidget {
  const LessonListPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonListTemplate(
      chapterNumber: 2,
      chapterTitleFR: "La mesure des paramètres",
      chapterTitleDE: "Die Messung der Parameter",
      accentColor: kGreen,
      accentLight: kGreenLight,
      lessons: [
        LessonEntry(
          title: "Les constantes",
          description: "le formulaire d'admission fait référence aux documents nécessaires ou au processus d'inscription",
          image: 'assets/img/medical-history.png',
          pageBuilder: () => const Lesson1C2Page(),
        ),
        LessonEntry(
          title: "L'évaluation de la douleur",
          description: 'Apprenez à évaluer la douleur en Allemand.',
          image: 'assets/img/muscle-pain.png',
          pageBuilder: () => const Lesson2C2Page(),
        ),
      ],
    );
  }
}
