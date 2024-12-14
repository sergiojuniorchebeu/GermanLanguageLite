import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson2C8Page extends StatelessWidget {
  const Lesson2C8Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "La préparation pré opératoire",
      "content": "\"La préparation pré opératoire\" signifie \"Die präoperative Vorbereitung\" en allemand.",
      "examples": [
        {"phrase": "Je vais vous préparer pour l'opération.", "meaning": "Ich werde Sie für die Operation vorbereiten."},
        {"phrase": "Il faudra être à jeun.", "meaning": "Sie müssen nüchtern bleiben."},
        {"phrase": "Il faudra vous doucher avec un savon antiseptique.", "meaning": "Sie müssen sich mit einer antiseptischen Seife duschen."},
        {"phrase": "Il faudra mettre une blouse d'opération, un calot, des bas anti-thrombose.", "meaning": "Sie müssen ein OP-Hemd, eine Haube und Thrombosestrümpfe tragen."},
        {"phrase": "Il faudra prendre une prémédication en fonction de la prescription médicale.", "meaning": "Sie müssen eine Prämedikation gemäß der ärztlichen Verschreibung einnehmen."},
        {"phrase": "Il faudra laisser vos prothèses dentaires, bijoux, piercing en chambre.", "meaning": "Sie müssen Ihre Zahnprothesen, Schmuck und Piercings im Zimmer lassen."},
        {"phrase": "Le rasage sera fait à l'aide d'une tondeuse électrique.", "meaning": "Die Rasur wird mit einem elektrischen Rasierer durchgeführt."}
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
