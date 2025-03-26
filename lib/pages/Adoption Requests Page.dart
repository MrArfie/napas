import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdoptionRequestsPage extends StatefulWidget {
  @override
  _AdoptionRequestsPageState createState() => _AdoptionRequestsPageState();
}

class _AdoptionRequestsPageState extends State<AdoptionRequestsPage> {
  List<dynamic> adoptionRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAdoptionRequests(); // Fetch adoption requests from the backend when the page is initialized
  }

  // Fetch adoption requests from the backend
  Future<void> fetchAdoptionRequests() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/adoptions'));  // Your backend URL to fetch adoption requests
      if (response.statusCode == 200) {
        setState(() {
          adoptionRequests = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load adoption requests')));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Function to approve an adoption request
  Future<void> approveAdoption(String adoptionId) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/adoptions/$adoptionId/approve'),  // Your backend URL to approve adoption
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Adoption approved successfully')));
        fetchAdoptionRequests();  // Refresh the adoption requests list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to approve adoption')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Function to reject an adoption request
  Future<void> rejectAdoption(String adoptionId) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/adoptions/$adoptionId/reject'),  // Your backend URL to reject adoption
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Adoption rejected successfully')));
        fetchAdoptionRequests();  // Refresh the adoption requests list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to reject adoption')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption Requests'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  // Show loading spinner while fetching data
          : ListView.builder(
              itemCount: adoptionRequests.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Applicant: ${adoptionRequests[index]['applicant']['name']}'),
                  subtitle: Text('Pet: ${adoptionRequests[index]['pet']['name']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          // Approve adoption request
                          approveAdoption(adoptionRequests[index]['id']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          // Reject adoption request
                          rejectAdoption(adoptionRequests[index]['id']);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to Adoption Request Details Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdoptionRequestDetailsPage(adoptionRequest: adoptionRequests[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class AdoptionRequestDetailsPage extends StatelessWidget {
  final Map<String, dynamic> adoptionRequest;
  AdoptionRequestDetailsPage({required this.adoptionRequest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption Request Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Applicant: ${adoptionRequest['applicant']['name']}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${adoptionRequest['applicant']['email']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: ${adoptionRequest['applicant']['phone']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Pet Name: ${adoptionRequest['pet']['name']}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Breed: ${adoptionRequest['pet']['breed']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Age: ${adoptionRequest['pet']['age']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the action to adopt or reject the request
              },
              child: Text('Approve Adoption'),
            ),
          ],
        ),
      ),
    );
  }
}
