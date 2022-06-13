import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frigider_virtual/models/ingredient.dart';

class Recipe {
  String? id;
  String name;
  String description;
  int preparationTime;
  Timestamp createdAt;
  Timestamp updatedAt;
  List<Ingredient> ingredients;

  Recipe(
    this.id,
    this.name,
    this.description,
    this.preparationTime,
    this.createdAt,
    this.updatedAt,
    this.ingredients,
  );

  String get getPreparationTime {
    var preparationTimeAsString = preparationTime.toString();
    return "${preparationTimeAsString.substring(0, 2)}h${preparationTimeAsString.substring(2, 4) == "00" ? "" : "${preparationTimeAsString.substring(2, 4)}min"}${preparationTimeAsString.substring(4, 6) == "00" ? "" : "${preparationTimeAsString.substring(4, 6)}s"}";
  }

  factory Recipe.fromMap(Map<String, dynamic>? map) {
    return Recipe(
      map!['id'] as String?,
      map['name'] as String,
      map['description'] as String,
      map['preparation_time'] as int,
      map['created_at'] as Timestamp,
      map['updated_at'] as Timestamp,
      (map['ingredients'] as List<Ingredient>?) ?? <Ingredient>[],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'preparation_time': preparationTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'ingredients': ingredients,
    };
  }

  Map<String, dynamic> toMapWithoutIdAndIngredients() {
    return {
      'name': name,
      'description': description,
      'preparation_time': preparationTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  Map<String, dynamic> ingredientsToMap() {
    return {
      'ingredients': ingredients,
    };
  }
}
