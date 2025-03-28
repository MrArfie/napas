import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/pet.model.dart'; // Ensure this path is correct
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
  File? _petImage; // Store the selected image file
  List<Pet> pets = []; // List to store the pets

  // Define baseUrl for backend API
  final String baseUrl = 'http://localhost:5000/api/pets';

  // Fetch all pets from the backend
  Future<void> _fetchPets() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> petsJson = json.decode(response.body);
        setState(() {
          pets = petsJson.map((json) => Pet.fromJson(json)).toList();
        });
      } else {
        print("Failed to load pets: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to load pets: $e");
    }
  }

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _petImage = File(pickedFile.path);
      }
    });
  }

  // Function to submit the pet data to the backend
  Future<void> _submitPetData() async {
    print("Add Pet button clicked"); // Debugging to confirm if the button is clicked

    if (_formKey.currentState?.validate() ?? false) {
      print("Form is valid. Proceeding with submission...");

      if (_petImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a pet image')));
        return;
      }

      // Convert the image to a base64 string
      final bytes = await _petImage!.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Prepare the pet data to send to the backend
      final petData = {
        'name': _nameController.text,
        'story': _storyController.text,
        'age': _ageController.text,
        'breed': _breedController.text,
        'vaccinated': _vaccinated,
        'imageUrl': base64Image, // Send the base64 image string
      };

      try {
        // Send a POST request to add the pet to the backend
        final response = await http.post(
          Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(petData),
        );

        print("Response from server: ${response.statusCode}");  // Debugging to check response status

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pet added successfully!')));
          // Refresh the pet list after adding the new pet
          await _fetchPets();

          // Navigate to the Pet List page with the updated pet list
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PetListPage(pets: pets),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add pet')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        print("Error in request: $e");  // Log the error for debugging
      }
    } else {
      print("Form validation failed");
    }
  }

  // Function to delete a pet directly from the backend
  Future<void> _deletePet(String id, int index) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pet deleted successfully')));
        setState(() {
          pets.removeAt(index); // Remove the pet from the list
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete pet')));
      }
    } catch (e) {
      print("Failed to delete pet: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPets(); // Fetch pets when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Pets')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Pet Name
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Pet Name'),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter pet name';
                return null;
              },
            ),
            SizedBox(height: 10),

            // Pet Story
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(labelText: 'Pet Story'),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter a story for the pet';
                return null;
              },
            ),
            SizedBox(height: 10),

            // Pet Age
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Pet Age'),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter pet age';
                return null;
              },
            ),
            SizedBox(height: 10),

            // Pet Breed
            TextFormField(
              controller: _breedController,
              decoration: InputDecoration(labelText: 'Pet Breed'),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter pet breed';
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
                      _vaccinated = value ?? false;
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

            // Display the list of pets
            Expanded(
              child: ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  final pet = pets[index];
                  return ListTile(
                    title: Text(pet.name),
                    subtitle: Text("${pet.breed} - ${pet.age}"),
                    leading: pet.imageUrl.isNotEmpty
                        ? Image.memory(base64Decode(pet.imageUrl), width: 50, height: 50) // Display image from base64
                        : Icon(Icons.image_not_supported),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deletePet(pet.id, index), // Delete pet on click
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
