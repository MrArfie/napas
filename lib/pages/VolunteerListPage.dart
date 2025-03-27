import 'package:flutter/material.dart';

class VolunteerListPage extends StatelessWidget {
  // A static list to simulate the volunteer data
  static List<Map<String, dynamic>> volunteers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: volunteers.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  volunteers[index]['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact: ${volunteers[index]['contact']}'),
                    Text('Skills: ${volunteers[index]['skills']}'),
                    Text('Available Immediately: ${volunteers[index]['availability'] ? 'Yes' : 'No'}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Delete volunteer action (implement the actual deletion logic here)
                    _deleteVolunteer(index);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Simulate deleting a volunteer from the list
  void _deleteVolunteer(int index) {
    volunteers.removeAt(index);
    // Show confirmation message
    print('Volunteer at index $index has been deleted');
  }
}
