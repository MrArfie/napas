import 'package:flutter/material.dart';

class FavoritePetsPage extends StatefulWidget {
  @override
  _FavoritePetsPageState createState() => _FavoritePetsPageState();
}

class _FavoritePetsPageState extends State<FavoritePetsPage> {
  // Simulated favorite pets data (In real app, this would be fetched from a backend)
  final List<Map<String, String>> favoritePets = [
    {
      'name': 'Buddy',
      'type': 'Dog',
      'age': '2 years',
      'image': 'assets/images/d1.png', // Replace with your pet images
    },
    {
      'name': 'Mittens',
      'type': 'Cat',
      'age': '1 year',
      'image': 'assets/images/cat2.png', // Replace with your pet images
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorite Pets'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: favoritePets.isEmpty
            ? Center(
                child: Text(
                  'No favorite pets added',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: favoritePets.length,
                itemBuilder: (context, index) {
                  return _buildPetCard(context, favoritePets[index]);
                },
              ),
      ),
    );
  }

  // Function to build each pet card
  Widget _buildPetCard(BuildContext context, Map<String, String> pet) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Navigate to Pet Details Page when a pet is tapped
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
                child: Image.asset(
                  pet['image']!,
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
                    pet['name']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${pet['type']} - ${pet['age']}',
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
  final Map<String, String> pet;

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
            Image.asset(
              pet['image']!,
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
              'Type: ${pet['type']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Age: ${pet['age']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to allow the user to adopt or remove pet from favorites
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
