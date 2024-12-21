import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _controller;
  late Animation<Color?> _backgroundColor1;
  late Animation<Color?> _backgroundColor2;

  @override
  void initState() {
    super.initState();

    // Animation controller for gradient
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundColor1 = ColorTween(
      begin: Colors.black,
      end: Colors.red.shade900,
    ).animate(_controller);

    _backgroundColor2 = ColorTween(
      begin: Colors.red.shade900,
      end: Colors.black,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_backgroundColor1.value!, _backgroundColor2.value!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo animé
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.red.shade700,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      // Bande avec bordures arrondies
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                          children: [
                            // Titre
                            Text(
                              'Bienvenue !',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Connectez-vous pour continuer',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
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
                            SizedBox(height: 20),
                            // Champ mot de passe
                            TextField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
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
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            // Bouton de connexion
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/home');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 100),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Connexion',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Texte supplémentaire dans la bande
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pas encore inscrit ? ',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    'Créer un compte',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/forgot_password');
                              },
                              child: Text(
                                'Mot de passe oublié ?',
                                style: TextStyle(
                                  color: Colors.white70,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
