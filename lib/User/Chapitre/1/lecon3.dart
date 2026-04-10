import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson3C1Page extends StatelessWidget {
  const Lesson3C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 1,
      accentColor: kBlue,
      accentLight: kBlueLight,
      title: "L'entretien d'orientation",
      content: "\"L'entretien d'orientation\" signifie \"das Orientierungsgespräch\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde Ihnen erklären, wie Sie sich in der Abteilung und im Krankenhaus orientieren können.", meaning: "Je vais vous expliquer comment vous orienter dans le service et dans l'hôpital."),
        PhraseEntry(phrase: "Ich werde Ihnen erklären, wo Sie Ihre persönlichen Sachen aufbewahren können.", meaning: "Je vais vous expliquer où mettre vos affaires personnelles."),
        PhraseEntry(phrase: "Ich werde Ihnen erklären, was Sie mit Ihren Wertsachen machen sollen.", meaning: "Je vais vous expliquer que faire de vos objets de valeur."),
        PhraseEntry(phrase: "Ich werde Ihnen den Tagesablauf erklären.", meaning: "Je vais vous expliquer le déroulement de la journée."),
        PhraseEntry(phrase: "Ich werde Ihnen die Besuchszeiten erklären.", meaning: "Je vais vous expliquer les heures de visite."),
        PhraseEntry(phrase: "Ich werde Ihnen die Zeiten der ärztlichen Visiten erklären.", meaning: "Je vais vous expliquer les heures de visites médicales."),
        PhraseEntry(phrase: "Ich werde Ihnen die Übergabezeiten erklären.", meaning: "Je vais vous expliquer les heures de transmissions."),
        PhraseEntry(phrase: "Ich werde Ihnen die Essenszeiten erklären.", meaning: "Je vais vous expliquer les heures de repas."),
        PhraseEntry(phrase: "Ich werde Ihnen die Ruhezeiten erklären.", meaning: "Je vais vous expliquer les heures de repos."),
        PhraseEntry(phrase: "Falls Sie etwas brauchen, hier ist die Klingel.", meaning: "Si vous avez besoin de quelque chose, voici la sonnerie."),
        PhraseEntry(phrase: "Ich werde Ihnen ein paar Fragen stellen, um Sie besser kennenzulernen.", meaning: "Je vais vous poser quelques questions pour mieux vous connaître."),
        PhraseEntry(phrase: "Was ist Ihr Hauptinteressensgebiet?", meaning: "Quel est votre domaine d'intérêt principal ?"),
        PhraseEntry(phrase: "Was sind Ihre beruflichen Ziele?", meaning: "Quels sont vos objectifs professionnels ?"),
        PhraseEntry(phrase: "Haben Sie schon eine genaue Vorstellung von Ihrem Werdegang?", meaning: "Avez-vous déjà une idée précise de votre parcours ?"),
        PhraseEntry(phrase: "Möchten Sie mehrere Optionen erkunden, bevor Sie sich entscheiden?", meaning: "Souhaitez-vous explorer plusieurs options avant de choisir ?"),
        PhraseEntry(phrase: "Dieses Gespräch soll Ihnen helfen, Ihren Weg zu finden.", meaning: "Cet entretien vise à vous aider à trouver votre voie."),
      ],
    );
  }
}
