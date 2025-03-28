import 'package:flutter/material.dart';

import 'home_page.dart'; // Import HomePage

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Soft background color
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.pets, size: 30, color: Colors.pinkAccent), // Pet Icon
            SizedBox(width: 10),
            Text('Noah\'s Ark Shelter', style: TextStyle(fontSize: 22)),
          ],
        ),
        backgroundColor: Colors.pinkAccent, // Light, welcoming color
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or Image
              Image.asset(
                'assets/images/24.gif', // Replace with your logo path
                width: 180,
                height: 180,
              ),
              SizedBox(height: 30),

              // Title with Text Animation
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                  fontFamily: 'Comfortaa', // Playful, friendly font
                ),
                child: Text(
                  'Welcome to Noah\'s Ark!',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),

              // Description Text
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontFamily: 'Poppins', // Clean and modern font
                ),
                child: Text(
                  'We rescue and rehabilitate abandoned dogs and cats, giving them a second chance at life. '
                  'Join us in our mission to provide a loving home for every pet.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),

              // Ways to contribute (List of contributions)
              Column(
                children: [
                  _buildListTile(Icons.pets, 'Adopt a Pet'),
                  _buildListTile(Icons.volunteer_activism, 'Become a Volunteer'),
                  _buildListTile(Icons.monetization_on, 'Donate to Our Shelter'),
                ],
              ),
              SizedBox(height: 40),

              // Get Started Button with Animation
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 143, 72, 24),
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
                    backgroundColor: Colors.white, // Background color
                    foregroundColor: const Color.fromARGB(255, 226, 224, 225), // Text color
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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

  // Method to build the list tiles
  Widget _buildListTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 64, 255, 150)),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 64, 233, 255),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
