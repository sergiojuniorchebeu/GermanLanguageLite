import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson3C1Page extends StatelessWidget {
  const Lesson3C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Lesson data (title, content, examples)
    final Map<String, dynamic> lessonData = {
      "title": "L'entretien d'orientation",
      "content": "\"L'entretien d'orientation\" signifie \"das Orientierungsgespräch\" en allemand.",
      "examples": [
        {
          "phrase": "Ich werde Ihnen erklären, wie Sie sich in der Abteilung und im Krankenhaus orientieren können.",
          "meaning": "Je vais vous expliquer comment vous orienter dans le service et dans l'hôpital."
        },
        {
          "phrase": "Ich werde Ihnen erklären, wo Sie Ihre persönlichen Sachen aufbewahren können.",
          "meaning": "Je vais vous expliquer où mettre vos affaires personnelles."
        },
        {
          "phrase": "Ich werde Ihnen erklären, was Sie mit Ihren Wertsachen machen sollen.",
          "meaning": "Je vais vous expliquer que faire de vos objets de valeur."
        },
        {
          "phrase": "Ich werde Ihnen den Tagesablauf erklären.",
          "meaning": "Je vais vous expliquer le déroulement de la journée."
        },
        {
          "phrase": "Ich werde Ihnen die Besuchszeiten erklären.",
          "meaning": "Je vais vous expliquer les heures de visite."
        },
        {
          "phrase": "Ich werde Ihnen die Zeiten der ärztlichen Visiten erklären.",
          "meaning": "Je vais vous expliquer les heures de visites médicales."
        },
        {
          "phrase": "Ich werde Ihnen die Übergabezeiten erklären.",
          "meaning": "Je vais vous expliquer les heures de transmissions."
        },
        {
          "phrase": "Ich werde Ihnen die Essenszeiten erklären.",
          "meaning": "Je vais vous expliquer les heures de repas."
        },
        {
          "phrase": "Ich werde Ihnen die Ruhezeiten erklären.",
          "meaning": "Je vais vous expliquer les heures de repos."
        },
        {
          "phrase": "Falls Sie etwas brauchen, hier ist die Klingel.",
          "meaning": "Si vous avez besoin de quelque chose, voici la sonnerie."
        },
        {
          "phrase": "Ich werde Ihnen ein paar Fragen stellen, um Sie besser kennenzulernen.",
          "meaning": "Je vais vous poser quelques questions pour mieux vous connaître."
        },
        {
          "phrase": "Was ist Ihr Hauptinteressensgebiet?",
          "meaning": "Quel est votre domaine d'intérêt principal ?"
        },
        {
          "phrase": "Was sind Ihre beruflichen Ziele?",
          "meaning": "Quels sont vos objectifs professionnels ?"
        },
        {
          "phrase": "Haben Sie schon eine genaue Vorstellung von Ihrem Werdegang?",
          "meaning": "Avez-vous déjà une idée précise de votre parcours ?"
        },
        {
          "phrase": "Möchten Sie mehrere Optionen erkunden, bevor Sie sich entscheiden?",
          "meaning": "Souhaitez-vous explorer plusieurs options avant de choisir ?"
        },
        {
          "phrase": "Dieses Gespräch soll Ihnen helfen, Ihren Weg zu finden.",
          "meaning": "Cet entretien vise à vous aider à trouver votre voie."
        }
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF005D80)
                  : const Color(0xFF01799B),
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF01799B)
                  : const Color(0xFF005D80),
            ],
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
                        ? Colors.grey[850] // Fond sombre pour le mode sombre
                        : Colors.white, // Fond clair pour le mode clair
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Affichage de la phrase en allemand en premier
                          Text(
                            example["phrase"],
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color(0xFF005D80),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Explication en français en bas
                          Text(
                            example["meaning"],
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
