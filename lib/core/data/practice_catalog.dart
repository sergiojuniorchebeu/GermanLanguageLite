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
  final Color accentColor;
  final Color accentLight;
  final int passingScore;
  final List<ClinicalCaseTurn> turns;
  final String completionMessage;

  const ClinicalCase({
    required this.id,
    required this.title,
    required this.situation,
    required this.accentColor,
    required this.accentLight,
    required this.passingScore,
    required this.turns,
    required this.completionMessage,
  });
}

class ClinicalCaseTurn {
  final String patientLine;
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String feedback;

  const ClinicalCaseTurn({
    required this.patientLine,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.feedback,
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
        'Un patient arrive pour son admission. Vous devez l accueillir, l orienter et démarrer une conversation professionnelle.',
    accentColor: kBlue,
    accentLight: kBlueLight,
    passingScore: 67,
    turns: [
      ClinicalCaseTurn(
        patientLine:
            'Bonjour, je viens pour mon admission. J ai besoin d aide.',
        prompt: 'Quelle phrase convient le mieux pour débuter ?',
        options: [
          'Ich werde gleich Ihre Unterlagen kontrollieren.',
          'Guten Tag, ich bin die Pflegekraft auf dieser Station.',
          'Bitte bleiben Sie im Bett und warten Sie hier.',
        ],
        correctIndex: 1,
        feedback:
            'Pour débuter correctement, on salue le patient et on se présente avant de donner une consigne.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Je ne sais pas quoi faire maintenant.',
        prompt: 'Quelle phrase utilisez-vous pour guider le patient ?',
        options: [
          'Wo haben Sie im Moment Schmerzen?',
          'Sie müssen zunächst nüchtern bleiben.',
          'Ich erkläre Ihnen jetzt den Ablauf der Aufnahme.',
        ],
        correctIndex: 2,
        feedback:
            'Dans une admission, on guide le patient en expliquant la suite de la prise en charge.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Si j ai besoin de quelqu un, comment je fais ?',
        prompt: 'Quelle réponse donnez-vous ?',
        options: [
          'Melden Sie sich bitte nur zur Medikamentenausgabe.',
          'Falls Sie Hilfe brauchen, benutzen Sie bitte diese Klingel.',
          'Sie können nach der Visite nach Hause gehen.',
        ],
        correctIndex: 1,
        feedback:
            'La sonnette fait partie des informations de base à l accueil.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Dois-je remplir quelque chose maintenant ?',
        prompt: 'Quelle réponse est la plus adaptée dans ce contexte ?',
        options: [
          'Bitte füllen Sie zuerst dieses Aufnahmeformular aus.',
          'Ich bringe Sie jetzt direkt in den OP.',
          'Sie müssen sechs Stunden streng im Bett bleiben.',
        ],
        correctIndex: 0,
        feedback:
            'Après l accueil, demander de compléter le formulaire d admission est cohérent.',
      ),
    ],
    completionMessage:
        'Admission validée. Vous avez mené une première conversation d accueil cohérente.',
  ),
  ClinicalCase(
    id: 'case_pain',
    title: 'Douleur thoracique',
    situation:
        'Le patient signale une douleur thoracique. Vous devez évaluer la situation avec les bonnes questions.',
    accentColor: kGreen,
    accentLight: kGreenLight,
    passingScore: 67,
    turns: [
      ClinicalCaseTurn(
        patientLine: 'Bonjour, j ai mal dans la poitrine.',
        prompt: 'Quelle question poser en premier ?',
        options: [
          'Wo haben Sie Schmerzen?',
          'Ein MRT.',
          'nach Hause',
        ],
        correctIndex: 0,
        feedback: 'La première étape est de localiser la douleur.',
      ),
      ClinicalCaseTurn(
        patientLine: 'La douleur est au centre et elle est très forte.',
        prompt: 'Quelle question permet d affiner correctement ?',
        options: [
          'Seit wann haben Sie Schmerzen?',
          'Hier sind Ihre Entlassungspapiere.',
          'Der Stauschlauch.',
        ],
        correctIndex: 0,
        feedback: 'La chronologie oriente l évaluation clinique.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Depuis environ vingt minutes.',
        prompt: 'Quelle annonce infirmière est la plus adaptée ensuite ?',
        options: [
          'Ich rufe den Arzt.',
          'Ich werde Ihren Verband erneuern.',
          'Brauchen Sie Hilfe bei der Körperpflege?',
        ],
        correctIndex: 0,
        feedback: 'Une douleur thoracique impose d escalader rapidement.',
      ),
    ],
    completionMessage:
        'Évaluation de douleur validée. Vous avez posé les bonnes questions dans le bon ordre.',
  ),
  ClinicalCase(
    id: 'case_hygiene',
    title: 'Aide à la toilette',
    situation:
        'Une patiente âgée demande de l aide pour sa toilette du matin. Vous devez l accompagner avec tact.',
    accentColor: kPeach,
    accentLight: kPeachLight,
    passingScore: 67,
    turns: [
      ClinicalCaseTurn(
        patientLine: 'Je me sens faible ce matin, pouvez-vous m aider ?',
        prompt: 'Quelle phrase est la plus adaptée ?',
        options: [
          'Brauchen Sie Hilfe bei der Körperpflege?',
          'Notruf.',
          'Ich werde die Infusionsleitung entlüften.',
        ],
        correctIndex: 0,
        feedback:
            'On valide le besoin d aide de manière simple et respectueuse.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Oui, surtout pour me lever.',
        prompt: 'Quelle proposition fait sens ensuite ?',
        options: [
          'Brauchen Sie Hilfe beim Aufstehen?',
          'Ein Antiseptikum.',
          'Haben Sie Durchfall?',
        ],
        correctIndex: 0,
        feedback: 'Le lever sécurisé est une priorité avant la toilette.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Oui, j ai peur de tomber.',
        prompt: 'Quelle action annoncez-vous ?',
        options: [
          'Ich werde das Kopfteil hochstellen.',
          'Ich werde Ihnen Blut abnehmen.',
          'Die Reanimation beginnt jetzt.',
        ],
        correctIndex: 0,
        feedback: 'On sécurise et on installe progressivement la patiente.',
      ),
    ],
    completionMessage:
        'Toilette accompagnée validée. Vous avez répondu avec une logique de soins de base.',
  ),
  ClinicalCase(
    id: 'case_exam',
    title: 'Préparation d’examen',
    situation:
        'Avant une coronarographie, vous devez préparer le patient et donner des consignes de sécurité claires.',
    accentColor: kYellow,
    accentLight: kYellowLight,
    passingScore: 67,
    turns: [
      ClinicalCaseTurn(
        patientLine: 'Je suis inquiet pour cet examen.',
        prompt: 'Quelle phrase permet de lancer la préparation ?',
        options: [
          'Ich werde Sie für diese Untersuchung vorbereiten.',
          'Haben Sie Blut im Stuhl?',
          'Nach Hause.',
        ],
        correctIndex: 0,
        feedback: 'On annonce clairement la préparation de l examen.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Que dois-je faire pendant l examen ?',
        prompt: 'Quelle consigne donnez-vous ?',
        options: [
          'Sie müssen ruhig liegen bleiben.',
          'Brauchen Sie Hilfe bei der Körperpflege?',
          'Eine Diabetesdiät.',
        ],
        correctIndex: 0,
        feedback: 'Rester immobile fait partie des consignes essentielles.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Et après l examen ?',
        prompt: 'Quelle information est correcte ?',
        options: [
          'Sie müssen 4 bis 6 Stunden strikte Bettruhe einhalten.',
          'Ich werde die Wunde untersuchen.',
          'Hier ist die Klingel.',
        ],
        correctIndex: 0,
        feedback: 'Le repos strict post procédure doit être expliqué.',
      ),
    ],
    completionMessage:
        'Préparation d examen validée. Les consignes de sécurité ont été bien transmises.',
  ),
  ClinicalCase(
    id: 'case_postop',
    title: 'Retour de bloc',
    situation:
        'Un patient revient du bloc opératoire. Vous démarrez la surveillance post-opératoire.',
    accentColor: kGreen,
    accentLight: kGreenLight,
    passingScore: 67,
    turns: [
      ClinicalCaseTurn(
        patientLine: 'Je viens de rentrer du bloc. Je me sens un peu faible.',
        prompt: 'Quelle action annoncer en priorité ?',
        options: [
          'Ich werde Ihre Vitalwerte überprüfen.',
          'Füllen Sie bitte das Anmeldeformular aus.',
          'Der Stauschlauch.',
        ],
        correctIndex: 0,
        feedback:
            'La surveillance des constantes est prioritaire au retour de bloc.',
      ),
      ClinicalCaseTurn(
        patientLine: 'J ai un pansement, est-ce normal ?',
        prompt: 'Quelle phrase est la plus adaptée ?',
        options: [
          'Ich werde Ihren Verband kontrollieren.',
          'Muss ich für Sie einen Krankenwagen rufen?',
          'Ich messe jetzt Ihre Temperatur im couloir.',
        ],
        correctIndex: 0,
        feedback:
            'Le contrôle du pansement est un élément de surveillance normal.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Quand est-ce que je pourrai bouger un peu ?',
        prompt: 'Quelle annonce correspond au bon accompagnement ?',
        options: [
          'Ich werde Ihnen helfen, sich allmählich zu mobilisieren.',
          'Ich werde Ihren Blutzucker messen.',
          'Eine CT Untersuchung.',
        ],
        correctIndex: 0,
        feedback: 'La mobilisation doit être progressive et encadrée.',
      ),
    ],
    completionMessage:
        'Surveillance post-op validée. Vous avez priorisé les bons messages infirmiers.',
  ),
  ClinicalCase(
    id: 'case_urgent',
    title: 'Détresse vitale',
    situation:
        'Vous trouvez un patient en détresse vitale. Vous devez réagir vite et employer les bons termes.',
    accentColor: kCoral,
    accentLight: kCoralLight,
    passingScore: 67,
    turns: [
      ClinicalCaseTurn(
        patientLine: 'Il ne répond plus et respire mal.',
        prompt: 'Quelle expression correspond à l action principale ?',
        options: [
          'Herz-Lungen-Wiederbelebung',
          'Eine salzarme Diät',
          'Hier sind Ihre Entlassungspapiere.',
        ],
        correctIndex: 0,
        feedback: 'En arrêt cardio-respiratoire, la réanimation est centrale.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Que vérifiez-vous en urgence ?',
        prompt: 'Quelle proposition est la plus juste ?',
        options: [
          'Bewusstsein und Atmung',
          'Die Zahnbürste und den Waschlappen',
          'Die Entlassungspapiere',
        ],
        correctIndex: 0,
        feedback: 'Conscience et respiration sont les premières vérifications.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Le patient reste en difficulté respiratoire.',
        prompt: 'Quelle phrase annonce une surveillance adaptée ?',
        options: [
          'Ich werde die Atemfrequenz und die Sauerstoffsättigung messen.',
          'Ich werde Ihnen den Tagesablauf erklären.',
          'Brauchen Sie Hilfe bei der Körperpflege?',
        ],
        correctIndex: 0,
        feedback: 'En urgence, on évalue rapidement la respiration et la SpO2.',
      ),
    ],
    completionMessage:
        'Urgence validée. Vous avez gardé une logique d action prioritaire.',
  ),
  ClinicalCase(
    id: 'case_discharge',
    title: 'Sortie du patient',
    situation:
        'Le patient quitte le service. Vous devez remettre les documents, expliquer la suite et vérifier la compréhension.',
    accentColor: kPeach,
    accentLight: kPeachLight,
    passingScore: 67,
    turns: [
      ClinicalCaseTurn(
        patientLine: 'Je crois que je peux sortir aujourd hui, c est bien ça ?',
        prompt: 'Quelle phrase convient le mieux ?',
        options: [
          'Hier sind Ihre Entlassungspapiere. Haben Sie Fragen?',
          'Ein Antiseptikum.',
          'Atemstillstand.',
        ],
        correctIndex: 0,
        feedback: 'On remet les documents et on ouvre l échange.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Que dois-je faire après la sortie ?',
        prompt: 'Quelle consigne est la plus adaptée ?',
        options: [
          'Sie müssen zu Ihrem Hausarzt gehen.',
          'Ich werde die Infusionsleitung entlüften.',
          'Die Leukozyten.',
        ],
        correctIndex: 0,
        feedback: 'Le relais avec le médecin traitant doit être explicité.',
      ),
      ClinicalCaseTurn(
        patientLine: 'Pouvez-vous noter tout ça dans mon dossier ?',
        prompt: 'Quelle réponse professionnelle donnez-vous ?',
        options: [
          'Ich werde die Informationen in der Patientenakte vermerken.',
          'Ich werde Ihnen Blut abnehmen.',
          'Wo haben Sie Schmerzen?',
        ],
        correctIndex: 0,
        feedback: 'La traçabilité fait partie de la sortie sécurisée.',
      ),
    ],
    completionMessage:
        'Sortie validée. Vous avez couvert documents, consignes et traçabilité.',
  ),
];
