import 'package:flutter/material.dart';
import 'package:streamapp/actionPages.dart';
import 'package:streamapp/home.dart';
// import 'package:streamapp/drame.dart';
import 'package:streamapp/homePage.dart';
import 'login.dart';
import 'signup.dart';
import 'forgot_password.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream & Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.indigo[800], fontSize: 16),
          titleLarge: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/Accueil',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/profile': (context) => ProfilePage(),
        '/home': (context) => homePage(),
        '/action': (context) => actionPage(),
        '/Accueil':(context)=>home(),
        // '/drame': (context) => dramePage(), // Uncomment if needed
      },
    );
  }
}

// Classe pour les routes animées
class AnimatedRouteWrapper extends PageRouteBuilder {
  final Widget page;
  AnimatedRouteWrapper({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}

// Utilitaire pour la navigation avec animation
class NavigationUtils {
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(context, AnimatedRouteWrapper(page: page));
  }

  static void replaceWithPage(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, AnimatedRouteWrapper(page: page));
  }
}
