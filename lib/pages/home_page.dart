import 'package:flutter/material.dart';
import 'package:napas/models/pet.model.dart'; // Import Pet model
import 'package:napas/services/PetService.dart'; // Import PetService
import 'package:shared_preferences/shared_preferences.dart';

import 'donation_page.dart'; // Import Donation Page
import 'favorite_pets_page.dart'; // Import Favorite Pets Page
import 'login_page.dart'; // Import Login Page for navigation
import 'pet_list_page.dart'; // Import PetListPage
import 'volunteer_page.dart'; // Import Volunteer Page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected tab

  final PetService _petService = PetService();  // Initialize PetService
  List<Pet> pets = []; // Store the list of pets

  @override
  void initState() {
    super.initState();
    _fetchPets();  // Fetch pets when the page loads
  }

  // Fetch pets using PetService
  Future<void> _fetchPets() async {
    try {
      pets = await _petService.getPets();
      setState(() {});
    } catch (e) {
      print("Failed to load pets: $e");
    }
  }

  // List of pages for the Bottom Navigation
  final List<Widget> _pages = [
    HomeSection(),  // Home section
    FavoritePetsPage(),  // Favorite pets section
    DonationPage(),  // Donation section
    VolunteerPage(),  // Volunteer section
  ];

  // Function to handle Bottom Navigation change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Handle logout
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noah’s Ark Dog and Cat Shelter'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout, // Logout functionality
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Show the page based on selected index
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'Volunteer',
          ),
        ],
        currentIndex: _selectedIndex, // Current tab index
        onTap: _onItemTapped, // Handle tab change
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,  // Show labels even for unselected items
      ),
    );
  }
}

// Home Section (Main content of Home Page)
class HomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo or Banner Image (Optional)
            Image.asset(
              'assets/images/cat1.png', // Add a banner or logo image here
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            
            // Greeting message
            Text(
              'Welcome to Noah’s Ark Shelter!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Explore the pets available for adoption, manage your favorites, volunteer, or donate to support our shelter.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 40),

            // Buttons to explore available pets, donate, or volunteer (if needed)
            ElevatedButton(
              onPressed: () {
                // Navigate to Pet List and pass the pets list
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetListPage(pets: []), // Pass the pets list to PetListPage
                  ),
                );
              },
              child: Text('Explore Available Pets'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Donation Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonationPage()),
                );
              },
              child: Text('Donate Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Volunteer Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VolunteerPage()),
                );
              },
              child: Text('Become a Volunteer'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
