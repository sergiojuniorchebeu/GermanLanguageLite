import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C4Page extends StatelessWidget {
  const Lesson1C4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 4,
      accentColor: kPeach,
      accentLight: kPeachLight,
      title: "Les soins corporels (m.)",
      content: "\"Les soins corporels\" signifie \"Die Körperpflege\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Die vollständige Körperpflege", meaning: "La toilette complète"),
        PhraseEntry(phrase: "Die Teilkörperpflege im Bett / am Waschbecken", meaning: "La toilette partielle au lit / au lavabo"),
        PhraseEntry(phrase: "Brauchen Sie Hilfe bei der Körperpflege?", meaning: "Avez-vous besoin d'aide pour la toilette ?"),
        PhraseEntry(phrase: "Können Sie sich selbst waschen? / Sind Sie selbstständig?", meaning: "Pouvez-vous vous laver seul / êtes-vous autonome ?"),
        PhraseEntry(phrase: "Soll ich eine vollständige Körperpflege durchführen?", meaning: "Dois-je faire une toilette complète ?"),
        PhraseEntry(phrase: "Können Sie sich den Rücken selbst waschen?", meaning: "Est-ce que vous arrivez à vous laver le dos ?"),
        PhraseEntry(phrase: "Soll ich die Körperpflege im Bett machen?", meaning: "Dois-je faire la toilette au lit ?"),
        PhraseEntry(phrase: "Soll ich Sie zur Toilette begleiten?", meaning: "Dois-je vous accompagner aux toilettes ?"),
      ],
    );
  }
}
