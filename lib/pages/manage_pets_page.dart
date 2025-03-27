import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'pet_list_page.dart'; // Import the PetListPage

class PetManagementPage extends StatefulWidget {
  @override
  _PetManagementPageState createState() => _PetManagementPageState();
}

class _PetManagementPageState extends State<PetManagementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  bool _vaccinated = false;
  File? _petImage;  // Store the selected image file

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _petImage = File(pickedFile.path);
      }
    });
  }

  // Function to submit the pet data
  Future<void> _submitPetData() async {
    if (_formKey.currentState!.validate()) {
      if (_petImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a pet image')));
        return;
      }

      // Process and save pet data (upload image, save pet details to database)
      // For now, we'll simulate this by showing a success message and navigating to the Pet List Page
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pet added successfully!')));

      // Navigate to the Pet List page with the new pet data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PetListPage(), // Navigate to PetListPage
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Pet')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Pet Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Pet Name'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter pet name';
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Pet Story
              TextFormField(
                controller: _storyController,
                decoration: InputDecoration(labelText: 'Pet Story'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a story for the pet';
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Pet Age
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Pet Age'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter pet age';
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Pet Breed
              TextFormField(
                controller: _breedController,
                decoration: InputDecoration(labelText: 'Pet Breed'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter pet breed';
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Vaccinated Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _vaccinated,
                    onChanged: (value) {
                      setState(() {
                        _vaccinated = value!;
                      });
                    },
                  ),
                  Text('Vaccinated'),
                ],
              ),
              SizedBox(height: 10),

              // Pick Image Button
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Pet Image'),
              ),
              if (_petImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.file(
                    _petImage!,
                    width: 100,
                    height: 100,
                  ),
                ),

              // Submit Button
              ElevatedButton(
                onPressed: _submitPetData,
                child: Text('Add Pet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
