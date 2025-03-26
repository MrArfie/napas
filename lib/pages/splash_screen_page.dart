import 'package:flutter/material.dart';
import 'package:napas/pages/admin-login.dart';
import 'package:napas/pages/get_started_page.dart';
import 'package:napas/pages/home_page.dart';
import 'package:napas/pages/login_page.dart';
import 'package:napas/pages/register_page.dart';
import 'package:napas/services/AuthService.dart'; // Assuming you have an AuthService for authentication check

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noah’s Ark Dog and Cat Shelter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),  // Set SplashScreen as the first screen
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
        '/admin-login': (context) => AdminLoginPage(), // Admin login route
        '/get-started': (context) => GetStartedPage(),  // Add the get started route
      },
    );
  }
}

// Your original SplashScreen page
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Check if the user is logged in
  _checkLoginStatus() async {
    final authService = AuthService();
    bool isAuthenticated = await authService.isAuthenticated();
    Future.delayed(Duration(seconds: 2), () {
      if (isAuthenticated) {
        // Navigate to the HomePage if authenticated
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Navigate to the LoginPage if not authenticated
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set transparent background for gradient
      body: Center(
        child: Opacity(
          opacity: 1.0, // Full opacity for the splash screen
          child: Container(
            decoration: BoxDecoration(
              // Adding a gradient background with yellow and green shades
              gradient: LinearGradient(
                colors: [Colors.yellow, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo with fade-in effect
                Image.asset(
                  'assets/images/logo.jpg', // Replace with your logo path
                  width: 300,
                  height: 200,
                ),
                SizedBox(height: 20),
                // App name with bold and friendly font
                Text(
                  'Noah\'s Ark Dog and Cat Shelter',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color set to white for contrast
                  ),
                ),
                SizedBox(height: 10),
                // Tagline below the shelter name
                Text(
                  'Rescue. Rehabilitate. Rehome.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70, // Lighter color for tagline
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
