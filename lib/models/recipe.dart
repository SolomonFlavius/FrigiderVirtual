import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredients {
  String? name;
  int? quantity;
  String? quantityMeasure;
}

class Recipe {
  String? id;
  String description;
  String name;
  int? preparationTime;
  Timestamp? updatedAt;
  Timestamp? createdAt;
  List<Ingredients> ingredients;

  Recipe(this.id, this.description, this.name, this.ingredients,
      {this.preparationTime, this.updatedAt, this.createdAt});

  factory Recipe.fromMap(Map<String, dynamic>? map) {
    return Recipe(map!['id'] as String?, map['description'] as String,
        map['name'] as String, map['ingredients'] as List<Ingredients>,
        preparationTime: map['preparationTime'] as int?,
        updatedAt: map['updated_at'] as Timestamp?,
        createdAt: map['created_at'] as Timestamp?);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'name': name,
      'preparationTime': preparationTime,
      'ingredients': ingredients,
      'updated_at': updatedAt,
      'created_at': createdAt
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'description': description,
      'name': name,
      'preparationTime': preparationTime,
      'ingredients': ingredients,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
