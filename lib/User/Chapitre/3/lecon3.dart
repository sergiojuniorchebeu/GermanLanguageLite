import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson3C3Page extends StatelessWidget {
  const Lesson3C3Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "La nutrition artificielle",
      "content": "\"La nutrition artificielle\" signifie \"Die künstliche Ernährung\" en allemand.",
      "examples": [
        {"phrase": "Poser une sonde naso-gastrique", "meaning": "Ein nasogastrische Sonde legen"},
        {"phrase": "S'occuper d'une gastronomie (GEP)", "meaning": "Sich um eine Gastrostomie (PEG) kümmern"},
        {"phrase": "Utiliser la pompe de nutrition", "meaning": "Die Ernährungspumpe benutzen"},
        {"phrase": "Brancher la poche de nutrition entérale", "meaning": "Den Beutel für enterale Ernährung anschließen"},
        {"phrase": "Nutrition parentérale", "meaning": "Parenterale Ernährung"},
        {"phrase": "Nutrition entérale", "meaning": "Enterale Ernährung"},
        {"phrase": "Sonde naso-gastrique", "meaning": "Nasogastrische Sonde"},
        {"phrase": "Alimentation par sonde", "meaning": "Ernährung durch Sonde"},
        {"phrase": "Perfusion intraveineuse", "meaning": "Intravenöse Infusion"},
        {"phrase": "Alimentation par voie intraveineuse", "meaning": "Ernährung über intravenöse Zuführung"}
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
