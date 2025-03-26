import 'package:flutter/material.dart';
import 'package:napas/pages/admin-login.dart'; // Admin login import
import 'package:napas/pages/home_page.dart';
import 'package:napas/pages/login_page.dart';
import 'package:napas/services/AuthService.dart'; // AuthService for authentication check

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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent, // Style for AppBar across the app
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent, // Style for buttons
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Default text color
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: '/splash', // Set the SplashScreen route as the starting point
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/admin-login': (context) => AdminLoginPage(), // Admin login route
        '/splash': (context) => SplashScreen(), // SplashScreen route
        '/admin-dashboard': (context) => AdminDashboardPage(), // Admin Dashboard route
        '/admin/manage-users': (context) => ManageUsersPage(), // Manage Users route
        '/admin/manage-pets': (context) => ManagePetsPage(), // Manage Pets route
        '/admin/manage-donations': (context) => ManageDonationsPage(), // Manage Donations route
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/admin-dashboard') {
          return MaterialPageRoute(builder: (context) => AdminDashboardPage());
        }
        return null; // Fallback to onUnknownRoute
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => ErrorPage(), // Show an error page for unknown routes
        );
      },
    );
  }
}

// SplashScreen: Checking user authentication status and redirecting accordingly
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
        Navigator.pushReplacementNamed(context, '/admin-dashboard'); // Navigate to Admin Dashboard if authenticated
      } else {
        Navigator.pushReplacementNamed(context, '/login'); // Navigate to Login page if not authenticated
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Opacity(
          opacity: 1.0, // Full opacity for the splash screen
          child: Container(
            decoration: BoxDecoration(
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
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                // Tagline below the shelter name
                Text(
                  'Rescue. Rehabilitate. Rehome.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
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

// Admin Dashboard Page
class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to the Admin Dashboard!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Manage the following sections:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin/manage-users');
              },
              child: Text("Manage Users"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin/manage-pets');
              },
              child: Text("Manage Pets"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin/manage-donations');
              },
              child: Text("Manage Donations"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Manage Users Page
class ManageUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Users")),
      body: Center(child: Text("User Management Page")),
    );
  }
}

// Manage Pets Page
class ManagePetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Pets")),
      body: Center(child: Text("Pet Management Page")),
    );
  }
}

// Manage Donations Page
class ManageDonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Donations")),
      body: Center(child: Text("Donation Management Page")),
    );
  }
}

// Error Page for undefined routes
class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error")),
      body: Center(child: Text("Page Not Found!")),
    );
  }
}
