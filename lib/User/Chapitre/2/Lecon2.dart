import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson2C2Page extends StatelessWidget {
  const Lesson2C2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "L'évaluation de la douleur",
      "content": "\"L'évaluation de la douleur\" signifie \"Die Schmerzeinschätzung\" en allemand.",
      "examples": [
        {"phrase": "Haben Sie Schmerzen?", "meaning": "Avez-vous mal ?"},
        {"phrase": "Wo haben Sie Schmerzen?", "meaning": "Où avez-vous des douleurs ?"},
        {"phrase": "Seit wann haben Sie Schmerzen?", "meaning": "Depuis quand avez-vous mal ?"},
        {"phrase": "Können Sie mir die Schmerzen beschreiben?", "meaning": "Pouvez-vous me décrire la douleur ?"},
        {"phrase": "Es brennt.", "meaning": "Ça me brûle."},
        {"phrase": "Ich spüre einen Druck in der Brust.", "meaning": "Ça me serre dans la poitrine."},
        {"phrase": "Es ist ein stechender Schmerz.", "meaning": "C'est une douleur piquante."},
        {"phrase": "Es ist ein pulsierender Schmerz.", "meaning": "C'est une douleur pulsative."},
        {"phrase": "Es ist ein unerträglicher Schmerz.", "meaning": "C'est une douleur insupportable."},
        {"phrase": "Es ist ein akuter Schmerz.", "meaning": "C'est une douleur aiguë."},
        {"phrase": "Es ist ein chronischer Schmerz.", "meaning": "C'est une douleur permanente/chronique."},
        {"phrase": "Ich gebe Ihnen ein Schmerzmittel.", "meaning": "Je vais vous donner un antalgique."},
        {"phrase": "Sie werden bald Erleichterung verspüren.", "meaning": "Vous allez rapidement vous sentir mieux."},
        {"phrase": "Ich rufe den Arzt.", "meaning": "Je vais prévenir le médecin."},
        {"phrase": "Auf einer Skala von 0 bis 10: Wie stark sind Ihre Schmerzen?", "meaning": "Sur une échelle de 0 à 10, combien avez-vous mal ?"},
        {"phrase": "0 bedeutet keine Schmerzen und 10 bedeutet maximale Schmerzen.", "meaning": "Sachant que 0 correspond à l'absence de douleur et 10 à la douleur maximale imaginable."}
      ],
    };

    // Détection du thème actuel
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color(0xFF01799B), // Fond inchangé
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
        backgroundColor: const Color(0xFF005D80), // AppBar inchangé
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF005D80), Color(0xFF01799B)], // Fond inchangé
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
                    color: isDarkMode ? const Color(0xFF2C2C2C) : Colors.white, // Cartes ajustées selon le thème
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Phrase en allemand en haut
                          Text(
                            example["phrase"], // Phrase en allemand
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : const Color(0xFF005D80),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Traduction en français en dessous
                          Text(
                            example["meaning"], // Traduction en français
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: isDarkMode ? Colors.white70 : Colors.black54,
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
