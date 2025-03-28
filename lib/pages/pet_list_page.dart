import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/pet.model.dart';
import '../services/PetService.dart';

class PetListPage extends StatefulWidget {
  final List<Pet> pets;  // Accept pets list as a parameter

  // Constructor to pass the pets list
  PetListPage({required this.pets});

  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  final PetService _petService = PetService();
  late List<Pet> pets;  // List to store the pets

  @override
  void initState() {
    super.initState();
    pets = widget.pets;  // Assign passed pets list to the local variable
  }

  // Function to handle pet deletion
  Future<void> _deletePet(Pet pet, int index) async {
    try {
      await _petService.deletePet(pet.id);  // Delete pet via service
      setState(() {
        pets.removeAt(index);  // Remove the pet from the list
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pet deleted successfully")));
    } catch (e) {
      print("Failed to delete pet: $e");  // Handle errors properly
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete pet")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet List"),
      ),
      body: pets.isEmpty
          ? Center(child: CircularProgressIndicator())  // Show loading spinner if no pets are loaded
          : ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];  // Get the current pet
                return ListTile(
                  title: Text(pet.name),  // Display pet name
                  subtitle: Text("${pet.breed} - ${pet.age}"),  // Display breed and age
                  leading: pet.imageUrl.isNotEmpty
                      ? Image.memory(base64Decode(pet.imageUrl), width: 50, height: 50)  // Show image from base64
                      : Icon(Icons.image_not_supported),  // Show icon if no image
                  trailing: IconButton(
                    icon: Icon(Icons.delete),  // Delete icon
                    onPressed: () => _deletePet(pet, index),  // Delete pet
                  ),
                );
              },
            ),
    );
  }
}
