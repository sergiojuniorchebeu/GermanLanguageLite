import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson2C3Page extends StatelessWidget {
  const Lesson2C3Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les troubles digestifs",
      "content": "\"Les troubles digestifs\" signifie \"Die Verdauungsprobleme\" en allemand.",
      "examples": [
        {"phrase": "La dénutrition", "meaning": "Die Mangelernährung"},
        {"phrase": "La perte d'appétit", "meaning": "Der Appetitverlust"},
        {"phrase": "Le trouble de la déglutition", "meaning": "Die Schluckstörung"},
        {"phrase": "Le trouble du transit", "meaning": "Die Stuhlgangstörung"},
        {"phrase": "L'intolérance alimentaire", "meaning": "Die Nahrungsmittelunverträglichkeit"},
        {"phrase": "Le trouble métabolique", "meaning": "Die Stoffwechselstörung"},
        {"phrase": "Est-ce que vous avez des douleurs ?", "meaning": "Haben Sie Schmerzen?"},
        {"phrase": "Avez-vous des nausées ?", "meaning": "Haben Sie Übelkeit?"},
        {"phrase": "Avez-vous des vomissements ?", "meaning": "Haben Sie Erbrechen?"},
        {"phrase": "Est-ce que vous avez des brûlures d'estomac ?", "meaning": "Haben Sie Sodbrennen?"},
        {"phrase": "Est-ce que vous avez une perte d'appétit ?", "meaning": "Haben Sie Appetitlosigkeit?"},
        {"phrase": "Avez-vous des ballonnements ?", "meaning": "Haben Sie Blähungen?"},
        {"phrase": "Avez-vous de la diarrhée ?", "meaning": "Haben Sie Durchfall?"},
        {"phrase": "Avez-vous de la constipation ?", "meaning": "Haben Sie Verstopfung?"},
        {"phrase": "Avez-vous des douleurs abdominales ?", "meaning": "Haben Sie Bauchschmerzen?"},
        {"phrase": "Est-ce que vous avez des gaz ?", "meaning": "Haben Sie Blähungen?"},
        {"phrase": "Avez-vous des crampes intestinales ?", "meaning": "Haben Sie Darmkrämpfe?"},
        {"phrase": "Est-ce que vous avez des reflux gastriques ?", "meaning": "Haben Sie Magen-Reflux?"},
        {"phrase": "Avez-vous des problèmes de digestion ?", "meaning": "Haben Sie Verdauungsprobleme?"}
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
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.white,
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
