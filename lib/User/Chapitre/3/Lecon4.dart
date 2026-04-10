import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson4C4Page extends StatelessWidget {
  const Lesson4C4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 3,
      accentColor: kPurple,
      accentLight: kPurpleLight,
      title: "Les éliminations",
      content: "\"Les éliminations\" signifie \"Die Ausscheidungen\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Der Harn", meaning: "Les urines"),
        PhraseEntry(phrase: "Wie oft urinieren Sie täglich? Viel / wenig Urin.", meaning: "Combien de fois urinez-vous par jour ? Une grande / petite quantité."),
        PhraseEntry(phrase: "Haben Sie beim Wasserlassen ein Brennen?", meaning: "Avez-vous des brûlures mictionnelles ?"),
        PhraseEntry(phrase: "Spüren Sie einen Druck in der Blase?", meaning: "Est-ce que vous sentez une pression au niveau de la vessie ?"),
        PhraseEntry(phrase: "Haben Sie konzentrierten Urin?", meaning: "Avez-vous des urines concentrées ?"),
        PhraseEntry(phrase: "Halten Sie ein bisschen Urin zurück oder verlieren Sie Urin im Liegen?", meaning: "Est-ce que vous retenez une petite quantité d'urine ou perdez-vous de l'urine en position couchée ?"),
        PhraseEntry(phrase: "Können Sie im Liegen urinieren?", meaning: "Pouvez-vous uriner en position couchée ?"),
        PhraseEntry(phrase: "Brauchen Sie einen Harnflasche oder eine Bettpfanne?", meaning: "Avez-vous besoin d'un urinal / bassin ?"),
        PhraseEntry(phrase: "Können Sie ein Urinal oder eine Bettpfanne im Liegen benutzen?", meaning: "Est-ce que vous arrivez à utiliser un urinal / bassin couché(e) ?"),
        PhraseEntry(phrase: "Der Stuhlgang / die Verdauung", meaning: "Les selles / le transit"),
        PhraseEntry(phrase: "Wann war Ihr letzter Stuhlgang?", meaning: "De quand date votre dernière selle ?"),
        PhraseEntry(phrase: "Haben Sie Durchfall? Sind Sie verstopft?", meaning: "Avez-vous des diarrhées / êtes constipé(e) ?"),
        PhraseEntry(phrase: "Haben Sie Blut im Stuhl?", meaning: "Avez-vous du sang dans les selles ?"),
        PhraseEntry(phrase: "Ist Ihr Stuhlgang vollständig?", meaning: "Est-ce que votre transit intestinal est complet ?"),
        PhraseEntry(phrase: "Die Übelkeit / das Erbrechen", meaning: "Les nausées (f.) / les vomissements (m.)"),
        PhraseEntry(phrase: "Ist Ihnen übel?", meaning: "Avez-vous envie de vomir ?"),
        PhraseEntry(phrase: "Haben Sie Übelkeit?", meaning: "Avez-vous des nausées ?"),
        PhraseEntry(phrase: "Haben Sie sich schon übergeben?", meaning: "Avez-vous déjà vomi ?"),
      ],
    );
  }
}
