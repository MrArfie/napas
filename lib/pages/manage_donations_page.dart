import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DonationManagementPage extends StatefulWidget {
  @override
  _DonationManagementPageState createState() => _DonationManagementPageState();
}

class _DonationManagementPageState extends State<DonationManagementPage> {
  List<dynamic> donations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDonations();  // Fetch donations from the backend when the page is initialized
  }

  // Fetch donations from the backend
  Future<void> fetchDonations() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/donations'));
      if (response.statusCode == 200) {
        setState(() {
          donations = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load donations')));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Function to handle deleting a donation
  Future<void> deleteDonation(String donationId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:5000/api/donations/$donationId'),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Donation deleted successfully')));
        fetchDonations();  // Refresh the donation list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete donation')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent, // Use a cute color for the app bar
        title: Text(
          'Donation Management',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDonationPage()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  // Show loading spinner while fetching data
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: donations.length,
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
                        'Donor: ${donations[index]['donorName']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      subtitle: Text(
                        'Amount: \$${donations[index]['amount']}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteDonation(donations[index]['id']);
                        },
                      ),
                      onTap: () {
                        // Navigate to Edit Donation Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDonationPage(donation: donations[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class AddDonationPage extends StatefulWidget {
  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  final _formKey = GlobalKey<FormState>();
  final _donorNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  // Function to add a new donation
  Future<void> addDonation() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter valid details')));
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:5000/api/donations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'donorName': _donorNameController.text,
        'amount': double.parse(_amountController.text),
        'date': _dateController.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Donation added successfully')));
      Navigator.pop(context);  // Go back to Donation Management Page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add donation')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Donation')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _donorNameController,
                decoration: InputDecoration(labelText: 'Donor Name'),
                validator: (value) => value!.isEmpty ? 'Please enter the donor\'s name' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter the donation amount' : null,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) => value!.isEmpty ? 'Please enter the donation date' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addDonation,
                child: Text('Add Donation'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: const Color.fromARGB(255, 120, 155, 143),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditDonationPage extends StatefulWidget {
  final Map<String, dynamic> donation;

  EditDonationPage({required this.donation});

  @override
  _EditDonationPageState createState() => _EditDonationPageState();
}

class _EditDonationPageState extends State<EditDonationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _donorNameController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _donorNameController = TextEditingController(text: widget.donation['donorName']);
    _amountController = TextEditingController(text: widget.donation['amount'].toString());
    _dateController = TextEditingController(text: widget.donation['date']);
  }

  // Function to update the donation
  Future<void> updateDonation() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter valid details')));
      return;
    }

    final response = await http.put(
      Uri.parse('http://localhost:5000/api/donations/${widget.donation['id']}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'donorName': _donorNameController.text,
        'amount': double.parse(_amountController.text),
        'date': _dateController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Donation updated successfully')));
      Navigator.pop(context);  // Go back to Donation Management Page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update donation')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Donation')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _donorNameController,
                decoration: InputDecoration(labelText: 'Donor Name'),
                validator: (value) => value!.isEmpty ? 'Please enter the donor\'s name' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter the donation amount' : null,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) => value!.isEmpty ? 'Please enter the donation date' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateDonation,
                child: Text('Update Donation'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: const Color.fromARGB(255, 69, 119, 81),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
