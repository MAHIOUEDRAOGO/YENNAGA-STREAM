import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  final String currentUsername;
  final String currentEmail;

  EditProfilePage({required this.currentUsername, required this.currentEmail});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.currentUsername);
    emailController = TextEditingController(text: widget.currentEmail);
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    // Initialisation de l'animation
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        newPasswordController.text != confirmPasswordController.text) {
      _shakeError();
      return;
    }

    Navigator.pop(context, {
      'username': usernameController.text,
      'email': emailController.text,
    });
  }

  void _shakeError() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.red),
            onPressed: _saveChanges,
          ),
        ],
      ),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      // Champ d'édition (Username)
                      _buildTextField(
                        controller: usernameController,
                        labelText: 'Username',
                        icon: Icons.person,
                      ),
                      SizedBox(height: 16),
                      // Champ d'édition (Email)
                      _buildTextField(
                        controller: emailController,
                        labelText: 'Email',
                        icon: Icons.email,
                      ),
                      SizedBox(height: 16),
                      // Champ pour l'ancien mot de passe
                      _buildPasswordField(
                        controller: oldPasswordController,
                        labelText: 'Old Password',
                        isVisible: _isOldPasswordVisible,
                        onVisibilityToggle: () {
                          setState(() {
                            _isOldPasswordVisible = !_isOldPasswordVisible;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      // Champ pour le nouveau mot de passe
                      _buildPasswordField(
                        controller: newPasswordController,
                        labelText: 'New Password',
                        isVisible: _isNewPasswordVisible,
                        onVisibilityToggle: () {
                          setState(() {
                            _isNewPasswordVisible = !_isNewPasswordVisible;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      // Champ pour confirmer le nouveau mot de passe
                      _buildPasswordField(
                        controller: confirmPasswordController,
                        labelText: 'Confirm Password',
                        isVisible: _isConfirmPasswordVisible,
                        onVisibilityToggle: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      // Bouton "Save Changes"
                      ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.red.shade700,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.red.shade700,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.lock, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: onVisibilityToggle,
        ),
      ),
    );
  }
}
