import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson3C4Page extends StatelessWidget {
  const Lesson3C4Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Solliciter le patient",
      "content": "\"Solliciter le patient\" signifie \"Den Patienten fördern\" en allemand.",
      "examples": [
        {"phrase": "De quelle aide avez-vous besoin ?", "meaning": "Welche Hilfe brauchen Sie?"},
        {"phrase": "Avez-vous besoin d'aide pour vous habiller ?", "meaning": "Brauchen Sie Hilfe beim Anziehen?"},
        {"phrase": "Avez-vous besoin d'aide pour vous allonger ?", "meaning": "Brauchen Sie Hilfe beim Hinlegen?"},
        {"phrase": "Avez-vous besoin d'aide pour vous lever ?", "meaning": "Brauchen Sie Hilfe beim Aufstehen?"},
        {"phrase": "Avez-vous besoin d'aide pour vous asseoir ?", "meaning": "Brauchen Sie Hilfe beim Hinsetzen?"},
        {"phrase": "Pouvez-vous lever le bras ?", "meaning": "Können Sie den Arm hochheben?"},
        {"phrase": "Avez-vous besoin de la poignée de traction (le perroquet) pour vous aider ?", "meaning": "Brauchen Sie den Patientenhalter (den Galgen), um sich zu helfen?"},
        {"phrase": "Pouvez-vous vous retourner ?", "meaning": "Können Sie sich auf die Seite drehen?"},
        {"phrase": "Nous allons régulièrement vous retourner sur le côté droit / sur le côté gauche / sur le dos.", "meaning": "Wir werden Sie regelmäßig um lagern / nach rechts / auf den Rücken / nach links."},
        {"phrase": "Je vais vous remonter la tête du lit.", "meaning": "Ich werde das Kopfteil hochstellen."},
        {"phrase": "Je vais remonter les barrières du lit.", "meaning": "Ich werde die Seitenteile / das Bettgitter hoch machen."}
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
