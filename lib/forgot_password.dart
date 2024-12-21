import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  bool _isSending = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Configuration des animations
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_animationController);
  }

  @override
  void dispose() {
    emailController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    final email = emailController.text.trim();
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showSnackBar('Veuillez entrer une adresse e-mail valide.');
      return;
    }

    setState(() {
      _isSending = true;
    });

    // Simuler l'envoi d'un e-mail
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSending = false;
      });
      _showSnackBar('Un lien de réinitialisation a été envoyé à $email.');
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond dégradé
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.red.shade900],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo animé avec effet pulsation
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.lock_reset,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // Texte principal
                      Text(
                        'Mot de Passe Oublié',
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
                        'Entrez votre e-mail pour recevoir un lien de réinitialisation.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // Champ d'entrée
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: TextField(
                          controller: emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade800,
                            labelText: 'Adresse e-mail',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Bouton d'envoi
                      ElevatedButton(
                        onPressed: _isSending ? null : _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: _isSending
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Envoyer',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(height: 20),
                      // Retour à la connexion
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          'Retour à la connexion',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
