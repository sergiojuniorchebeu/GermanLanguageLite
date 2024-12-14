import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "À propos de Mercy for Cameroon",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF005D80),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Mercy for Cameroon
            Center(
              child: Image.asset(
                'assets/img/téléchargement (1).jpg', // Remplacez par le chemin de votre logo
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(height: 16),
            // Texte - Introduction
            Text(
              "Mercy for Cameroon est une organisation caritative à but non lucratif dédiée à l'amélioration des conditions de vie des populations les plus vulnérables au Cameroun. Depuis sa création, l'association a œuvré dans divers domaines tels que l'éducation, la santé, l'accès à l'eau potable, et le soutien aux personnes déplacées. Notre mission est de répondre aux besoins immédiats des communautés tout en contribuant à un développement durable à long terme.",
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            // Texte - Mercy Innovation Lab
            Text(
              "Dans le cadre de notre engagement à promouvoir l'innovation et l'entrepreneuriat au Cameroun, Mercy for Cameroon a lancé la branche Mercy Innovation Lab. Ce programme se concentre sur le développement des compétences numériques des jeunes Camerounais. Mercy Innovation Lab propose des formations professionnelles en développement Web et Mobile, permettant aux participants d'acquérir des compétences pratiques et de participer activement à l'essor du secteur technologique en Afrique.",
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            // Image - Mercy Innovation Lab logo
            Center(
              child: Image.asset(
                'assets/img/téléchargement.jpg', // Remplacez par le chemin de votre logo
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(height: 16),
            // Texte - Vision et Impact
            Text(
              "Nous croyons fermement que l'accès à la technologie et à l'éducation est un levier puissant pour le changement social et économique. Mercy Innovation Lab développe des applications pratiques qui répondent aux besoins spécifiques des populations camerounaises, qu'il s'agisse d'améliorer l'accès aux soins de santé, de faciliter l'éducation à distance, ou encore de soutenir l'agriculture locale.",
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            // Texte - Conclusion
            Text(
              "En travaillant main dans la main avec les communautés locales et les institutions partenaires, Mercy for Cameroon et Mercy Innovation Lab s'engagent à apporter un changement réel et mesurable. Nous sommes convaincus qu'ensemble, nous pouvons créer un avenir meilleur pour les générations futures du Cameroun.",
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
