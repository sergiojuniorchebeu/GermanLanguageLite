import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C7Page extends StatelessWidget {
  const Lesson1C7Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "La prise de sang",
      "content": "\"La prise de sang\" signifie \"Die Blutabnahme\" en allemand.",
      "examples": [
        {"phrase": "Je vais vous faire une prise de sang.", "meaning": "Ich werde Ihnen Blut abnehmen."},
        {"phrase": "Le matériel nécessaire pour prise de sang", "meaning": "Das für die Blutabnahme benötigte Material"},
        {"phrase": "Le garrot", "meaning": "Der Stauschlauch"},
        {"phrase": "Les gants", "meaning": "Die Handschuhe"},
        {"phrase": "Un antiseptique", "meaning": "Ein Antiseptikum"},
        {"phrase": "Les tubes", "meaning": "Die Röhrchen"},
        {"phrase": "Une aiguille", "meaning": "Eine Nadel"},
        {"phrase": "Un collecteur à aiguilles (le septobox)", "meaning": "Ein Nadelbehälter (der Septobox)"},
        {"phrase": "Un pansement", "meaning": "Ein Pflaster"},
        {"phrase": "Le haricot", "meaning": "Die Nierenschale"},
        {"phrase": "Je vais vous poser un garrot.", "meaning": "Ich werde Ihnen einen Stauschlauch anlegen."},
        {"phrase": "Pouvez-vous fermer le poing?", "meaning": "Können Sie die Faust schließen?"},
        {"phrase": "Ça va piquer un peu.", "meaning": "Es wird ein wenig stechen."}
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
