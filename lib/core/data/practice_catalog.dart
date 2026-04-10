import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class ConversationSituation {
  final String id;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color accentLight;
  final List<PhraseEntry> phrases;

  const ConversationSituation({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.accentLight,
    required this.phrases,
  });
}

class ProfessionalExpressionGroup {
  final String id;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color accentLight;
  final List<PhraseEntry> phrases;

  const ProfessionalExpressionGroup({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.accentLight,
    required this.phrases,
  });
}

class ClinicalCase {
  final String id;
  final String title;
  final String situation;
  final String prompt;
  final Color accentColor;
  final Color accentLight;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const ClinicalCase({
    required this.id,
    required this.title,
    required this.situation,
    required this.prompt,
    required this.accentColor,
    required this.accentLight,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

const List<ConversationSituation> conversationSituations = [
  ConversationSituation(
    id: 'admission',
    title: "Admission",
    subtitle: 'Accueil, orientation et dossier',
    accentColor: kBlue,
    accentLight: kBlueLight,
    phrases: [
      PhraseEntry(phrase: 'Guten Tag, Frau', meaning: 'Bonjour Madame'),
      PhraseEntry(
          phrase: 'Ich bin Krankenschwester', meaning: 'Je suis infirmière'),
      PhraseEntry(
          phrase: 'Haben Sie Ihre Bewerbungsunterlagen?',
          meaning: "Avez-vous vos papiers d'admission ?"),
      PhraseEntry(
          phrase: 'Füllen Sie bitte das Anmeldeformular aus.',
          meaning: "Veuillez remplir le formulaire d'admission."),
      PhraseEntry(
          phrase: 'Ich werde Ihnen den Tagesablauf erklären.',
          meaning: 'Je vais vous expliquer le déroulement de la journée.'),
      PhraseEntry(
          phrase: 'Falls Sie etwas brauchen, hier ist die Klingel.',
          meaning: 'Si vous avez besoin de quelque chose, voici la sonnerie.'),
      PhraseEntry(
          phrase: 'Kann ich jemanden benachrichtigen?',
          meaning: "Est-ce que je peux prévenir quelqu'un ?"),
      PhraseEntry(
          phrase: 'Wissen Sie, wo Sie sind?',
          meaning: 'Savez-vous où vous êtes ?'),
    ],
  ),
  ConversationSituation(
    id: 'douleur',
    title: 'Douleur',
    subtitle: 'Évaluation et première réponse',
    accentColor: kGreen,
    accentLight: kGreenLight,
    phrases: [
      PhraseEntry(phrase: 'Haben Sie Schmerzen?', meaning: 'Avez-vous mal ?'),
      PhraseEntry(
          phrase: 'Wo haben Sie Schmerzen?',
          meaning: 'Où avez-vous des douleurs ?'),
      PhraseEntry(
          phrase: 'Seit wann haben Sie Schmerzen?',
          meaning: 'Depuis quand avez-vous mal ?'),
      PhraseEntry(
          phrase: 'Können Sie mir die Schmerzen beschreiben?',
          meaning: 'Pouvez-vous me décrire la douleur ?'),
      PhraseEntry(
          phrase: 'Es ist ein stechender Schmerz.',
          meaning: "C'est une douleur piquante."),
      PhraseEntry(
          phrase: 'Es ist ein unerträglicher Schmerz.',
          meaning: "C'est une douleur insupportable."),
      PhraseEntry(
          phrase: 'Ich gebe Ihnen ein Schmerzmittel.',
          meaning: 'Je vais vous donner un antalgique.'),
      PhraseEntry(
          phrase: 'Ich rufe den Arzt.',
          meaning: 'Je vais prévenir le médecin.'),
    ],
  ),
  ConversationSituation(
    id: 'urgence',
    title: 'Urgence',
    subtitle: 'Premières actions et surveillance',
    accentColor: kCoral,
    accentLight: kCoralLight,
    phrases: [
      PhraseEntry(phrase: 'Kontrolle von :', meaning: 'Contrôle de :'),
      PhraseEntry(phrase: 'Bewusstsein', meaning: 'la conscience'),
      PhraseEntry(phrase: 'Atmung', meaning: 'la respiration'),
      PhraseEntry(phrase: 'Notruf', meaning: "Numéros d'urgence"),
      PhraseEntry(
          phrase: 'Stabile Seitenlage',
          meaning: 'Position latérale de sécurité (PLS)'),
      PhraseEntry(
          phrase: 'Herz-Lungen-Wiederbelebung',
          meaning: 'Réanimation cardio-pulmonaire'),
      PhraseEntry(
          phrase:
              'Ich werde die Atemfrequenz und die Sauerstoffsättigung messen.',
          meaning:
              'Je vais mesurer la fréquence respiratoire et la saturation en oxygène.'),
      PhraseEntry(
          phrase: 'Einer Sauerstoffmaske', meaning: 'Un masque à oxygène'),
    ],
  ),
  ConversationSituation(
    id: 'sortie',
    title: 'Sortie',
    subtitle: 'Transfert, consignes et documents',
    accentColor: kPeach,
    accentLight: kPeachLight,
    phrases: [
      PhraseEntry(
          phrase: 'Sie werden heute entlassen:',
          meaning: "Vous pouvez sortir aujourd'hui :"),
      PhraseEntry(
          phrase: 'Hier sind Ihre Entlassungspapiere.',
          meaning: 'Voici vos papiers de sortie.'),
      PhraseEntry(
          phrase: 'Sie müssen zu Ihrem Hausarzt gehen.',
          meaning: 'Il faudra aller chez votre médecin traitant.'),
      PhraseEntry(
          phrase: 'Ich werde Ihnen spezifische Informationen geben',
          meaning: 'Je vais vous donner des informations spécifiques (f.)'),
      PhraseEntry(
          phrase: 'Ich werde Sie über das Verhalten informieren.',
          meaning: 'Je vais vous informer sur la conduite à tenir.'),
      PhraseEntry(
          phrase: 'Ich werde Sie über die Maßnahmen informieren.',
          meaning: 'Je vais vous informer sur les mesures à suivre (f.)'),
      PhraseEntry(
          phrase:
              'Hier ist der Zufriedenheitsfragebogen. Können Sie ihn ausfüllen?',
          meaning:
              'Voici le questionnaire de satisfaction. Est-ce que vous pouvez le remplir ?'),
      PhraseEntry(
          phrase: 'Muss ich für Sie einen Krankenwagen rufen?',
          meaning: 'Est-ce que je dois vous commander une ambulance ?'),
    ],
  ),
];

const List<ProfessionalExpressionGroup> professionalExpressionGroups = [
  ProfessionalExpressionGroup(
    id: 'patient',
    title: 'Infirmier vers patient',
    subtitle: 'Consignes et accompagnement direct',
    accentColor: kBlue,
    accentLight: kBlueLight,
    phrases: [
      PhraseEntry(
          phrase: 'Ich messe jetzt Ihre Temperatur.',
          meaning: 'Je vais prendre votre température.'),
      PhraseEntry(
          phrase: 'Ich werde Sie für die Operation vorbereiten.',
          meaning: "Je vais vous préparer pour l'opération."),
      PhraseEntry(
          phrase: 'Sie müssen nüchtern bleiben.',
          meaning: 'Il faudra être à jeun.'),
      PhraseEntry(
          phrase: 'Ich werde Ihnen Blut abnehmen.',
          meaning: 'Je vais vous faire une prise de sang.'),
      PhraseEntry(
          phrase: 'Können Sie die Faust schließen?',
          meaning: 'Pouvez-vous fermer le poing?'),
      PhraseEntry(
          phrase: 'Es wird ein wenig stechen.',
          meaning: 'Ça va piquer un peu.'),
      PhraseEntry(
          phrase: 'Ich werde Ihren Verband kontrollieren.',
          meaning: 'Je vais contrôler votre pansement.'),
      PhraseEntry(
          phrase: 'Sie müssen jede Art von Schmerzen oder Unwohlsein melden.',
          meaning: 'Il faudra signaler toute douleur ou inconfort.'),
    ],
  ),
  ProfessionalExpressionGroup(
    id: 'medecin',
    title: 'Infirmier vers médecin',
    subtitle: 'Signalement clinique et relais',
    accentColor: kCoral,
    accentLight: kCoralLight,
    phrases: [
      PhraseEntry(
          phrase: 'Ich rufe den Arzt.',
          meaning: 'Je vais prévenir le médecin.'),
      PhraseEntry(
          phrase: 'Der Patient klagt über...',
          meaning: 'Le patient se plaint de...'),
      PhraseEntry(phrase: 'Eine Blutung', meaning: 'Un saignement'),
      PhraseEntry(
          phrase: 'Dyspnoe (f.) / Atemnot (f.)',
          meaning: 'Une dyspnée / une détresse respiratoire'),
      PhraseEntry(phrase: 'Eine Verwirrtheit', meaning: 'Une confusion'),
      PhraseEntry(phrase: 'Palpitationen (f.)', meaning: 'Palpitations (f.)'),
      PhraseEntry(phrase: 'Schwindel (m.)', meaning: 'Vertige (m.)'),
      PhraseEntry(phrase: 'Kopfschmerzen (f.)', meaning: 'Céphalées (f.)'),
    ],
  ),
  ProfessionalExpressionGroup(
    id: 'transmission',
    title: 'Transmission équipe',
    subtitle: 'Organisation et continuité des soins',
    accentColor: kPurple,
    accentLight: kPurpleLight,
    phrases: [
      PhraseEntry(
          phrase: 'Ich werde Ihnen die Übergabezeiten erklären.',
          meaning: 'Je vais vous expliquer les heures de transmissions.'),
      PhraseEntry(
          phrase: 'Wir werden die folgenden Blutwerte überprüfen.',
          meaning: 'Nous allons vérifier les valeurs sanguines suivantes.'),
      PhraseEntry(
          phrase:
              'Für die externe Verlegung wird die Pflegeüberleitung ausgefüllt.',
          meaning:
              'Pour le transfert externe, il faut compléter une fiche de liaison.'),
      PhraseEntry(
          phrase: 'Ich werde die Informationen in der Patientenakte vermerken.',
          meaning:
              'Je vais tracer les informations dans le dossier du patient.'),
      PhraseEntry(
          phrase:
              'Ich werde überprüfen, was der Arzt verschrieben hat. (= die ärztliche Verordnung)',
          meaning:
              'Je vais vérifier ce que le médecin a prescrit. (= la prescription médicale)'),
      PhraseEntry(
          phrase:
              'Wir werden das Risiko postoperativer Komplikationen vorbeugen.',
          meaning:
              'Nous allons prévenir les risques de complications post-opératoires.'),
      PhraseEntry(
          phrase:
              'Die Operation ist gut verlaufen, es gab keine Komplikationen.',
          meaning:
              "L'opération s'est bien passée, il n'y a pas eu de complications."),
      PhraseEntry(
          phrase:
              'Das Krankenpflegegespräch für den Austritt ohne / mit der Familie',
          meaning: "L'entretien infirmier de sortir sans / avec la famille"),
    ],
  ),
];

const List<ClinicalCase> clinicalCases = [
  ClinicalCase(
    id: 'case_admission',
    title: 'Admission en chambre',
    situation:
        'Un patient arrive pour son admission. Vous commencez l’accueil et devez lancer la conversation.',
    prompt: 'Quelle phrase convient le mieux pour débuter ?',
    accentColor: kBlue,
    accentLight: kBlueLight,
    options: [
      'Guten Tag, Frau',
      'Ich werde Ihnen Blut abnehmen.',
      'Herz-Lungen-Wiederbelebung',
      'Morgens nüchtern',
    ],
    correctIndex: 0,
    explanation: 'La salutation d’accueil vient du chapitre 1 sur l’admission.',
  ),
  ClinicalCase(
    id: 'case_pain',
    title: 'Douleur thoracique',
    situation:
        'Le patient vous dit qu’il a mal. Vous voulez commencer l’évaluation correctement.',
    prompt: 'Quelle question poser en premier ?',
    accentColor: kGreen,
    accentLight: kGreenLight,
    options: [
      'Wo haben Sie Schmerzen?',
      'Ein MRT (Magnetresonanztomographie)',
      'Die Zahnbürste',
      'nach Hause',
    ],
    correctIndex: 0,
    explanation:
        'La priorité est de localiser la douleur avec une formule du chapitre 2.',
  ),
  ClinicalCase(
    id: 'case_hygiene',
    title: 'Aide à la toilette',
    situation: 'Une patiente âgée demande de l’aide pour sa toilette du matin.',
    prompt: 'Quelle phrase est la plus adaptée ?',
    accentColor: kPeach,
    accentLight: kPeachLight,
    options: [
      'Brauchen Sie Hilfe bei der Körperpflege?',
      'Die Leukozyten',
      'Notruf',
      'Ich werde die Infusionsleitung entlüften.',
    ],
    correctIndex: 0,
    explanation:
        'Cette proposition vient du chapitre 4 sur les soins corporels.',
  ),
  ClinicalCase(
    id: 'case_exam',
    title: 'Préparation d’examen',
    situation:
        'Avant une coronarographie, vous devez donner une consigne de sécurité.',
    prompt: 'Quelle phrase utilisez-vous ?',
    accentColor: kYellow,
    accentLight: kYellowLight,
    options: [
      'Sie müssen ruhig liegen bleiben.',
      'Eine lokale Anästhesie',
      'die Wechselwirkungen',
      'Haben Sie Durchfall?',
    ],
    correctIndex: 0,
    explanation: 'La consigne vient du chapitre 6 sur la coronarographie.',
  ),
  ClinicalCase(
    id: 'case_postop',
    title: 'Retour de bloc',
    situation:
        'Un patient revient du bloc opératoire. Vous commencez la surveillance post-opératoire.',
    prompt: 'Quelle action annoncer en priorité ?',
    accentColor: kGreen,
    accentLight: kGreenLight,
    options: [
      'Ich werde Ihre Vitalwerte überprüfen.',
      'Füllen Sie bitte das Anmeldeformular aus.',
      'Der Stauschlauch',
      'Schwindel (m.)',
    ],
    correctIndex: 0,
    explanation: 'La surveillance des constantes vient du chapitre 8.',
  ),
  ClinicalCase(
    id: 'case_urgent',
    title: 'Détresse vitale',
    situation:
        'Vous trouvez une personne en arrêt cardio-respiratoire et devez choisir la conduite à tenir.',
    prompt: 'Quelle expression correspond à l’action principale ?',
    accentColor: kCoral,
    accentLight: kCoralLight,
    options: [
      'Herz-Lungen-Wiederbelebung',
      'Eine salzarme Diät',
      'Die Bettlaken',
      'Hier sind Ihre Entlassungspapiere.',
    ],
    correctIndex: 0,
    explanation: 'La réanimation cardio-pulmonaire est issue du chapitre 10.',
  ),
  ClinicalCase(
    id: 'case_discharge',
    title: 'Sortie du patient',
    situation:
        'Le patient quitte le service. Vous devez remettre les documents et vérifier la compréhension.',
    prompt: 'Quelle phrase convient le mieux ?',
    accentColor: kPeach,
    accentLight: kPeachLight,
    options: [
      'Hier sind Ihre Entlassungspapiere. Haben Sie Fragen?',
      'Ein Antiseptikum',
      'Die Teilkörperpflege im Bett / am Waschbecken',
      'Atemstillstand',
    ],
    correctIndex: 0,
    explanation: 'Cette formulation vient du chapitre 11 sur la sortie.',
  ),
];
