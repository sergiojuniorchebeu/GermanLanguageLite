import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/Landing Page.dart';
import 'Widget/Navigation.dart';

class FirstLaunchHandler extends StatefulWidget {
  const FirstLaunchHandler({super.key});

  @override
  _FirstLaunchHandlerState createState() => _FirstLaunchHandlerState();
}

class _FirstLaunchHandlerState extends State<FirstLaunchHandler> with SingleTickerProviderStateMixin {
  bool? isFirstLaunch;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // Contrôleur pour le champ de saisie du nom
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();

    // Créer l'animation avec un TickerProvider
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this, // Fournir le TickerProvider avec 'this' (qui est un TickerProvider)
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  // Vérifier si c'est le premier lancement et afficher le dialogue si nécessaire
  Future<void> _checkFirstLaunch() async {
    try {
      await Future.delayed(const Duration(seconds: 8));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool firstLaunch = prefs.getBool('isFirstLaunch') ?? true;

      if (firstLaunch) {
        // Sauvegarder que ce n'est plus le premier lancement
        await prefs.setBool('isFirstLaunch', false);

        // Afficher le Dialog Box pour demander le nom
        _showNameDialog();

        setState(() {
          isFirstLaunch = true;
        });
      } else {
        setState(() {
          isFirstLaunch = false;
        });
      }
    } catch (e) {
      print('Error checking first launch: $e');
      setState(() {
        isFirstLaunch = false;
      });
    }
  }

  // Afficher le Dialog Box pour saisir le nom
  void _showNameDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Coins arrondis
          ),
          title: const Text(
            'Bienvenue Sur German Language!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF005D80),
            ),
          ),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Entrez votre nom',
              labelStyle: TextStyle(color: Color(0xFF005D80)),
              hintText: 'Nom complet',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF005D80), width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF005D80), width: 2.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fermer le Dialog
                _saveName();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Color(0xFF005D80), // Fond bleu
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'Valider',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Sauvegarder le nom dans SharedPreferences
  Future<void> _saveName() async {
    final String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstLaunch == null) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF005D80), Color(0xFF01799B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image centrée
                Image.asset(
                  'assets/img/logo.png',
                  height: 150,
                ),
                const SizedBox(height: 16),

                // SpinKit
                const SpinKitChasingDots(
                  color: Colors.white,
                  size: 60.0,
                ),

                const SizedBox(height: 16),

                // Texte animé
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'German Language Initializing...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return isFirstLaunch! ? const LandingUserPage() : const NavigationHomePage();
  }
}
