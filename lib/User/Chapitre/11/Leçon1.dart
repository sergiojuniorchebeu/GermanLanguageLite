import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C11Page extends StatelessWidget {
  const Lesson1C11Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 11,
      accentColor: kPeach,
      accentLight: kPeachLight,
      title: "Le transfert et la sortie",
      content: "\"Le transfert et la sortie\" signifie \"Die Verlegung und die Entlassung\" en allemand. Ce guide explique les étapes pour le transfert des patients et leur sortie.",
      examples: [
        PhraseEntry(phrase: "Für die interne Verlegung gelten die internen Pflegestandards.", meaning: "Pour le transfert interne, il faut suivre la procédure de l'établissement."),
        PhraseEntry(phrase: "Für die externe Verlegung wird die Pflegeüberleitung ausgefüllt.", meaning: "Pour le transfert externe, il faut compléter une fiche de liaison."),
        PhraseEntry(phrase: "Sie werden heute entlassen:", meaning: "Vous pouvez sortir aujourd'hui :"),
        PhraseEntry(phrase: "nach Hause", meaning: "à domicile (m.)"),
        PhraseEntry(phrase: "ins (Alten-)Pflegeheim", meaning: "en EHPAD / en maison de retraite (f.)"),
        PhraseEntry(phrase: "in die Rehabilitation (ugs.: Reha)", meaning: "en SSR / en rééducation (f.)"),
        PhraseEntry(phrase: "in ein anderes Krankenhaus", meaning: "dans un autre hôpital"),
        PhraseEntry(phrase: "Hier sind Ihre Entlassungspapiere.", meaning: "Voici vos papiers de sortie."),
        PhraseEntry(phrase: "Sie müssen zu Ihrem Hausarzt gehen.", meaning: "Il faudra aller chez votre médecin traitant."),
        PhraseEntry(phrase: "Haben Sie alles eingepackt?", meaning: "Est-ce que vous avez tout emporté / tout mis dans votre sac ?"),
        PhraseEntry(phrase: "Das Krankenpflegegespräch für den Austritt ohne / mit der Familie", meaning: "L'entretien infirmier de sortir sans / avec la famille"),
        PhraseEntry(phrase: "Ich werde Ihnen spezifische Informationen geben", meaning: "Je vais vous donner des informations spécifiques (f.)"),
        PhraseEntry(phrase: "Ich werde Sie über das Verhalten informieren.", meaning: "Je vais vous informer sur la conduite à tenir."),
        PhraseEntry(phrase: "Ich werde Sie über die Maßnahmen informieren.", meaning: "Je vais vous informer sur les mesures à suivre (f.)"),
        PhraseEntry(phrase: "Hier sind Ihre Entlassungspapiere. Haben Sie Fragen?", meaning: "Voici vos papiers de sortie. Est-ce que vous avez des questions ?"),
        PhraseEntry(phrase: "Ich werde Ihnen Ihre Wertsachen übergeben.", meaning: "Je vais vous remettre vos objets de valeurs."),
        PhraseEntry(phrase: "Hier ist der Zufriedenheitsfragebogen. Können Sie ihn ausfüllen?", meaning: "Voici le questionnaire de satisfaction. Est-ce que vous pouvez le remplir ?"),
        PhraseEntry(phrase: "Ich werde die Informationen in der Patientenakte vermerken.", meaning: "Je vais tracer les informations dans le dossier du patient."),
        PhraseEntry(phrase: "Muss ich für Sie einen Krankenwagen rufen?", meaning: "Est-ce que je dois vous commander une ambulance ?"),
      ],
    );
  }
}
