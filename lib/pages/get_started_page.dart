import 'package:flutter/material.dart';

import 'home_page.dart'; // Import HomePage

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent background for gradient
      appBar: AppBar(
        title: Text('Get Started'),
        backgroundColor: Colors.blueAccent, // App bar color matching the background
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or Image (Optional)
              Image.asset(
                'assets/images/24.gif', // Replace with your logo path
                width: 200,
                height: 200,
              ),
              SizedBox(height: 30),

              // Title with Text Animation
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: Text(
                  'Welcome to Noah\'s Ark Dog and Cat Shelter!',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),

              // Description Text
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                child: Text(
                  'At Noah\'s Ark, we are dedicated to rescuing and rehabilitating abandoned dogs and cats, '
                  'providing them with a safe, loving environment. Your involvement helps us make a difference. '
                  '\n\nAdopt a pet, donate, volunteer, or simply spread the word to help our furry friends.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),

              // Ways to contribute
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.pets, color: Colors.white),
                    title: Text(
                      'Adopt a Pet',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.volunteer_activism, color: Colors.white),
                    title: Text(
                      'Become a Volunteer',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on, color: Colors.white),
                    title: Text(
                      'Donate to Support Our Shelter',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Get Started Button with Animation
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 4), // Shadow effect
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to HomePage after clicking 'Get Started'
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, foregroundColor: Colors.blueAccent, // Text colorbackgroundColor
                    minimumSize: Size(double.infinity, 50),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
