import 'package:flutter/material.dart';

class PetListPage extends StatelessWidget {
  final List<Map<String, String>> pets = [
    {
      'name': 'Buddy',
      'type': 'Dog',
      'age': '2 years',
      'image': 'assets/images/buddy.jpg',
    },
    {
      'name': 'Mittens',
      'type': 'Cat',
      'age': '1 year',
      'image': 'assets/images/mittens.jpg',
    },
    {
      'name': 'Charlie',
      'type': 'Dog',
      'age': '3 years',
      'image': 'assets/images/charlie.jpg',
    },
    {
      'name': 'Whiskers',
      'type': 'Cat',
      'age': '2 years',
      'image': 'assets/images/whiskers.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Pets for Adoption'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
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

  Widget _buildPetCard(BuildContext context, Map<String, String> pet) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
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
            padding: EdgeInsets.all(8),
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
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to adoption request page
                  },
                  child: Text('Adopt'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 35),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
