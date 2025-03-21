import 'package:flutter/material.dart';

class AdoptionRequestPage extends StatefulWidget {
  @override
  _AdoptionRequestPageState createState() => _AdoptionRequestPageState();
}

class _AdoptionRequestPageState extends State<AdoptionRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController petPreferenceController = TextEditingController();

  void _submitAdoptionForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your adoption request has been submitted!')),
      );
      nameController.clear();
      contactController.clear();
      addressController.clear();
      petPreferenceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption Request Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Apply for Pet Adoption',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                'Please fill out the form below to apply for adopting a pet from our shelter.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact Information', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter your contact information' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Home Address', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: petPreferenceController,
                decoration: InputDecoration(labelText: 'Preferred Pet (Optional)', border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitAdoptionForm,
                child: Text('Submit Adoption Request'),
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 45)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
