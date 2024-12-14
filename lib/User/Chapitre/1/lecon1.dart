import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C1Page extends StatelessWidget {
  const Lesson1C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Se présenter",
      "content": "\"Se présenter\" signifie \"sich vorstellen\" en allemand.",
      "examples": [
        {"phrase": "Guten Tag, Frau", "meaning": "Bonjour Madame"},
        {"phrase": "Guten Tag, Herr", "meaning": "Bonjour Monsieur"},
        {"phrase": "Ich bin Krankenschwester", "meaning": "Je suis infirmière"},
        {"phrase": "Ich bin Krankenpfleger", "meaning": "Je suis infirmier"},
        {"phrase": "Ich bin Studentin", "meaning": "Je suis étudiante"},
        {"phrase": "Ich bin Student", "meaning": "Je suis étudiant"},
        {"phrase": "Ich heiße", "meaning": "Je m'appelle"},
        {
          "phrase":
          "Ich werde Ihnen ein paar Fragen stellen, um Ihre Bewerbungsunterlagen zu vervollständigen.",
          "meaning":
          "Je vais vous poser quelques questions pour compléter votre dossier d'admission."
        },
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
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF005D80),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF005D80)
                  : Color(0xFF01799B),
              Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF01799B)
                  : Color(0xFF005D80), // Gradient modifié pour le mode sombre
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Texte en blanc pour le mode sombre
                      : Colors.white, // Texte en noir pour le mode clair
                ),
              ),
              const SizedBox(height: 16),
              Text(
                lessonData["content"],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ...lessonData["examples"].map<Widget>((example) {
                return SizedBox(
                  width: double.infinity,
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
                          Text(
                            example["phrase"],
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white // Phrase en blanc pour le mode sombre
                                  : const Color(0xFF005D80), // Phrase en bleu pour le mode clair
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            example["meaning"],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white70 // Explication en gris clair pour le mode sombre
                                  : Colors.black54, // Explication en gris foncé pour le mode clair
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
