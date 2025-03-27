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
        backgroundColor: Colors.blueAccent,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      child: InkWell(
        onTap: () {
          // Show pet details in modal
          _showPetDetailsModal(context, pet);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  pet['imageUrl'],
                  width: double.infinity,
                  height: 180,
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

  // Function to show the pet details modal
  void _showPetDetailsModal(BuildContext context, Map<String, dynamic> pet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${pet['name']} - Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  pet['imageUrl'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text('Breed: ${pet['breed']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Age: ${pet['age']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Vaccinated: ${pet['vaccinated'] ? 'Yes' : 'No'}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Story: ${pet['story']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Adoption Request Form
                    Navigator.pop(context); // Close the modal
                    _showAdoptionForm(context, pet);
                  },
                  child: Text('Adopt ${pet['name']}'),
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to show the adoption form
  void _showAdoptionForm(BuildContext context, Map<String, dynamic> pet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adopt ${pet['name']}'),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Your Name'),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Contact Information'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Simulate sending the adoption request
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Adoption request submitted!')));
                    Navigator.pop(context); // Close the adoption form modal
                  },
                  child: Text('Submit Adoption Request'),
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
