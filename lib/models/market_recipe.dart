import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frigider_virtual/models/ingredient.dart';
import 'package:frigider_virtual/models/recipe.dart';
import 'package:frigider_virtual/models/user.dart';

class MarketRecipe extends Recipe {
  num overallRating;
  num totalRatings;
  DocumentReference createdBy;

  MarketRecipe(
    String? id,
    String name,
    String description,
    int preparationTime,
    Timestamp createdAt,
    Timestamp updatedAt,
    this.overallRating,
    this.totalRatings,
    this.createdBy,
    List<Ingredient> ingredients,
  ) : super(id, name, description, preparationTime, createdAt, updatedAt,
            ingredients);

  factory MarketRecipe.fromRecipe(
      Recipe recipe, DocumentReference userReference) {
    return MarketRecipe(
      null,
      recipe.name,
      recipe.description,
      recipe.preparationTime,
      recipe.createdAt,
      recipe.updatedAt,
      0,
      0,
      userReference,
      recipe.ingredients,
    );
  }

  factory MarketRecipe.fromMap(Map<String, dynamic>? map) {
    return MarketRecipe(
      map!['id'] as String?,
      map['name'] as String,
      map['description'] as String,
      map['preparation_time'] as int,
      map['created_at'] as Timestamp,
      map['updated_at'] as Timestamp,
      map['overall_rating'] as num,
      map['total_ratings'] as num,
      map['created_by'] as DocumentReference,
      (map['ingredients'] as List<Ingredient>?) ?? <Ingredient>[],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'preparation_time': preparationTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'overall_rating': overallRating,
      'total_ratings': totalRatings,
      'created_by': createdBy,
      'ingredients': ingredients,
    };
  }

  @override
  Map<String, dynamic> toMapWithoutIdAndIngredients() {
    return {
      'name': name,
      'description': description,
      'preparation_time': preparationTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'overall_rating': overallRating,
      'total_ratings': totalRatings,
      'created_by': createdBy,
    };
  }
}
