import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widget/Drawer.dart';


class AdmissionPapersPage extends StatelessWidget {
  const AdmissionPapersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF005D80),
      appBar: AppBar(
        backgroundColor: const Color(0xFF005D80),
        elevation: 0,
        leading:Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                CupertinoIcons.bars,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Papiers d’admission',
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Die Aufnahmepapiere',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
        body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
        child: Column(
          children: [
            // Champ de recherche
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: 'Recherche',
                hintStyle: const TextStyle(color: Colors.white),
                suffixIcon: const Icon(Icons.search, color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                  const BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                  const BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            // Liste des papiers
            Expanded(
              child: ListView(
                children: [
                  _buildPaperCard(
                    frenchText: 'Avez-vous rapporté les papiers suivants ?',
                    germanText: 'Haben sie folgende papiere mitgebracht ?',
                  ),
                  _buildPaperCard(
                    frenchText: 'la fiche de liaison',
                    germanText: 'Die pflegeüberleitung',
                  ),
                  _buildPaperCard(
                    frenchText: 'la fiche de suivi des plaies',
                    germanText: 'Die wunddokumentation',
                  ),
                  _buildPaperCard(
                    frenchText: 'la lettre du médecin',
                    germanText: 'Die Einweisung',
                  ),
                  _buildPaperCard(
                    frenchText: 'la carte vitale',
                    germanText: 'Die krankenkassenkarte',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaperCard({
    required String frenchText,
    required String germanText,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texte en français et allemand
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    frenchText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    germanText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Bouton de son
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFF00B46F),
                child: Icon(Icons.volume_up, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
