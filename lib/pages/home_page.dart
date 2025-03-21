import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adoption_request_page.dart';
import 'donation_page.dart';
import 'login_page.dart';
import 'pet_list_page.dart';
import 'volunteer_page.dart';

class HomePage extends StatelessWidget {
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Noah’s Ark Dog and Cat Shelter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Noah’s Ark Dog and Cat Shelter',
                applicationVersion: '1.0.0',
                children: [
                  Text(
                    'Noah’s Ark is a non-profit animal shelter dedicated to providing care, rehabilitation, and rehoming for abandoned and rescued dogs and cats.',
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Welcome to Noah’s Ark Dog and Cat Shelter!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              "Explore our services, adopt a pet, volunteer, or donate to support our mission.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildFeatureCard(
                    context,
                    "Available Pets",
                    Icons.pets,
                    PetListPage(),
                  ),
                  _buildFeatureCard(
                    context,
                    "Adopt a Pet",
                    Icons.favorite,
                    AdoptionRequestPage(),
                  ),
                  _buildFeatureCard(
                    context,
                    "Donate",
                    Icons.monetization_on,
                    DonationPage(),
                  ),
                  _buildFeatureCard(
                    context,
                    "Volunteer",
                    Icons.volunteer_activism,
                    VolunteerPage(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => logout(context),
              child: Text("Logout"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
