import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pet.model.dart';

class PetService {
  final String baseUrl = 'http://localhost:5000/api/pets'; // Your backend API URL

  // Fetch all pets
  Future<List<Pet>> getPets() async {
    try {
      final response = await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> petsJson = json.decode(response.body);
        return petsJson.map((json) => Pet.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load pets. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load pets: $e');
    }
  }

  // Add a new pet
  Future<Pet> addPet(Pet pet) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pet.toJson()),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return Pet.fromJson(json.decode(response.body));
      } else {
        print('Response body: ${response.body}'); // Log the response body for debugging
        throw Exception('Failed to add pet. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add pet: $e');
    }
  }

  // Delete a pet
  Future<void> deletePet(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id')).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete pet. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete pet: $e');
    }
  }

  // Mark a pet as adopted
  Future<Pet> markAsAdopted(String id) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$id/adopt'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Pet.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to mark pet as adopted. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to mark pet as adopted: $e');
    }
  }
}