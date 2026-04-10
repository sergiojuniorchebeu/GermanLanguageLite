import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson3C10Page extends StatelessWidget {
  const Lesson3C10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 10,
      accentColor: kCoral,
      accentLight: kCoralLight,
      title: "La prise en charge complémentaire",
      content: "\"La prise en charge complémentaire\" signifie \"Die zusätzlichen Maßnahmen\" en allemand. Ce guide explique les mesures complémentaires à prendre en charge en cas d'urgence, incluant l'observation de la respiration et l'administration d'oxygène.",
      examples: [
        PhraseEntry(phrase: "Ich werde die Atemfrequenz und die Sauerstoffsättigung messen.", meaning: "Je vais mesurer la fréquence respiratoire et la saturation en oxygène."),
        PhraseEntry(phrase: "Ich werde das Atmen beobachten:", meaning: "Je vais observer la respiration :"),
        PhraseEntry(phrase: "Hyper-/Hypoventilation", meaning: "Hyper/Hypoventilation"),
        PhraseEntry(phrase: "Paradoxe Atmung", meaning: "Respiration paradoxale"),
        PhraseEntry(phrase: "Atempause", meaning: "Pause respiratoire"),
        PhraseEntry(phrase: "Atemstillstand", meaning: "Apnée"),
        PhraseEntry(phrase: "Ich werde Ihnen Sauerstoff geben mit:", meaning: "Je vais vous mettre de l'oxygène avec :"),
        PhraseEntry(phrase: "Einer Nasensonde", meaning: "Une sonde nasale"),
        PhraseEntry(phrase: "Einer Sauerstoffbrille", meaning: "Des lunettes à oxygène"),
        PhraseEntry(phrase: "Einer Sauerstoffmaske", meaning: "Un masque à oxygène"),
        PhraseEntry(phrase: "Einer NIV (nicht-invasive Beatmung)", meaning: "Une VNI (ventilation non invasive)"),
        PhraseEntry(phrase: "Dem Beatmungsbeutel (BAVU)", meaning: "Un ballon de ventilation (BAVU)"),
        PhraseEntry(phrase: "Ich werde Ihnen ein Aerosol geben.", meaning: "Je vais vous poser un aérosol."),
        PhraseEntry(phrase: "Ich werde Ihnen eine Guedel-Kanüle/Wendel-Kanüle legen.", meaning: "Je vais vous poser une canule de Guedel/canule de Wendel."),
        PhraseEntry(phrase: "Ich werde Sie endotracheal absaugen (durch die Nase / durch den Mund).", meaning: "Je vais vous aspirer en endotrachéale (par le nez / par la bouche)."),
        PhraseEntry(phrase: "Endotracheale Absaugung.", meaning: "Aspiration endo-trachéale."),
      ],
    );
  }
}
