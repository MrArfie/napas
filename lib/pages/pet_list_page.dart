import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PetListPage extends StatefulWidget {
  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<dynamic> pets = []; // List to store the fetched pets
  bool isLoading = true;

  // Fetch pet data from API
  Future<void> fetchPets() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/pets')); // Backend URL to fetch pets
      if (response.statusCode == 200) {
        setState(() {
          pets = json.decode(response.body);
          isLoading = false;
        });
      } else {
        // If fetching fails
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load pets')));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPets(); // Fetch pets when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Pets for Adoption'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching data
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns for grid view
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  return _buildPetCard(context, pets[index]);
                },
              ),
            ),
    );
  }

  // Function to build each pet card
  Widget _buildPetCard(BuildContext context, Map<String, dynamic> pet) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Navigate to Pet Details Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetDetailsPage(pet: pet),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  pet['imageUrl'], // Display pet image from URL
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    pet['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${pet['breed']} - ${pet['age']}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pet Details Page to show more information about the pet
class PetDetailsPage extends StatelessWidget {
  final Map<String, dynamic> pet;

  PetDetailsPage({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pet['name']}\'s Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              pet['imageUrl'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${pet['name']}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Breed: ${pet['breed']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Age: ${pet['age']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Vaccinated: ${pet['vaccinated'] ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Story: ${pet['story']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to allow the user to adopt or favorite the pet
              },
              child: Text('Adopt ${pet['name']}'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
