import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson4C8Page extends StatelessWidget {
  const Lesson4C8Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "La plaie",
      "content": "\"La plaie\" signifie \"Die Wunde\" en allemand.",
      "examples": [
        {"phrase": "Je vais vous refaire le pansement.", "meaning": "Ich werde Ihren Verband erneuern."},
        {"phrase": "Je vais maintenant retirer les points de suture / les agrafes.", "meaning": "Ich werde jetzt die Nähte / Klammern entfernen."},
        {"phrase": "Je vais observer la plaie.", "meaning": "Ich werde die Wunde untersuchen."},
        {"phrase": "Elle est :", "meaning": "Sie ist:"},
        {"phrase": "sèche", "meaning": "trocken"},
        {"phrase": "rouge", "meaning": "rot"},
        {"phrase": "inflammatoire", "meaning": "entzündlich"},
        {"phrase": "infectée", "meaning": "infiziert"},
        {"phrase": "nécrosée", "meaning": "nekrotisch"},
        {"phrase": "fibrineuse", "meaning": "fibrinös"},
        {"phrase": "bourgeonnantes", "meaning": "granulierend"},
        {"phrase": "Les sécrétions (f.) de la plaie sont :", "meaning": "Der Wundabfluss ist:"},
        {"phrase": "sanglantes", "meaning": "blutig"},
        {"phrase": "séreuses", "meaning": "serös"},
        {"phrase": "purulentes", "meaning": "eitrig"},
        {"phrase": "Les berges (f.) de la plaie sont :", "meaning": "Die Wundränder sind:"},
        {"phrase": "sans particularité / R.A.S. (rien à signaler)", "meaning": "unauffällig / nichts zu berichten"},
        {"phrase": "macérées", "meaning": "mazeriert"}
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
