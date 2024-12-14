import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson2C1Page extends StatelessWidget {
  const Lesson2C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> lessonData = {
      "title": "Les papiers d'admission / le formulaire d'admission",
      "content": "\"Les papiers d'admission / le formulaire d'admission fait référence aux documents nécessaires ou au processus d'inscription, traduits en allemand.\" signifie \"Die Bewerbungsunterlagen / das Anmeldeformular bezieht sich auf die erforderlichen Dokumente oder den Anmeldeprozess, der ins Deutsche übersetzt wurde.\"",
      "examples": [
        {"phrase": "Haben Sie Ihre Bewerbungsunterlagen?", "meaning": "Avez-vous vos papiers d'admission ?"},
        {"phrase": "Füllen Sie bitte das Anmeldeformular aus.", "meaning": "Veuillez remplir le formulaire d'admission."},
        {"phrase": "Brauchen Sie Unterstützung bei der Anmeldung?", "meaning": "Avez-vous besoin d'aide pour l'inscription ?"},
        {"phrase": "Haben Sie die folgenden Unterlagen mitgebracht?", "meaning": "Avez-vous rapporté les papiers suivants ?"},
        {"phrase": "Haben Sie das Verbindungsformular?", "meaning": "Avez-vous la fiche de liaison ?"},
        {"phrase": "Haben Sie das Wunddokumentationsformular?", "meaning": "Avez-vous la fiche de suivi des plaies ?"},
        {"phrase": "Haben Sie das Arztbrief?", "meaning": "Avez-vous la lettre du médecin ?"},
        {"phrase": "Haben Sie die medizinische Zusammenfassung?", "meaning": "Avez-vous le résumé médical ?"},
        {"phrase": "Haben Sie die Vorausverfügungen?", "meaning": "Avez-vous les directives anticipées ?"},
        {"phrase": "Haben Sie die Krankenversicherungskarte?", "meaning": "Avez-vous la carte vitale ?"},
        {"phrase": "Haben Sie das Pacemaker-Dokumentationsheft?", "meaning": "Avez-vous le carnet de suivi du pacemaker ?"},
        {"phrase": "Haben Sie das AVK-Dokumentationsheft?", "meaning": "Avez-vous le carnet de suivi des AVK ?"}
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF005D80)
                  : const Color(0xFF01799B),
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF01799B)
                  : const Color(0xFF005D80),
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
                          // Explication en français
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
