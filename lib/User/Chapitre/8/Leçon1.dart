import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C8Page extends StatelessWidget {
  const Lesson1C8Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "L'anesthésie",
      "content": "\"L'anesthésie\" signifie \"Die Anästhesie\" en allemand.",
      "examples": [
        {"phrase": "Je vous remets le formulaire pour l'anesthésie/ l'opération et il faudra le lire consciencieusement.", "meaning": "Ich gebe Ihnen das Formular für die Anästhesie/ die Operation, und Sie müssen es sorgfältig lesen."},
        {"phrase": "Vous allez avoir :", "meaning": "Sie werden Folgendes haben:"},
        {"phrase": "Une anesthésie locale (AL)", "meaning": "Eine lokale Anästhesie"},
        {"phrase": "Une anesthésie péridurale", "meaning": "Eine Periduralanästhesie"},
        {"phrase": "Une rachi-anesthésie", "meaning": "Eine Spinalanästhesie"},
        {"phrase": "Pour l'anesthésie générale", "meaning": "Für die Allgemeinanästhesie"},
        {"phrase": "Pour l'anesthésie générale on utilise un mélange d'hypnotique, d'antalgique (et de curare).", "meaning": "Für die Allgemeinanästhesie wird eine Mischung aus Hypnotikum, Analgetikum (und Curare) verwendet."},
        {"phrase": "Le médecin va vous poser une sonde d'intubation/ un masque laryngé.", "meaning": "Der Arzt wird Ihnen einen Intubationsschlauch/ eine Larynxmaske legen."}
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
