import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson4C1Page extends StatelessWidget {
  const Lesson4C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "L'entretien d'accueil",
      "content": "\"L'entretien d'accueil\" signifie \"das Aufnahmegespräch\" en allemand.",
      "examples": [
        {
          "phrase": "Wie ist Ihre Situation?",
          "meaning": "Quelle est votre situation ?"
        },
        {
          "phrase": "Sind Sie ...?",
          "meaning": "Êtes-vous ... ?"
        },
        {
          "phrase": "Verheiratet",
          "meaning": "Marié(e)"
        },
        {
          "phrase": "Ledig",
          "meaning": "Célibataire"
        },
        {
          "phrase": "In einer Lebensgemeinschaft?",
          "meaning": "En concubinage ?"
        },
        {
          "phrase": "In einer Einrichtung?",
          "meaning": "En institution ?"
        },
        {
          "phrase": "Haben Sie häusliche Pflege?",
          "meaning": "Avez-vous des soins à domicile ?"
        },
        {
          "phrase": "Kann ich jemanden benachrichtigen?",
          "meaning": "Est-ce que je peux prévenir quelqu'un ?"
        },
        {
          "phrase": "Wer sind die Personen, die benachrichtigt werden sollen?",
          "meaning": "Qui sont les personnes à prévenir ?"
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
                          // Explication en français en dessous
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
