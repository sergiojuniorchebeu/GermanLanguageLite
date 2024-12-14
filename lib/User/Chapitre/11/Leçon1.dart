import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C11Page extends StatelessWidget {
  const Lesson1C11Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Le transfert et la sortie",
      "content": "\"Le transfert et la sortie\" signifie \"Die Verlegung und die Entlassung\" en allemand. Ce guide explique les étapes pour le transfert des patients et leur sortie.",
      "examples": [
        {"phrase": "Pour le transfert interne, il faut suivre la procédure de l'établissement.", "meaning": "Für die interne Verlegung gelten die internen Pflegestandards."},
        {"phrase": "Pour le transfert externe, il faut compléter une fiche de liaison.", "meaning": "Für die externe Verlegung wird die Pflegeüberleitung ausgefüllt."},
        {"phrase": "Vous pouvez sortir aujourd'hui :", "meaning": "Sie werden heute entlassen:"},
        {"phrase": "à domicile (m.)", "meaning": "nach Hause"},
        {"phrase": "en EHPAD / en maison de retraite (f.)", "meaning": "ins (Alten-)Pflegeheim"},
        {"phrase": "en SSR / en rééducation (f.)", "meaning": "in die Rehabilitation (ugs.: Reha)"},
        {"phrase": "dans un autre hôpital", "meaning": "in ein anderes Krankenhaus"},
        {"phrase": "Voici vos papiers de sortie.", "meaning": "Hier sind Ihre Entlassungspapiere."},
        {"phrase": "Il faudra aller chez votre médecin traitant.", "meaning": "Sie müssen zu Ihrem Hausarzt gehen."},
        {"phrase": "Est-ce que vous avez tout emporté / tout mis dans votre sac ?", "meaning": "Haben Sie alles eingepackt?"},
        {"phrase": "L'entretien infirmier de sortir sans / avec la famille", "meaning": "Das Krankenpflegegespräch für den Austritt ohne / mit der Familie"},
        {"phrase": "Je vais vous donner des informations spécifiques (f.)", "meaning": "Ich werde Ihnen spezifische Informationen geben"},
        {"phrase": "Je vais vous informer sur la conduite à tenir.", "meaning": "Ich werde Sie über das Verhalten informieren."},
        {"phrase": "Je vais vous informer sur les mesures à suivre (f.)", "meaning": "Ich werde Sie über die Maßnahmen informieren."},
        {"phrase": "Voici vos papiers de sortie. Est-ce que vous avez des questions ?", "meaning": "Hier sind Ihre Entlassungspapiere. Haben Sie Fragen?"},
        {"phrase": "Je vais vous remettre vos objets de valeurs.", "meaning": "Ich werde Ihnen Ihre Wertsachen übergeben."},
        {"phrase": "Voici le questionnaire de satisfaction. Est-ce que vous pouvez le remplir ?", "meaning": "Hier ist der Zufriedenheitsfragebogen. Können Sie ihn ausfüllen?"},
        {"phrase": "Je vais tracer les informations dans le dossier du patient.", "meaning": "Ich werde die Informationen in der Patientenakte vermerken."},
        {"phrase": "Est-ce que je dois vous commander une ambulance ?", "meaning": "Muss ich für Sie einen Krankenwagen rufen?"}
      ],
    };

    return Scaffold(
      backgroundColor: const Color(0xFF01799B),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text(
          lessonData["title"],
          style: GoogleFonts.poppins(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF005D80),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF005D80), Color(0xFF01799B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Titre de la leçon
              Text(
                lessonData["title"],
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Contenu principal
              Text(
                lessonData["content"],
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              // Liste des exemples
              ...lessonData["examples"].map<Widget>((example) {
                return SizedBox(
                  width: double.infinity, // Cette ligne garantit que la Card occupe toute la largeur disponible
                  child: Card(
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[850] // Mode sombre
                        : Colors.white, // Mode clair
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Affichage du texte en allemand (en haut)
                          Text(
                            example["meaning"],
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color(0xFF005D80),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Affichage du texte en français (en bas)
                          Text(
                            example["phrase"],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
