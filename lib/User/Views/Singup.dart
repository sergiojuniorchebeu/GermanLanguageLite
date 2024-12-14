import 'package:flutter/material.dart';
import 'package:projet2/User/Views/Login%20Screen.dart';
import 'package:google_fonts/google_fonts.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF256D85),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/img/logo.png',
                height: 120,
              ),
              const SizedBox(height: 20),
        
              Text(
                "Créer un compte",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF173E4F),
                  hintText: "Noms",
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF173E4F),
                  hintText: "Prenoms",
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Adresse e-mail
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF173E4F),
                  hintText: "Adresse e-mail",
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
        
              // Mot de passe
              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF173E4F),
                  hintText: "Mot de passe",
                  hintStyle: const TextStyle(color: Colors.white70),
                  suffixIcon: const Icon(Icons.visibility, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF173E4F),
                  hintText: "Confirmer le Mot de passe",
                  hintStyle: const TextStyle(color: Colors.white70),
                  suffixIcon: const Icon(Icons.visibility, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
        
              // Bouton Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    "S'inscrire",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
        
              // Texte "Or"
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: Colors.white70, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Colors.white70, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 20),
        
              // Boutons sociaux
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF173E4F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 110,
                    child: IconButton(
                      onPressed: () {

                      },
                      icon: Image.asset('assets/img/facebook.png', width: 50,),
                      iconSize: 10,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF173E4F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 110,
                    child: IconButton(
                      onPressed: () {

                      },
                      icon: Image.asset('assets/img/google.png', width: 50,),
                      iconSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
        
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                },
                child: Text.rich(
                  TextSpan(
                    text: " Déjà membre ? ",
                    style: GoogleFonts.poppins(color: Colors.white),
                    children: [
                      TextSpan(
                        text: "Connectez-vous.",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFB3E5FC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
