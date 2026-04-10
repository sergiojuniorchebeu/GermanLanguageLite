import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C6Page extends StatelessWidget {
  const Lesson2C6Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 6,
      accentColor: kYellow,
      accentLight: kYellowLight,
      title: "La coronarographie",
      content: "\"La coronarographie\" signifie \"Die Koronarangiographie\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Vor dem Eingriff", meaning: "Avant l'intervention"),
        PhraseEntry(phrase: "Ich werde Ihre Leistengegend rasieren.", meaning: "Je vais vous raser le pli de l'aine."),
        PhraseEntry(phrase: "Ich werde Ihnen eine Infusion legen.", meaning: "Je vais vous poser une perfusion."),
        PhraseEntry(phrase: "Sie werden während des Eingriffs wach sein.", meaning: "Vous serez réveillé durant cette intervention."),
        PhraseEntry(phrase: "Während des Eingriffs", meaning: "Pendant l'intervention"),
        PhraseEntry(phrase: "Sie müssen auf dem Tisch rutschen.", meaning: "Il faut glisser sur la table."),
        PhraseEntry(phrase: "Sie müssen ruhig liegen bleiben.", meaning: "Il faut rester allongé sans bouger."),
        PhraseEntry(phrase: "Sie müssen die Hände hinter den Kopf legen.", meaning: "Il faut mettre les mains derrière la tête."),
        PhraseEntry(phrase: "Sie müssen das Bein ausgestreckt halten.", meaning: "Il faut garder la jambe allongée."),
        PhraseEntry(phrase: "Sie müssen ruhig in die Maske atmen.", meaning: "Il faut respirer calmement dans le masque."),
        PhraseEntry(phrase: "Sie müssen durch die Nase einatmen und durch den Mund ausatmen.", meaning: "Il faut inspirer par le nez / expirer par la bouche."),
        PhraseEntry(phrase: "Sie müssen das Medikament schlucken.", meaning: "Il faut avaler le médicament."),
        PhraseEntry(phrase: "Ich werde Ihnen ein Spray unter die Zunge geben/sprühen.", meaning: "Je vais vous donner / pulvériser un spray sous la langue."),
        PhraseEntry(phrase: "Ich werde Ihnen eine Injektion geben.", meaning: "Je vais vous faire une injection."),
        PhraseEntry(phrase: "Sie können aufgrund des Kontrastmittels ein Wärmegefühl verspüren.", meaning: "Vous pouvez ressentir une sensation de chaleur (avoir chaud) à cause du produit de contraste."),
        PhraseEntry(phrase: "Nach dem Eingriff", meaning: "Après l'intervention"),
        PhraseEntry(phrase: "Sie müssen 4 bis 6 Stunden strikte Bettruhe einhalten.", meaning: "Il faudra garder un repos strict au lit pendant 4 à 6 heures."),
        PhraseEntry(phrase: "Sie müssen einen Kompressionsverband und/oder Sandsack in der Leistengegend behalten.", meaning: "Il faudra garder un pansement compressif et/ou sac de sable au niveau du pli de l'aine."),
      ],
    );
  }
}
