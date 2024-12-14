import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C10Page extends StatelessWidget {
  const Lesson1C10Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les différents étiologies de situations d'urgence",
      "content": "\"Les différents étiologies de situations d'urgence\" signifie \"Die verschiedenen Ätiologien von Notfallsituationen\" en allemand. Ce guide décrit les causes des urgences médicales et leur classification.",
      "examples": [
        {"phrase": "Le respiratoire", "meaning": "Die Atmung"},
        {"phrase": "La dyspnée", "meaning": "Atemnot"},
        {"phrase": "Le bronchospasme", "meaning": "Bronchospasmus"},
        {"phrase": "L'asthme", "meaning": "Asthma"},
        {"phrase": "Le pneumo-hémo-chylo-thorax", "meaning": "Pneumo-Hämo-Chylo-Thorax"},
        {"phrase": "L'œdème aigu du poumon (OAP)", "meaning": "Akutes Lungenödem (OAP)"},
        {"phrase": "L'intoxication", "meaning": "Vergiftung"},
        {"phrase": "BPCO", "meaning": "Chronisch obstruktive Lungenerkrankung (COPD)"},
        {"phrase": "L'inhalation", "meaning": "Inhalation"},
        {"phrase": "Le surdosage médicamenteux", "meaning": "Überdosierung von Medikamenten"},
        {"phrase": "L'arrêt respiratoire", "meaning": "Atemstillstand"},
        {"phrase": "Le cardio-vasculaire", "meaning": "Das Herz-Kreislauf-System"},
        {"phrase": "Les troubles du rythme", "meaning": "Rhythmusstörungen"},
        {"phrase": "L'arythmie auriculaire", "meaning": "Vorhofarrhythmie"},
        {"phrase": "L'extra-systole supra-ventriculaire", "meaning": "Supraventrikuläre Extrasystole"},
        {"phrase": "La tachycardie atriale", "meaning": "Vorhoftachykardie"},
        {"phrase": "La flutter auriculaire", "meaning": "Vorhofflattern"},
        {"phrase": "La fibrillation auriculaire", "meaning": "Vorhofflimmern"},
        {"phrase": "La bradycardie", "meaning": "Bradykardie"},
        {"phrase": "Le bloc sino-auriculaire (BSA)", "meaning": "Sinoatrialer Block (BSA)"},
        {"phrase": "Le bloc auriculo-ventriculaire (BAV)", "meaning": "Atrioventrikulärer Block (AVB)"},
        {"phrase": "L'extra-systole ventriculaire (ESV)", "meaning": "Ventrikuläre Extrasystole (VES)"},
        {"phrase": "La tachycardie ventriculaire (TV)", "meaning": "Ventrikuläre Tachykardie (VT)"},
        {"phrase": "La flutter ventriculaire", "meaning": "Kammerflattern"},
        {"phrase": "La fibrillation ventriculaire", "meaning": "Kammerflimmern"},
        {"phrase": "La défaillance de la pompe cardiaque", "meaning": "Herzpumpversagen"},
        {"phrase": "L'insuffisance cardiaque", "meaning": "Herzinsuffizienz"},
        {"phrase": "La défaillance valvulaire", "meaning": "Klappenversagen"},
        {"phrase": "L'endocardite", "meaning": "Endokarditis"},
        {"phrase": "L'infarctus du myocarde", "meaning": "Myokardinfarkt"},
        {"phrase": "La sténose coronarienne", "meaning": "Koronarstenose"},
        {"phrase": "L'ischémie", "meaning": "Ischämie"},
        {"phrase": "Le traumatisme", "meaning": "Trauma"},
        {"phrase": "L'hémorragie", "meaning": "Blutung"},
        {"phrase": "Les états de choc", "meaning": "Schockzustände"},
        {"phrase": "Le choc anaphylactique", "meaning": "Anaphylaktischer Schock"},
        {"phrase": "Le choc septique", "meaning": "Septischer Schock"},
        {"phrase": "Le choc cardiogénique", "meaning": "Kardiogener Schock"},
        {"phrase": "Le choc hémorragique", "meaning": "Hämorrhagischer Schock"},
        {"phrase": "Le choc neurogénique", "meaning": "Neurogener Schock"}
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
