import 'package:flutter/material.dart';

class AdoptionRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adoption Requests')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('View and manage adoption requests', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Adoption Request List page (not implemented yet)
              },
              child: Text('View Adoption Requests'),
            ),
          ],
        ),
      ),
    );
  }
}
