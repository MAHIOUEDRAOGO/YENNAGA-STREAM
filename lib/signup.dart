import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Récupérer la largeur et la hauteur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Fond dégradé
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.red.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculer la largeur de la bande en fonction de la taille de l'écran
                  final containerWidth = screenWidth > 600
                      ? 500.0 // Conversion explicite en double
                      : (screenWidth * 0.9).toDouble(); // Conversion explicite en double

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      CircleAvatar(
                        radius: screenWidth * 0.12, // Ajuster la taille du logo
                        backgroundColor: Colors.red.shade700,
                        child: Icon(
                          Icons.person_add,
                          size: screenWidth * 0.12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      // Bande arrondie
                      Container(
                        width: containerWidth, // Utilisation de containerWidth corrigé
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.04,
                          horizontal: screenWidth * 0.06,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Titre
                            Text(
                              'Créer un compte',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: screenWidth * 0.07,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'Rejoignez-nous pour commencer votre aventure',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            // Champ username
                            TextField(
                              controller: usernameController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade800,
                                labelText: 'Nom d\'utilisateur',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.person, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Champ email
                            TextField(
                              controller: emailController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade800,
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.email, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Champ mot de passe
                            TextField(
                              controller: passwordController,
                              obscureText: !_isPasswordVisible,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade800,
                                labelText: 'Mot de passe',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock, color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Champ confirmation mot de passe
                            TextField(
                              controller: confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade800,
                                labelText: 'Confirmer le mot de passe',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock, color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            // Bouton inscription
                            ElevatedButton(
                              onPressed: () {
                                // Ajouter la logique d'inscription
                                Navigator.pushReplacementNamed(context, '/home');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02,
                                  horizontal: screenWidth * 0.2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'S\'inscrire',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            // Texte "Déjà inscrit"
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Déjà un compte ? Connectez-vous',
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
