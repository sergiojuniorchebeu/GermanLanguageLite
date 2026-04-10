import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson3C8Page extends StatelessWidget {
  const Lesson3C8Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 8,
      accentColor: kGreen,
      accentLight: kGreenLight,
      title: "La surveillance post opératoire",
      content: "\"La surveillance post opératoire\" signifie \"Die postoperative Überwachung\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde Ihre Vitalwerte überprüfen.", meaning: "Je vais vérifier vos constantes vitales."),
        PhraseEntry(phrase: "Haben Sie Schmerzen?", meaning: "Avez-vous des douleurs ?"),
        PhraseEntry(phrase: "Können Sie Ihre Beine bewegen?", meaning: "Pouvez-vous bouger vos jambes ?"),
        PhraseEntry(phrase: "Haben Sie Übelkeit oder Erbrechen?", meaning: "Est-ce que vous ressentez des nausées ou des vomissements ?"),
        PhraseEntry(phrase: "Ich werde Ihren Verband kontrollieren.", meaning: "Je vais contrôler votre pansement."),
        PhraseEntry(phrase: "Ich werde Ihre Infusion überprüfen.", meaning: "Je vais vérifier votre perfusion."),
        PhraseEntry(phrase: "Sie müssen jede Art von Schmerzen oder Unwohlsein melden.", meaning: "Il faudra signaler toute douleur ou inconfort."),
        PhraseEntry(phrase: "Ich werde Ihnen helfen, sich allmählich zu mobilisieren.", meaning: "Je vais vous aider à vous mobiliser progressivement."),
        PhraseEntry(phrase: "Wir werden das Risiko postoperativer Komplikationen vorbeugen.", meaning: "Nous allons prévenir les risques de complications post-opératoires."),
        PhraseEntry(phrase: "Die Operation ist gut verlaufen, es gab keine Komplikationen.", meaning: "L'opération s'est bien passée, il n'y a pas eu de complications."),
        PhraseEntry(phrase: "Man hat Ihnen einen Sandsack, einen Kompressionsverband oder eine Eisblase angelegt.", meaning: "On vous a mis un sac de sable, un pansement compressif ou une vessie de glace."),
        PhraseEntry(phrase: "Sie müssen im Bett liegen bleiben.", meaning: "Vous devez rester couché au lit."),
        PhraseEntry(phrase: "Das erste Aufstehen erfolgt mit einem Krankenpfleger oder einer Krankenschwester.", meaning: "Le premier lever se fera avec un infirmier ou une infirmière."),
        PhraseEntry(phrase: "Ich werde überwachen:", meaning: "Je vais surveiller :"),
        PhraseEntry(phrase: "Die Herzfrequenz / der Puls", meaning: "La fréquence cardiaque / le pouls"),
        PhraseEntry(phrase: "Die Urinausscheidung", meaning: "La diurèse"),
        PhraseEntry(phrase: "Die Drainage", meaning: "Le drainage"),
        PhraseEntry(phrase: "Der Verband / die Verbände", meaning: "Le pansement / les pansements"),
        PhraseEntry(phrase: "Ich werde Ihren Verband / Ihre Verbände ansehen und prüfen, ob alles in Ordnung ist.", meaning: "Je vais regarder votre pansement / vos pansements et voir si tout est normal."),
        PhraseEntry(phrase: "Es kann eine Blutung oder ein Hämatom geben.", meaning: "Il peut y avoir un saignement / un hématome."),
      ],
    );
  }
}
