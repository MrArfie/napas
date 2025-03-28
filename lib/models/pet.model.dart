class Pet {
  String id;          // Unique identifier for the pet
  String name;        // Name of the pet
  String story;       // Story about the pet
  int age;           // Age of the pet (changed to int)
  String breed;       // Breed of the pet
  bool vaccinated;    // Vaccination status
  String imageUrl;    // Base64 encoded image data

  // Constructor
  Pet({
    required this.id,
    required this.name,
    required this.story,
    required this.age,
    required this.breed,
    required this.vaccinated,
    required this.imageUrl,
  });

  // Method to convert Pet object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'story': story,
      'age': age,
      'breed': breed,
      'vaccinated': vaccinated,
      'imageUrl': imageUrl,
    };
  }

  // Factory constructor to create a Pet object from JSON data
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      story: json['story'] ?? '',
      age: json['age'] != null ? json['age'] is int ? json['age'] : int.tryParse(json['age'].toString()) ?? 0 : 0, // Ensure age is an int
      breed: json['breed'] ?? '',
      vaccinated: json['vaccinated'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Pet{id: $id, name: $name, story: $story, age: $age, breed: $breed, vaccinated: $vaccinated, imageUrl: $imageUrl}';
  }
}