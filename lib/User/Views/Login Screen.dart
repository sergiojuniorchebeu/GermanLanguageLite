import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widget/Navigation.dart';
import 'Singup.dart';
import 'forgot password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF256D85),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/img/logo.png',
                height: 150,
              ),
              const SizedBox(height: 20),
        
              Text(
                "Rejoignez-nous maintenant\net commencez à apprendre",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
        
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
              const SizedBox(height: 10),
        
              // Lien mot de passe oublié
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
                  },
                  child: Text(
                    "Mot de passe oublié ?",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFB3E5FC),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
        
              // Bouton Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationHomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    "Login",
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
                      onPressed: () {},
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
                      onPressed: () {},
                      icon: Image.asset('assets/img/google.png', width: 50,),
                      iconSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
        
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                },
                child: Text.rich(
                  TextSpan(
                    text: "Pas encore membre ? ",
                    style: GoogleFonts.poppins(color: Colors.white),
                    children: [
                      TextSpan(
                        text: "Inscrivez-vous.",
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