import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C2Page extends StatelessWidget {
  const Lesson1C2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les constantes",
      "content": "\"Les constantes\" signifie \"Die Basiswerte\" en allemand.",
      "examples": [
        {"phrase": "Wie groß sind Sie? Wieviel wiegen Sie?", "meaning": "Quelle est votre taille ? Quel est votre poids ?"},
        {"phrase": "Sie sind ... groß.", "meaning": "Vous mesurez..."},
        {"phrase": "Sie wiegen ... kg.", "meaning": "Vous pesez..."},
        {"phrase": "Ich messe jetzt Ihre Temperatur.", "meaning": "Je vais prendre votre température."},
        {"phrase": "Sie haben Fieber.", "meaning": "Vous avez de la fièvre."},
        {"phrase": "Sie haben kein Fieber.", "meaning": "Vous n'avez pas de fièvre."},
        {"phrase": "Ich messe jetzt Ihren Puls.", "meaning": "Je vais prendre votre pouls."},
        {"phrase": "Ihr Puls ist zu langsam / normal / zu hoch.", "meaning": "Votre pouls est trop lent / normal / trop rapide."},
        {"phrase": "Ich messe jetzt Ihren Blutdruck.", "meaning": "Je vais mesurer votre tension artérielle."},
        {"phrase": "Ihr Blutdruck ist zu niedrig / normal / zu hoch.", "meaning": "Votre tension est trop basse / normale / trop haute."},
        {"phrase": "Ihr Blutdruck liegt bei 130/80 (130 zu 80).", "meaning": "Votre tension est de 13/8 cm Hg (13 sur 8)."},
        {"phrase": "Ich messe jetzt Ihre Sauerstoffsättigung.", "meaning": "Je vais mesurer votre saturation en oxygène."},
        {"phrase": "Der Wert beträgt ... % (Prozent).", "meaning": "Les valeurs sont de ... % (pour cent)."},
        {"phrase": "Ich kontrolliere die Urinausscheidung: Menge / Farbe.", "meaning": "Je contrôle la durée / quantité / coloration."}
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
                          // Affichage de la phrase en allemand en haut
                          Text(
                            example["phrase"], // La phrase en allemand est en haut
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color(0xFF005D80),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Affichage de la traduction en français en dessous
                          Text(
                            example["meaning"], // La traduction en français est en dessous
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
