import 'package:flutter/material.dart';

class AddDonationPage extends StatefulWidget {
  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _donorNameController = TextEditingController();
  TextEditingController _donationAmountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission logic, like sending data to backend
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Donation added successfully!')));
      // Reset form
      _donorNameController.clear();
      _donationAmountController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Donor Name Field
              TextFormField(
                controller: _donorNameController,
                decoration: InputDecoration(labelText: 'Donor Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the donor\'s name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Donation Amount Field
              TextFormField(
                controller: _donationAmountController,
                decoration: InputDecoration(labelText: 'Donation Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the donation amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description (Optional)'),
                maxLines: 3,
                validator: (value) {
                  // No validation required for description
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
