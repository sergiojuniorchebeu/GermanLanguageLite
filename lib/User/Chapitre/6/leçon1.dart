import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C6Page extends StatelessWidget {
  const Lesson1C6Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les examens généraux",
      "content": "\"Les examens généraux\" signifie \"Die allgemeinen Untersuchungen\" en allemand.",
      "examples": [
        {"phrase": "Je vais vous préparer pour cet examen", "meaning": "Ich werde Sie für diese Untersuchung vorbereiten"},
        {"phrase": "Avant l'examen vous devez signer la feuille de consentement", "meaning": "Vor der Untersuchung müssen Sie das Einwilligungsformular unterschreiben"},
        {"phrase": "Vous allez avoir...", "meaning": "Sie werden ... haben"},
        {"phrase": "Un scanner (TDM) avec/sans injection de produit de contraste iodé", "meaning": "Eine CT-Untersuchung mit/ohne Kontrastmittelinjektion"},
        {"phrase": "Un scanner cardiaque", "meaning": "Eine Herz-CT"},
        {"phrase": "Une IRM (imagerie par résonance magnétique)", "meaning": "Ein MRT (Magnetresonanztomographie)"},
        {"phrase": "Une radiographie/ une radio-thoracique", "meaning": "Eine Röntgenaufnahme / eine Thoraxaufnahme"},
        {"phrase": "Une scintigraphie", "meaning": "Eine Szintigraphie"},
        {"phrase": "Une endoscopie / une gastroscopie / une coloscopie / une fibroscopie bronchique", "meaning": "Eine Endoskopie / eine Gastroskopie / eine Koloskopie / eine bronchoskopische Fibroskopie"},
        {"phrase": "Un ECG au repos / un ECG d'effort / un Holter ECG", "meaning": "Ein Ruhe-EKG / ein Belastungs-EKG / ein Holter-EKG"},
        {"phrase": "Une échographie transœsophagienne", "meaning": "Eine transösophageale Echokardiographie"}
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
