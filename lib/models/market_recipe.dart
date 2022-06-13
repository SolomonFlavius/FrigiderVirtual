
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ingredient.dart';

class MarketRecipe {
  String? id;
  String name;
  String preparationTime;
  double overallRating;
  int totalRatings;
  String description;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? createdBy;
  List<Ingredient> ingredients;

  MarketRecipe(
      this.id,
      this.name,
      this.preparationTime,
      this.overallRating,
      this.totalRatings,
      this.description,
      this.ingredients, {
        this.createdAt,
        this.updatedAt,
        this.createdBy
      });

  factory MarketRecipe.fromMap(Map<String, dynamic>? map) {
    return MarketRecipe(
      map!['id'] as String?,
      map['name'] as String,
      map['preparation_time'] as String,
      map['overall_rating'] as double,
      map['total_ratings'] as int,
      map['description'] as String,
      map['ingredients'] as List<Ingredient>,
      createdAt: map['created_at'] as Timestamp?,
      updatedAt: map['updated_at'] as Timestamp?,
      createdBy: map['created_by'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'preparation_time': preparationTime,
      'overall_rating': overallRating,
      'total_ratings': totalRatings,
      'description': description,
      'ingredients': ingredients,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'name': name,
      'preparation_time': preparationTime,
      'overall_rating': overallRating,
      'total_ratings': totalRatings,
      'description': description,
      'ingredients': ingredients,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
    };
  }

}
