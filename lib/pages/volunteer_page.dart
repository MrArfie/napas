import 'package:flutter/material.dart';

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  bool availability = false;

  void _submitVolunteerForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thank you for signing up, ${nameController.text}!')),
      );
      nameController.clear();
      contactController.clear();
      skillsController.clear();
      setState(() {
        availability = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Join Our Volunteer Team',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                'Help us take care of rescued animals by volunteering your time and skills.',
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
                controller: skillsController,
                decoration: InputDecoration(labelText: 'Skills (Optional)', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: availability,
                    onChanged: (value) {
                      setState(() {
                        availability = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text('I am available for volunteering immediately'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitVolunteerForm,
                child: Text('Sign Up as Volunteer'),
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 45)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
