import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'EditProfilePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  String email = "user@example.com";
  String username = "User123";
  File? _profileImage;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Index actif pour le BottomNavigationBar
  int _currentIndex = 2; // Index correspondant à la page "Profil"

  // Exemple d'activités récentes
  List<Map<String, String>> recentActivities = [
    {"title": "Completed Task 1", "details": "Details about task 1."},
    {"title": "Completed Task 2", "details": "Details about task 2."},
    {"title": "Joined a new project", "details": "Details about the project."},
  ];

  @override
  void initState() {
    super.initState();
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
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  Future<void> _navigateToEditProfile() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentUsername: username,
          currentEmail: email,
        ),
      ),
    );

    if (updatedData != null) {
      setState(() {
        username = updatedData['username'];
        email = updatedData['email'];
      });
    }
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home'); // Page "Acceuil"
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/genre'); // Page "Genre"
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/favorites'); // Page "Favoris"
    }
  }

  Widget _buildActivityCard(String title, String details) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.red.shade400,
        child: ListTile(
          leading: Icon(Icons.check_circle, color: Colors.white),
          title: Text(title, style: TextStyle(color: Colors.white)),
          subtitle: Text(details, style: TextStyle(color: Colors.white70)),
        ),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Déconnexion
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.logout, color: Colors.red),
                        onPressed: _logout,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Photo de profil animée
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => BottomSheet(
                            onClosing: () {},
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera_alt,
                                      color: Colors.white),
                                  title: Text('Take a Photo',
                                      style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo_library,
                                      color: Colors.white),
                                  title: Text('Choose from Gallery',
                                      style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            backgroundColor: Colors.black,
                          ),
                        );
                      },
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0)
                            .animate(_animationController),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.red,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                          child: _profileImage == null
                              ? Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Nom et email
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            username,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            email,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Bouton modifier
                    ElevatedButton(
                      onPressed: _navigateToEditProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Activités récentes
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recent Activities',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: recentActivities
                          .map((activity) =>
                              _buildActivityCard(activity["title"]!,
                                  activity["details"]!))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Genre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black,
      ),
    );
  }
}
